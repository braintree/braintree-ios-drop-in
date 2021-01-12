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
task :release => %w[release:assumptions build_demo_apps release:check_working_directory release:bump_version release:lint_podspec carthage:create_binaries release:tag]

desc "Publish code and pod to public github.com"
task :publish => %w[publish:push publish:create_github_release publish:push_pod]

SEMVER = /\d+\.\d+\.\d+(-[0-9A-Za-z.-]+)?/
PODSPEC = "BraintreeDropIn.podspec"
DEMO_PLIST = "DropInDemo/Supporting Files/Braintree-Demo-Info.plist"
DROPIN_FRAMEWORKS_PLIST = "BraintreeDropIn/Info.plist"
UIKIT_FRAMEWORKS_PLIST = "BraintreeUIKit/Info.plist"
PUBLIC_REMOTE_NAME = "origin"

bt_modules = ["BraintreeDropIn", "BraintreeUIKit"]

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

desc 'Carthage tasks'
namespace :carthage do
  task :build_demo do
    # Remove SPMTest app to prevent Carthage timeout
    run! "rm -rf SampleApps/SPMTest"
    run! "git add SampleApps"
    run! "git commit -m 'Remove SPMTest app to avoid Carthage timeout'"

    # Build Carthage demo app
    File.write("SampleApps/CarthageTest/Cartfile", "git \"file://#{Dir.pwd}\" \"#{current_branch}\"")
    sh "cd SampleApps/CarthageTest && sh ../../carthage.sh update"
    success = run "xcodebuild -project 'SampleApps/CarthageTest/CarthageTest.xcodeproj' -scheme 'CarthageTest' clean build"

    # Clean up
    run! "rm -rf ~/Library/Developers/Xcode/DerivedData"
    run! "rm SampleApps/CarthageTest/Cartfile.resolved && rm -rf SampleApps/CarthageTest/Carthage"
    run! "git checkout SampleApps/CarthageTest"
    run! "git reset --hard HEAD^"
    fail "xcodebuild command for CarthageTest app returned non-zero exit code" unless success
  end

  desc "Create BraintreeDropIn.framework.zip for Carthage."
  task :create_binaries do
    run! "rm -rf SampleApps/SPMTest" # Remove SPMTest app to prevent Carthage timeout
    sh "sh carthage.sh build --no-skip-current"
    sh "sh carthage.sh archive #{bt_modules.join(" ")} --output Braintree.framework.zip"
    run! "git co master SampleApps/SPMTest" # Restore SPMTest app
    say "Create binaries for Carthage complete."
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
task :build_demo_apps => %w[demo_app:build_demo carthage:build_demo spm:build_demo]

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

    [DEMO_PLIST, DROPIN_FRAMEWORKS_PLIST, UIKIT_FRAMEWORKS_PLIST].each do |plist|
      run! "plutil -replace CFBundleVersion -string #{current_version} -- '#{plist}'"
      run! "plutil -replace CFBundleShortVersionString -string #{current_version} -- '#{plist}'"
    end
    run "git commit -m 'Bump pod version to #{version}' -- #{PODSPEC} Podfile.lock '#{DEMO_PLIST}' '#{DROPIN_FRAMEWORKS_PLIST}' '#{UIKIT_FRAMEWORKS_PLIST}'"
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

  desc "Create GitHub release & attach .framework binaries."
  task :create_github_release do
    run! "gh release create #{current_version} BraintreeDropIn.framework.zip -t #{current_version} -n '#{changelog_entries}'"
    run! "rm -rf BraintreeDropIn.framework.zip"
  end
end
