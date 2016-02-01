#
# Be sure to run `pod lib lint WXYEmptyDataSet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "WXYEmptyDataSet"
  s.version          = "0.1.0"
  s.summary          = "A UIScrollView superclass category for showing empty or error background."

  s.description      = "In network callback, you want to set background with different code. Use WXYEmptyDataSet pods, you can easily do this.And we also open some property for customization. My English is not good. So, this's all."

  s.homepage         = "https://github.com/wuxulome/WXYEmptyDataSet"
  s.license          = { :type => "MIT", :file => "LICENSE" }
  s.author           = { "wuxu" => "wuxulome@gmail.com" }
  s.source           = { :git => "https://github.com/wuxulome/WXYEmptyDataSet.git", :tag => s.version.to_s }

  s.platform     = :ios, '6.0'
  s.requires_arc = true

  s.source_files = 'WXYEmptyDataSet/*.{h,m}'

  s.frameworks = 'UIKit'
end
