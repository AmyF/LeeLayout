#
# Be sure to run `pod lib lint LeeLayout.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'LeeLayout'
  s.version          = '1.0.0'
  s.summary          = 'Chained call of AutoLayout'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
AutoLayout made easy in iOS/macOS.
                       DESC

  s.homepage         = 'https://github.com/AmyF/LeeLayout'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { '840382477@qq.com' => '840382477@qq.com' }
  s.source           = { :git => 'https://github.com/AmyF/LeeLayout.git', :tag => s.version.to_s }
  s.swift-version    = '4.0'

  s.ios.deployment_target = '9.0'
  s.osx.deployment_target  = '10.11'

  s.source_files = 'Classes/**/*'
end
