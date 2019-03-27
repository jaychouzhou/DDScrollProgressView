#
# Be sure to run `pod lib lint diandain.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
s.name             = 'DDScrollProgressView'
s.version          = '0.0.1'
s.summary          = 'A lightweight and interactable progress components of iOS '

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

s.description      = <<-DESC
    A lightweight flexible and interactable progress components of iOS . You can customize anything。
DESC

s.homepage         = 'https://github.com/jaychouzhou/DDScrollProgressView'
# s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
s.license          = { :type => 'MIT', :file => 'LICENSE' }
s.author           = { 'fizzchou@gmail.com' => 'rocking0822@126.com' }
s.source           = { :git => 'https://github.com/jaychouzhou/DDScrollProgressView.git', :tag => s.version.to_s }
# s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

s.ios.deployment_target = '8.0'

s.source_files = 'Classes/**/*'

# s.resource_bundles = {
#   'brake' => ['brake/Assets/*.png']
# }

# s.public_header_files = 'Pod/Classes/**/*.h'

end
