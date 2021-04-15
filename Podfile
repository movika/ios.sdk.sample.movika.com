# Uncomment the next line to define a global platform for your project
platform :ios, '13.0'

target 'Sample' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!
  # Pods for Sample

  pod 'MovikaSDK', :git => 'https://bitbucket.org/interactiveplatform/ios.sdk.movika.com.git'
  
  target 'SampleTests' do
    inherit! :search_paths
    # Pods for testing
  end

  target 'SampleUITests' do
    # Pods for testing
  end

end

post_install do |installer|
    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
        config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
    end
  end
end
