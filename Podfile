# Uncomment this line to define a global platform for your project
platform :ios, '9.3'
use_frameworks!

def swarm_pods
    pod 'Alamofire'
    pod 'Fabric'
    pod 'Crashlytics'
    pod 'Branch'
    pod 'SnapKit'
    pod 'OAuthSwift'
    pod 'SDWebImage'
    pod 'SwiftyJSON'
    pod 'Spine', :git => 'https://github.com/swarmnyc/Spine.git' #'https://github.com/wvteijlingen/Spine.git'
    pod 'AFDateHelper'
    pod 'ReachabilitySwift', '~> 3'
    pod 'Google/Analytics'
    pod 'GoogleIDFASupport'
    pod 'Dollar'
    pod 'BuddyBuildSDK'
    pod 'SWRMHelpers', :git => 'https://github.com/swarmnyc/swarm-ios-framework.git', :branch => 'cocoapod'
end

target 'SwarmApp' do
    swarm_pods
end

target 'SwarmAppDEV' do
    swarm_pods
end

target 'SwarmAppQA' do
    swarm_pods
end

# uncomment for Prod target
#target 'SwarmApp Prod' do
#    swarm_pods
#end


post_install do |installer|
    installer.pods_project.targets.each do |target|
        target.build_configurations.each do |config|
            config.build_settings['SWIFT_VERSION'] = '3.0'
        end
    end
end
