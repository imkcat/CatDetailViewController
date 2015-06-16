Pod::Spec.new do |s|

  s.name         = "CatDetailViewController"
  s.version      = "0.2.0"
  s.summary      = "A way to keep your viewcontroller code compact."
  s.homepage     = "https://github.com/K-cat/CatDetailViewController"
  s.license      = "MIT"
  s.author             = { "K-cat" => "kcatismyname@icloud.com" }
  s.ios.deployment_target = "5.0"
  s.source       = { :git => "https://github.com/K-cat/CatDetailViewController.git", :tag => "#{s.version}" }
  s.source_files  = "CatDetailViewController/CatDetailViewController/*.{h,m}"
  s.frameworks  = "UIKit"
  s.requires_arc = true
end
