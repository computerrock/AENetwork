Pod::Spec.new do |s|

s.name = 'AENetwork'
s.summary = 'Simple and lightweight networking in Swift'
s.version = '0.10.0'
s.license = { :type => 'MIT', :file => 'LICENSE' }

s.source = { :git => 'https://github.com/tadija/AENetwork.git', :tag => s.version }
s.source_files = 'Sources/AENetwork/**/*.swift'

s.swift_versions = ['5.0', '5.1', '5.2']

s.ios.deployment_target = '14.0'

s.homepage = 'https://github.com/tadija/AENetwork'
s.author = { 'tadija' => 'tadija@me.com' }
s.social_media_url = 'http://twitter.com/tadija'

end
