Pod::Spec.new do |s|

  s.name         = "CatDetailViewController"
  s.version      = "0.0.1"
  s.summary      = "A way to keep your viewcontroller code compact."

  # s.description  = <<-DESC

  s.homepage     = "https://github.com/K-cat/CatDetailViewController"
  # s.screenshots  = "www.example.com/screenshots_1.gif", "www.example.com/screenshots_2.gif"

  s.license      = "MIT"

  s.author             = { "K-cat" => "kcatismyname@icloud.com" }
  # Or just: s.author    = "K-cat"
  # s.authors            = { "K-cat" => "kcatismyname@icloud.com" }
  # s.social_media_url   = "http://twitter.com/K-cat"

  # s.platform     = :ios
  # s.platform     = :ios, "5.0"

  #  When using multiple platforms
  # s.ios.deployment_target = "5.0"
  # s.osx.deployment_target = "10.7"

  s.source       = { :git => "https://github.com/K-cat/CatDetailViewController.git", :tag => "0.0.1" }

  s.source_files  = "CatDetailViewController/CatDetailViewController/*.{h,m}"
  # s.exclude_files = "Classes/Exclude"

  # s.public_header_files = "Classes/**/*.h"

  # s.resource  = "icon.png"
  # s.resources = "Resources/*.png"

  # s.preserve_paths = "FilesToSave", "MoreFilesToSave"

  # s.framework  = "UIKit"
  # s.frameworks = "SomeFramework", "AnotherFramework"

  # s.library   = "iconv"
  # s.libraries = "iconv", "xml2"

  s.requires_arc = true

  # s.xcconfig = { "HEADER_SEARCH_PATHS" => "$(SDKROOT)/usr/include/libxml2" }
  # s.dependency "JSONKit", "~> 1.4"
end
