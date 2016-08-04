
Pod::Spec.new do |s|
  s.name             = 'KeyboardController'
  s.version          = '3.0.0'
  s.summary          = 'Simplifies iOS keyboard handling.'

  s.homepage         = 'https://github.com/michalkonturek/KeyboardController'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Michal Konturek' => 'michal.konturek@gmail.com' }
  s.source           = { :git => 'https://github.com/michalkonturek/KeyboardController.git', :tag => s.version.to_s }
  s.social_media_url = 'https://twitter.com/michalkonturek'

  s.ios.deployment_target = '8.0'

  s.source_files = 'KeyboardController/Classes/**/*'

  s.frameworks = 'UIKit'
end
