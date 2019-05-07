
Pod::Spec.new do |spec|
  spec.name         = "DKDataTrackKit"
  spec.version      = "0.0.1"
  spec.summary      = "数据埋点统计"
  spec.description  = "无侵入埋点统计控件"
  spec.homepage     = "https://github.com/bigBingC"
  spec.license      = "MIT"
  spec.author       = { "cuibing" => "cuibing@dankegongyu.com" }
  spec.platform     = :ios
  spec.platform     = :ios, "9.0"
  spec.source       = { :git => "https://github.com/bigBingC/DKDataTrackKit.git", :tag => "#{spec.version}" }
  spec.source_files  = "Class", "Class/**/*.{h,m}"
  spec.exclude_files = "Class/Exclude"
  spec.resource_bundles = {
    'DKDataTrackKit' => ['Class/**/*.{storyboard,xib,xcassets,plist,jpg,png,pch}']
  }
  spec.dependency "SensorsAnalyticsSDK"

end
