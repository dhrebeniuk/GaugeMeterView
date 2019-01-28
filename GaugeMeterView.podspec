#
#  Be sure to run `pod spec lint SegueWithCompletion.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|

  s.name         = "GaugeMeterView"
  s.version      = "0.0.2"
  s.summary      = "GaugeMeterView can be used for create meter indicators"
  s.description  = "GaugeMeterView can be used for create meter indicators which give ability for customizations"

  s.homepage     = "https://github.com/dhrebeniuk/GaugeMeterView"

  s.license      = "LICENSE"
  s.author             = { "Dmytro Hrebeniuk" => "dmytrohrebeniuk@gmail.com" }
  s.platform     = :ios, "8.0"
  s.source       = { :git => "https://github.com/dhrebeniuk/GaugeMeterView.git", :tag => "#{s.version}" }
  s.source_files  = "*.{swift,h}"

  s.requires_arc = true

end
