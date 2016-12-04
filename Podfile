# Uncomment this line to define a global platform for your project
platform :ios, '8.0'

target 'VideoPlayer' do
  # Comment this line if you're not using Swift and don't want to use dynamic frameworks
  use_frameworks!

  # Pods for VideoPlayer
  pod 'Alamofire', '3.5'
  pod 'ObjectMapper', '1.5.0'
  pod 'AlamofireObjectMapper', '3.0.2'
  pod 'SwiftTask', :git => 'https://github.com/ReactKit/SwiftTask', :branch => 'swift/2.2'
  pod 'Kingfisher', '2.6.1'

  target 'VideoPlayerTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'VideoPlayerUITests' do
    inherit! :search_paths
    # Pods for testing
  end

end

post_install do |installer|
  installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
      config.build_settings['SWIFT_VERSION'] = '2.3'
    end
  end
end
