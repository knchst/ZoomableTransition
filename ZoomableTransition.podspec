#
#  Be sure to run `pod spec lint ZoomableTransition.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|
  spec.name         = "ZoomableTransition"
  spec.version      = "0.0.1"
  spec.summary      = "A custom zoom transition of UINavigationController."
  spec.description  = <<-DESC
  A custom zoom transition of UINavigationController which provides zoom in transition for push and zoom out transition for pop.
                   DESC

  spec.homepage     = "https://github.com/knchst/ZoomableTransition"
  spec.license      = 'MIT'
  spec.author             = { "Kenichi Saito" => "knchst@icloud.com" }
  spec.social_media_url   = "https://twitter.com/knchst0704"
  spec.platform     = :ios, "13.0"
  spec.source       = { :git => "https://github.com/knchst/ZoomableTransition.git", :tag => "#{spec.version}" }
  spec.source_files  = "ZoomableTransition", "ZoomableTransition/**/*.{h,swift}"

  spec.swift_versions = "5.1"


  # ――― Resources ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  A list of resources included with the Pod. These are copied into the
  #  target bundle with a build phase script. Anything else will be cleaned.
  #  You can preserve files from being cleaned, please don't preserve
  #  non-essential files like tests, examples and documentation.
  #

  # spec.resource  = "icon.png"
  # spec.resources = "Resources/*.png"

  # spec.preserve_paths = "FilesToSave", "MoreFilesToSave"


  # ――― Project Linking ―――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  Link your library with frameworks, or libraries. Libraries do not include
  #  the lib prefix of their name.
  #

  # spec.framework  = "SomeFramework"
  # spec.frameworks = "SomeFramework", "AnotherFramework"

  # spec.library   = "iconv"
  # spec.libraries = "iconv", "xml2"


  # ――― Project Settings ――――――――――――――――――――――――――――――――――――――――――――――――――――――――― #
  #
  #  If your library depends on compiler flags you can set them in the xcconfig hash
  #  where they will only apply to your library. If you depend on other Podspecs
  #  you can include multiple dependencies to ensure it works.

  spec.requires_arc = true

  # spec.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # spec.dependency "JSONKit", "~> 1.4"

end
