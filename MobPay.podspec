Pod::Spec.new do |s|
  s.name                  = 'MobPay'
  s.version               = "0.0.2"
  s.summary               = 'mob.com免费好用的支付SDK'
  s.license               = 'MIT'
  s.author                = { "qc123456" => "vhbvbqc@gmail.com" }

  s.homepage              = 'http://www.mob.com'
  s.source                = { :git => "https://github.com/MobClub/MOBPaySDK-For-iOS.git", :tag => s.version.to_s }
  s.platform              = :ios
  s.ios.deployment_target = "8.0"
  s.libraries             = 'z.1.2.5', 'stdc++'
  s.default_subspecs      = 'PaySDK'
  s.dependency 'MOBFoundation'

  s.subspec 'PaySDK' do |sp|
    sp.vendored_frameworks   = 'SDK/MOBPaySDK/MOBPaySDK.framework'
  end

  s.subspec 'Channels' do |sp|

    # WeChat
    sp.subspec 'WeChat' do |ssp|
    ssp.vendored_libraries = "SDK/Channels/WeChatSDK/*.a"
    ssp.source_files = "SDK/Channels/WeChatSDK/*.{h,m}"
    ssp.public_header_files = "SDK/Channels/WeChatSDK/*.h"
    ssp.libraries = 'sqlite3'
    end

    # AliPay
    sp.subspec 'AliPay' do |ssp|
    ssp.vendored_frameworks = 'SDK/Channels/AlipaySDK/AlipaySDK.framework'
    ssp.resource = 'SDK/Channels/AlipaySDK/AlipaySDK.bundle'
    ssp.frameworks = 'CoreMotion'
    end

  end

end
