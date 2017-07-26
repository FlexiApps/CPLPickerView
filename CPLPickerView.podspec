#
# Be sure to run `pod lib lint CPLPickerView.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'CPLPickerView'
  s.version          = '0.2.2'
  s.summary          = 'A Custom picker list.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
TODO: Add long description of the pod here.
                       DESC

  s.homepage         = 'http://gitlab.zulutrade.local/KYON/iOS/CPLPickerView'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'christos christodoulou' => 'cchristodoulou@kyontracker.com' }
  s.source           = { :git => 'http://gitlab.zulutrade.local/KYON/iOS/CPLPickerView.git', :tag => s.version.to_s }

  s.ios.deployment_target = '9.0'

  s.source_files = 'CPLPickerView/Classes/**/*'
  
  s.resource_bundles = {
    'CPLPickerView' => ['CPLPickerView/Assets/**/*.xib']
  }

end