require 'tempfile'
require 'fileutils'
require 'shellwords'
require 'bundler'
Bundler.require
HighLine.color_scheme = HighLine::SampleColorScheme.new

task :default => %w[spec:all]

desc "Run default set of tasks"
task :spec => %w[spec:all]

desc "Run internal release process"
task :release => %w[release:assumptions build_demo_apps release:check_working_directory release:bump_version release:lint_podspec release:tag]

desc "Publish code and pod to public github.com"
task :publish => %w[publish:push publish:create_github_release publish:push_pod docs_publish]

SEMVER = /\d+\.\d+\.\d+(-[0-9A-Za-z.-]+)?/
PODSPEC = "BraintreeDropIn.podspec"
DEMO_PLIST = "Demo/Application/Supporting Files/Braintree-Demo-Info.plist"
DROPIN_FRAMEWORKS_PLIST = "Sources/BraintreeDropIn/Info.plist"
PUBLIC_REMOTE_NAME = "origin"

class << self
  def run cmd
    say(HighLine.color("$ #{cmd}", :debug))
    File.popen(cmd) { |file|
      if block_given?
        result = ''
        result << file.gets until file.eof?
        yield result
      else
        puts file.gets until file.eof?
      end
    }
    $? == 0
  end

  def run! cmd
    run(cmd) or fail("Command failed with non-zero exit status #{$?}:\n$ #{cmd}")
  end

  def current_version
    File.read(PODSPEC)[SEMVER]
  end

  def current_version_with_sha
    %x{git describe}.strip
  end

  def current_branch
    %x{git rev-parse --abbrev-ref HEAD}.strip
  end

  def xcodebuild(scheme, command, configuration, ios_version, options={}, output_redirect=nil)
    default_options = {
      :build_settings => {}
    }
    ios_version_specifier = ",OS=#{ios_version}" if !ios_version.nil?
    options = default_options.merge(options)
    build_settings = options[:build_settings].map{|k,v| "#{k}='#{v}'"}.join(" ")
    return "set -o pipefail && xcodebuild -workspace 'BraintreeDropIn.xcworkspace' -sdk 'iphonesimulator' -configuration '#{configuration}' -scheme '#{scheme}' -destination 'name=iPhone 11,platform=iOS Simulator#{ios_version_specifier}' #{build_settings} #{command} #{output_redirect} | xcpretty"
  end

end

namespace :spec do
  def run_test_scheme! scheme, ios_version = nil, output_redirect = nil
    run! xcodebuild(scheme, 'test', 'Debug', ios_version, {}, output_redirect)
  end

  desc 'Run unit tests'
  task :unit, [:ios_version] do |t, args|
    if args[:ios_version]
      run_test_scheme! 'UnitTests', args[:ios_version]
    else
      run_test_scheme! 'UnitTests'
    end
  end

  desc 'Run UI tests'
  task :ui do
    run_test_scheme! 'UITests'
  end

  desc 'Run all spec schemes'
  task :all => %w[spec:unit spec:ui]
end

namespace :demo_app do
  desc 'Verify that the demo app builds successfully'
  task :build_demo do
    # TODO: Investigate running demo app in Release mode
    run! xcodebuild('Demo', 'build', 'Debug', nil)
  end
end

desc 'SPM tasks'
namespace :spm do
  def update_xcodeproj
    project_file = "SampleApps/SPMTest/SPMTest.xcodeproj/project.pbxproj"
    proj = File.read(project_file)
    proj.gsub!(/(repositoryURL = )(.*);/, "\\1\"file://#{Dir.pwd}/\";")
    proj.gsub!(/(branch = )(.*);/, "\\1\"#{current_branch}\";")
    File.open(project_file, "w") { |f| f.puts proj }
  end

  task :build_demo do
    update_xcodeproj

    # Build SPM demo app
    run! "cd SampleApps/SPMTest && swift package resolve"
    run! "xcodebuild -project 'SampleApps/SPMTest/SPMTest.xcodeproj' -scheme 'SPMTest' clean build"

    # Clean up
    run! 'rm -rf ~/Library/Developers/Xcode/DerivedData'
    run! 'git checkout SampleApps/SPMTest'
  end
end

desc 'Build demo apps per package manager'
task :build_demo_apps => %w[demo_app:build_demo spm:build_demo]

namespace :release do
  desc "Print out pre-release checklist"
  task :assumptions do
    say "Release Assumptions"
    say "* [ ] You have pulled the latest public code from github.com."
    say "* [ ] You are on the branch and commit you want to release."
    say "* [ ] You have already merged hotfixes and pulled changes."
    say "* [ ] You have already reviewed the diff between the current release and the last tag, noting breaking changes in the semver and CHANGELOG."
    say "* [ ] Tests (rake spec) are passing, manual verifications complete."

    abort(1) unless ask "Ready to release? Press any key to continue. "
  end

  desc "Check that working directory is clean"
  task :check_working_directory do
    run! "echo 'Checking for uncommitted changes' && git diff --exit-code"
  end

  desc "Bump version in Podspec"
  task :bump_version do
    say "Current version in Podspec: #{current_version}"
    n = 10
    say "Previous #{n} versions in Git:"
    run "git tag -l | tail -n #{n}"
    version = ask("What version are you releasing?") { |q| q.validate = /\A#{SEMVER}\Z/ }

    podspec = File.read(PODSPEC)
    podspec.gsub!(/(s\.version\s*=\s*)"#{SEMVER}"/, "\\1\"#{version}\"")
    File.open(PODSPEC, "w") { |f| f.puts podspec }

    [DEMO_PLIST, DROPIN_FRAMEWORKS_PLIST].each do |plist|
      run! "plutil -replace CFBundleVersion -string #{current_version} -- '#{plist}'"
      run! "plutil -replace CFBundleShortVersionString -string #{current_version} -- '#{plist}'"
    end
    run "git commit -m 'Bump pod version to #{version}' -- #{PODSPEC} Podfile.lock '#{DEMO_PLIST}' '#{DROPIN_FRAMEWORKS_PLIST}'"
  end

  desc  "Lint podspec."
  task :lint_podspec do
    run! "pod lib lint --allow-warnings"
  end

  desc  "Tag."
  task :tag do
    run! "git tag #{current_version} -a -m 'Release #{current_version}'"
  end

end

namespace :publish do

  desc  "Push code and tag to github.com"
  task :push do
    run! "git push #{PUBLIC_REMOTE_NAME} HEAD #{current_version}"
  end

  desc  "Pod push."
  task :push_pod do
    run! "pod trunk push --allow-warnings BraintreeDropIn.podspec"
  end

  def changelog_entries
    append_lines = false
    lines = ""
    File.read("CHANGELOG.md").each_line do |line|
      if append_lines
        break if line.include?("##") # break when we reach header for previous release
        lines += line
      elsif line.include?("##") # start appending after we find first header
        append_lines = true
      end
    end
    lines
  end

  desc "Create GitHub release"
  task :create_github_release do
    run! "gh release create #{current_version} -t #{current_version} -n '#{changelog_entries}'"
  end
end

def jazzy_command
  %W[jazzy
      --sourcekitten-sourcefile swiftDoc.json,objcDoc.json
      --author Braintree
      --author_url http://braintreepayments.com
      --github_url https://github.com/braintree/braintree-ios-drop-in
      --github-file-prefix https://github.com/braintree/braintree-ios-drop-in/tree/#{current_version}
      --theme fullwidth
      --output #{current_version}
  ].join(' ')
end

def sourcekitten_objc_command
  %W[sourcekitten doc --objc Docs/Braintree-Drop-In-Umbrella-Header.h --
      -x objective-c -isysroot $(xcrun --show-sdk-path --sdk iphonesimulator)
      -I $(pwd)/Sources/BraintreeDropIn/Public
      > objcDoc.json
  ].join(' ')
end

desc "Generate documentation via jazzy and push to GH"
task :docs_publish => %w[docs:generate docs:publish]

namespace :docs do

  desc "Generate docs with jazzy"
  task :generate do
    begin
      run! "sourcekitten --version"
    rescue => e
      say(HighLine.color("Please run `brew install sourcekitten`", :red, :bold))
      raise
    end

    run! "rm -rf docs_output"
    run(sourcekitten_objc_command)
    run(jazzy_command)
    run! "rm objcDoc.json"
    puts "Generated HTML documentation"
  end

  task :publish do
    run! "git checkout gh-pages"
    run! "ln -sfn #{current_version} current" # update symlink to current version
    run! "git add current #{current_version}"
    run! "git commit -m 'Publish #{current_version} docs to github pages'"
    run! "git push"
    run! "git checkout -"
    puts "Published docs to github pages"
  end
end

# namespace :docs do

#   desc "Generate docs with jazzy"
#   task :generate do
#     run(jazzy_command)
#     run! "cp -R Images #{current_version}/Images" # copy images used in README
#     puts "Generated HTML documentation"
#   end

#   task :publish do
#   	version = current_version
#     run! "git checkout gh-pages"
#     run! "ln -sfn #{version} current" # update symlink to current version
#     run! "git add current #{version}"
#     run! "git commit -m 'Publish #{version} docs to github pages'"
#     run! "git push"
#     run! "git checkout -"
#     puts "Published docs to github pages"
#   end
# end
