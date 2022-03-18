Pod::Spec.new do |spec|

  spec.name         = "OtterScaleiOS"
  spec.version      = "1.8"
  spec.summary      = "A CocoaPods library written in Swift"

  spec.homepage     = "https://github.com/AgentChe/OtterScaleiOS"
  spec.license      = { :type => "MIT", :file => "LICENSE" }
  spec.author       = { "akonst17" => "akonst17@gmail.com" }

  spec.ios.deployment_target = "12.1"
  spec.swift_version = "5"

  spec.source        = { :git => "https://github.com/AgentChe/OtterScaleiOS.git", :tag => "#{spec.version}" }
  spec.source_files  = "OtterScaleiOS/**/*.{h,m,swift}"

end
