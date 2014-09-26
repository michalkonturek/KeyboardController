
Pod::Spec.new do |s|
  s.name         = "KeyboardController"
  s.version      = "2.0.3"
  s.summary      = "Simplifies iOS keyboard handling."
  s.homepage     = "https://github.com/michalkonturek/KeyboardController"
  s.license      = 'MIT'

  s.author       = { 
    "Michal Konturek" => "michal.konturek@gmail.com" 
  }

  s.ios.deployment_target = '7.0'

  s.social_media_url = 'https://twitter.com/michalkonturek'
  s.source       = { 
    :git => "https://github.com/michalkonturek/KeyboardController.git", 
    :tag => s.version.to_s
  }

  s.source_files = 'Source/**/*.{h,m}'
  s.requires_arc = true

end