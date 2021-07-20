require "json"

package = JSON.parse(File.read(File.join(__dir__, "package.json")))

Pod::Spec.new do |s|
  s.name           = 'RCTBackgroundExecutionIOS'
  s.version        = package['version']
  s.summary        = package['description']
  s.description    = package['description']
  s.license        = package['license']
  s.author         = package['author']
  s.homepage       = 'https://github.com/Rejsal/react-native-background-execution-ios.git'
  s.source       = { :git => "https://github.com/Rejsal/react-native-background-execution-ios.git", :tag => "#{s.version}" }

  s.ios.deployment_target = "9.0"
  s.dependency "React"
  s.source_files           = "ios/*/*.{c,h,m,mm,cpp}"
  s.static_framework = true

end