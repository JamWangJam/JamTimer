#
# Be sure to run `pod lib lint JamTimer.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'JamTimer'
  s.version          = '0.0.1'
  s.summary          = 'A short description of JamTimer.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
                           GCD 定时器 
                       DESC

  s.homepage         = 'https://github.com/JamWangJam/JamTimer'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'JamWangJam' => 'superwangjianmin@163.com' }
  s.source           = { :git => 'https://github.com/JamWangJam/JamTimer.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '9.0'

  s.source_files = 'JamTimer/Classes/**/*'
  
  # s.resource_bundles = {
  #   'JamTimer' => ['JamTimer/Assets/*.png']
  # }

   s.public_header_files = 'Pod/Classes/**/*.h'
   s.frameworks = 'Foundation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
