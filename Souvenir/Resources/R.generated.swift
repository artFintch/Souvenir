//
// This is a generated file, do not edit!
// Generated by R.swift, see https://github.com/mac-cain13/R.swift
//

import Foundation
import Rswift
import UIKit

/// This `R` struct is generated and contains references to static resources.
struct R: Rswift.Validatable {
  fileprivate static let applicationLocale = hostingBundle.preferredLocalizations.first.flatMap(Locale.init) ?? Locale.current
  fileprivate static let hostingBundle = Bundle(for: R.Class.self)
  
  static func validate() throws {
    try font.validate()
    try intern.validate()
  }
  
  /// This `R.color` struct is generated, and contains static references to 0 colors.
  struct color {
    fileprivate init() {}
  }
  
  /// This `R.file` struct is generated, and contains static references to 2 files.
  struct file {
    /// Resource file `.rswiftignore`.
    static let rswiftignore = Rswift.FileResource(bundle: R.hostingBundle, name: ".rswiftignore", pathExtension: "")
    /// Resource file `DIN Pro Condensed Bold.otf`.
    static let dinProCondensedBoldOtf = Rswift.FileResource(bundle: R.hostingBundle, name: "DIN Pro Condensed Bold", pathExtension: "otf")
    
    /// `bundle.url(forResource: ".rswiftignore", withExtension: "")`
    static func rswiftignore(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.rswiftignore
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    /// `bundle.url(forResource: "DIN Pro Condensed Bold", withExtension: "otf")`
    static func dinProCondensedBoldOtf(_: Void = ()) -> Foundation.URL? {
      let fileResource = R.file.dinProCondensedBoldOtf
      return fileResource.bundle.url(forResource: fileResource)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.font` struct is generated, and contains static references to 1 fonts.
  struct font: Rswift.Validatable {
    /// Font `DINPro-CondensedBold`.
    static let dinProCondensedBold = Rswift.FontResource(fontName: "DINPro-CondensedBold")
    
    /// `UIFont(name: "DINPro-CondensedBold", size: ...)`
    static func dinProCondensedBold(size: CGFloat) -> UIKit.UIFont? {
      return UIKit.UIFont(resource: dinProCondensedBold, size: size)
    }
    
    static func validate() throws {
      if R.font.dinProCondensedBold(size: 42) == nil { throw Rswift.ValidationError(description:"[R.swift] Font 'DINPro-CondensedBold' could not be loaded, is 'DIN Pro Condensed Bold.otf' added to the UIAppFonts array in this targets Info.plist?") }
    }
    
    fileprivate init() {}
  }
  
  /// This `R.image` struct is generated, and contains static references to 0 images.
  struct image {
    fileprivate init() {}
  }
  
  /// This `R.nib` struct is generated, and contains static references to 0 nibs.
  struct nib {
    fileprivate init() {}
  }
  
  /// This `R.reuseIdentifier` struct is generated, and contains static references to 0 reuse identifiers.
  struct reuseIdentifier {
    fileprivate init() {}
  }
  
  /// This `R.segue` struct is generated, and contains static references to 0 view controllers.
  struct segue {
    fileprivate init() {}
  }
  
  /// This `R.storyboard` struct is generated, and contains static references to 4 storyboards.
  struct storyboard {
    /// Storyboard `AddNewCard`.
    static let addNewCard = _R.storyboard.addNewCard()
    /// Storyboard `CardPicker`.
    static let cardPicker = _R.storyboard.cardPicker()
    /// Storyboard `LaunchScreen`.
    static let launchScreen = _R.storyboard.launchScreen()
    /// Storyboard `Main`.
    static let main = _R.storyboard.main()
    
    /// `UIStoryboard(name: "AddNewCard", bundle: ...)`
    static func addNewCard(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.addNewCard)
    }
    
    /// `UIStoryboard(name: "CardPicker", bundle: ...)`
    static func cardPicker(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.cardPicker)
    }
    
    /// `UIStoryboard(name: "LaunchScreen", bundle: ...)`
    static func launchScreen(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.launchScreen)
    }
    
    /// `UIStoryboard(name: "Main", bundle: ...)`
    static func main(_: Void = ()) -> UIKit.UIStoryboard {
      return UIKit.UIStoryboard(resource: R.storyboard.main)
    }
    
    fileprivate init() {}
  }
  
  /// This `R.string` struct is generated, and contains static references to 0 localization tables.
  struct string {
    fileprivate init() {}
  }
  
  fileprivate struct intern: Rswift.Validatable {
    fileprivate static func validate() throws {
      try _R.validate()
    }
    
    fileprivate init() {}
  }
  
  fileprivate class Class {}
  
  fileprivate init() {}
}

struct _R: Rswift.Validatable {
  static func validate() throws {
    try storyboard.validate()
  }
  
  struct nib {
    fileprivate init() {}
  }
  
  struct storyboard: Rswift.Validatable {
    static func validate() throws {
      try main.validate()
      try launchScreen.validate()
    }
    
    struct addNewCard: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = AddNewCardViewController
      
      let bundle = R.hostingBundle
      let name = "AddNewCard"
      
      fileprivate init() {}
    }
    
    struct cardPicker: Rswift.StoryboardResourceWithInitialControllerType {
      typealias InitialController = CardPickerViewController
      
      let bundle = R.hostingBundle
      let name = "CardPicker"
      
      fileprivate init() {}
    }
    
    struct launchScreen: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = UIKit.UIViewController
      
      let bundle = R.hostingBundle
      let name = "LaunchScreen"
      
      static func validate() throws {
        if UIKit.UIImage(named: "background") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'background' is used in storyboard 'LaunchScreen', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    struct main: Rswift.StoryboardResourceWithInitialControllerType, Rswift.Validatable {
      typealias InitialController = MainViewController
      
      let bundle = R.hostingBundle
      let name = "Main"
      
      static func validate() throws {
        if UIKit.UIImage(named: "background") == nil { throw Rswift.ValidationError(description: "[R.swift] Image named 'background' is used in storyboard 'Main', but couldn't be loaded.") }
      }
      
      fileprivate init() {}
    }
    
    fileprivate init() {}
  }
  
  fileprivate init() {}
}
