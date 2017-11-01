Pod::Spec.new do |s|
  s.name             = 'MobPay'
  s.version          = "0.0.1"
  s.summary          = 'mob.com免费好用的支付SDK'
  s.license          = 'Copyright © 2012-2017 mob.com'
  s.author           = { "qc123456" => "vhbvbqc@gmail.com" }

  s.homepage         = 'http://www.mob.com'
  s.source           = { :git => "https://github.com/MobClub/MOBPaySDK-For-iOS", :tag => s.version.to_s }
  s.platform         = :ios
  s.ios.deployment_target = "8.0"
  s.frameworks       = 'CoreMotion'
  s.libraries        = 'sqlite3', 'z.1.2.5', 'stdc++'
  s.vendored_frameworks = 'SDK/Channels','SDK/MOBPaySDK/MOBPaySDK.framework'
  s.dependency 'MOBFoundation'
end
