Pod::Spec.new do |s|
  s.name                  = 'mob_paysdk'
  s.version               = "1.0.0"
  s.summary               = 'mob.com免费好用的支付SDK'
  s.license               = 'MIT'
  s.author                = { "mob" => "mobproducts@163.com" }

  s.homepage              = 'http://www.mob.com'
  s.source                = { :git => "https://github.com/MobClub/MOBPaySDK-For-iOS.git", :tag => s.version.to_s }
  s.platform              = :ios
  s.ios.deployment_target = "8.0"
  s.default_subspecs      = 'PaySDK'
  s.dependency 'MOBFoundation'

  s.subspec 'PaySDK' do |sp|
      sp.vendored_frameworks   = 'SDK/PaySDK/MOBPaySDK.framework'
  end

  s.subspec 'Channels' do |sp|

    # WeChat
    sp.subspec 'WeChat' do |ssp|
    ssp.vendored_libraries = "SDK/PaySDK/Channels/WeChat/*.a"
    ssp.source_files = "SDK/PaySDK/Channels/WeChat/*.{h,m}"
    ssp.public_header_files = "SDK/PaySDK/Channels/WeChat/*.h"
    ssp.libraries = 'sqlite3'
    ssp.dependency 'mob_paysdk/PaySDK'
    end

    # AliPay
    sp.subspec 'AliPay' do |ssp|
    ssp.vendored_frameworks = 'SDK/PaySDK/Channels/AliPay/AlipaySDK.framework'
    ssp.resource = 'SDK/PaySDK/Channels/AliPay/AlipaySDK.bundle'
    ssp.frameworks = 'CoreMotion'
    ssp.dependency 'mob_paysdk/PaySDK'
    end

  end

end
