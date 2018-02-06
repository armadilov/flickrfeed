# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'
inhibit_all_warnings!

target 'flickrfeed' do
    # Comment the next line if you're not using Swift and don't want to use dynamic frameworks
    use_frameworks!
    pod 'Alamofire', '~> 4.5'
    pod 'SwiftMessages'
    pod 'NVActivityIndicatorView', '~> 4.1'
    pod 'SwiftyImageCache', '~> 1.2.2'
    pod 'RxSwift',    '~> 4.0'
    pod 'RxCocoa',    '~> 4.0'
    
    target 'flickrfeedTests' do
        inherit! :search_paths
        pod 'OHHTTPStubs/Swift'
        pod 'Alamofire', '~> 4.5'
    end
    
end
