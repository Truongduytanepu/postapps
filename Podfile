# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Ex1' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  
  # Pods for Ex1
  pod 'Alamofire'
  pod 'ObjectMapper'
  pod 'MBProgressHUD', '~> 1.2.0'
  pod 'KeychainSwift', '~> 20.0'
  pod 'XLPagerTabStrip', '~> 9.0'
  pod "ESTabBarController-swift"
  pod 'AlamofireImage', '~> 4.1'
  
#  pod 'IQKeyboardManagerSwift'
#  pod 'SDWebImage', '~> 4.0'
#  pod 'KRPullLoader'
#  pod 'Paytm-Payments'
  target 'Ex1Tests' do
    inherit! :search_paths
    # Pods for testing
    pod 'Quick'
    pod 'Nimble'
    pod 'MockingbirdFramework', '~> 0.20'
  end
  
end

post_install do |installer|
  installer.generated_projects.each do |project|
    project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
      end
    end
  end
end
