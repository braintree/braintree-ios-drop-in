require 'tempfile'
require 'fileutils'
require 'shellwords'
require 'bundler'
Bundler.require
HighLine.color_scheme = HighLine::SampleColorScheme.new

task :default => %w[sanity_checks spec]

desc "Run default set of tasks"
task :spec => %w[spec:all]

desc "Run internal release process"
task :release => %w[release:assumptions sanity_checks release:check_working_directory release:bump_version release:lint_podspec release:tag]

desc "Publish code and pod to public github.com"
task :publish => %w[publish:push publish:push_pod]

SEMVER = /\d+\.\d+\.\d+(-[0-9A-Za-z.-]+)?/
PODSPEC = "BraintreeDropIn.podspec"
DEMO_PLIST = "DropInDemo/Supporting Files/Braintree-Demo-Info.plist"
DROPIN_FRAMEWORKS_PLIST = "BraintreeDropIn/Info.plist"
UIKIT_FRAMEWORKS_PLIST = "BraintreeUIKit/Info.plist"
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
    return "set -o pipefail && xcodebuild -workspace 'BraintreeDropIn.xcworkspace' -sdk 'iphonesimulator' -configuration '#{configuration}' -scheme '#{scheme}' -destination 'name=iPhone 11,platform=iOS Simulator#{ios_version_specifier}' #{build_settings} #{command} #{output_redirect} | ./Pods/xcbeautify/xcbeautify"
  end

end

namespace :spec do
  def run_test_scheme! scheme, ios_version = nil, output_redirect = nil
    run! xcodebuild(scheme, 'test', 'Release', ios_version, {}, output_redirect)
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
    ENV['NSUnbufferedIO'] = 'YES' #Forces parallel test output to be printed after each test rather than on completion of all tests
    run_test_scheme! 'UITests', nil, '2>&1'
    ENV['NSUnbufferedIO'] = 'NO'
  end

  desc 'Run all spec schemes'
  task :all => %w[spec:unit spec:ui]
end

namespace :demo do
  desc 'Verify that the demo app builds successfully'
  task :build do
    run! xcodebuild('DropInDemo', 'build', 'Release', nil)
  end
end

desc 'Run Carthage update'
namespace :carthage do
  def generate_cartfile
    run! 'mkdir -p BuildTest'
    File.write("BuildTest/Cartfile", "git \"file://#{Dir.pwd}\" \"#{current_branch}\"")
  end

  task :generate do
    generate_cartfile
  end

  task :clean do
    run! 'rm -rf BuildTest/Carthage && rm -rf Carthage && rm BuildTest/Cartfile && rm BuildTest/Cartfile.resolved && rm -rf ~/Library/Developers/Xcode/DerivedData'
  end

  task :test do
    run! "rm -rf Carthage"
    run! "rm -rf BuildTest"
    generate_cartfile
    run! "cd BuildTest && carthage update"
    run! "mv BuildTest/Carthage #{Dir.pwd}"
    run! "xcodebuild -project 'DropInDemo/CarthageTest/CarthageTest.xcodeproj' -scheme 'CarthageTest' clean build"
  end
end

desc 'Run all sanity checks'
task :sanity_checks => %w[sanity_checks:pending_specs sanity_checks:build_demo sanity_checks:carthage_test]

namespace :sanity_checks do
  desc 'Check for pending tests'
  task :pending_specs do
    #TODO Update for UI Tests
  end

  desc 'Verify that all demo apps Build successfully'
  task :build_demo => 'demo:build'

  desc 'Verify that Carthage builds successfully'
  task :carthage_test => %w[carthage:test carthage:clean]
end

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

end
