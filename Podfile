# Uncomment this line to define a global platform for your project
# platform :ios, '9.0'

target 'FlatironMasterpiece' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for FlatironMasterpiece

  pod 'GooglePlaces'
  pod 'Firebase'
  pod 'FirebaseAuth'
  pod 'FBSDKCoreKit'
  pod 'FBSDKLoginKit'
  pod 'JSQMessagesViewController'
  pod 'Firebase/Database'
  pod 'GooglePlacePicker'
  pod 'GoogleMaps'
  pod 'ZLSwipeableViewSwift', :git => 'git@github.com:zhxnlai/ZLSwipeableViewSwift.git'
  pod 'Cartography'
  pod 'Firebase/Storage'

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end

    end
end
