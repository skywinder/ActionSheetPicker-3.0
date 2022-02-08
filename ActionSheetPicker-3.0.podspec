Pod::Spec.new do |spec|
  spec.name = 'ActionSheetPicker-3.0'
  spec.version = '2.7.1'
  spec.summary = 'Easily present an ActionSheet with a PickerView, allowing the user to select from a number of immutable options.'
  spec.description  = <<-DESC
 Better version of ActionSheetPicker with support iOS7 and other improvements:
   - Spawn pickers with convenience function - delegate or reference not required. Just provide a target/action callback.
   - Add buttons to UIToolbar for quick selection (see ActionSheetDatePicker below)
   - Delegate protocol available for more control
   - Universal (iPhone/iPod/iPad)
  DESC

  spec.homepage = 'https://github.com/skywinder/ActionSheetPicker-3.0'
  spec.screenshots   = [ "http://skywinder.github.io/ActionSheetPicker-3.0/Screenshots/date.png",
                         "http://skywinder.github.io/ActionSheetPicker-3.0/Screenshots/distance.png",
                         "http://skywinder.github.io/ActionSheetPicker-3.0/Screenshots/ipad.png",
                         "http://skywinder.github.io/ActionSheetPicker-3.0/Screenshots/string.png"]
  spec.license = 'BSD'
  spec.authors = {
    'Petr Korolev' => 'https://github.com/skywinder',
    'Noor ul Ain Ali' => 'https://github.com/noorulain17',
    'Tim Cinel' => 'email@timcinel.com'
  }
  spec.social_media_url   = "https://twitter.com/skywinder/"
  spec.platform     = :ios, "9.0"
  spec.source = { :git => 'https://github.com/skywinder/ActionSheetPicker-3.0.git', :tag => "#{spec.version}" }
  spec.source_files = 'CoreActionSheetPicker/CoreActionSheetPicker/Pickers/**/*.{h,m}'
  spec.framework = 'UIKit'
  spec.requires_arc = true
end
