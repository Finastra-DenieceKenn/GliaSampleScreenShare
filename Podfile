# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'
source 'https://github.com/CocoaPods/Specs.git'
source 'https://github.com/salemove/glia-ios-podspecs.git'

target 'SampleScreenSharing' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for SampleScreenSharing
  pod 'GliaWidgets', '~> 2.0.1'
  pod 'IQKeyboardManagerSwift'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['EXPANDED_CODE_SIGN_IDENTITY'] = ""
            config.build_settings['CODE_SIGNING_REQUIRED'] = "NO"
            config.build_settings['CODE_SIGNING_ALLOWED'] = "NO"
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '13.0'
        end
    end
end