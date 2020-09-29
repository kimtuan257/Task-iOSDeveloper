target 'Task-iOSDeveloper' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Task-iOSDeveloper
  pod 'Alamofire'
  pod 'Moya'
  pod 'SDWebImage'
  pod 'SVProgressHUD'
  pod 'FSPagerView'
end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
    end
  end
end
