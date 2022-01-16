//
//  UIFont.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 15/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import UIKit

private final class BundleToken {}

extension UIFont {

  public struct Font {

    let name: String
    let ext: String?

    init(name: String, ext: String? = nil) {
      self.name = name
      self.ext = ext
    }

    static let sfProTextMedium = Font(name: "SFProText-Medium", ext: "otf")
    static let sfProTextRegular = Font(name: "SFProText-Regular", ext: "otf")
    static let sfProTextLight = Font(name: "SFProText-Light", ext: "otf")
    static let sfProTextSemibold = Font(name: "SFProText-Semibold", ext: "otf")
    static let sfProTextBold = Font(name: "SFProText-Bold", ext: "ttf")
  }

  // MARK: - SFProText Font

  public static func sfProTextMedium(ofSize size: CGFloat) -> UIFont {
    return font(.sfProTextMedium, size: size)
  }

  public static func sfProTextRegular(size: CGFloat) -> UIFont {
    font(.sfProTextRegular, size: size)
  }

  public static func sfProTextLight(size: CGFloat) -> UIFont {
    font(.sfProTextLight, size: size)
  }

  public static func sfProTextSemibold(size: CGFloat) -> UIFont {
    font(.sfProTextSemibold, size: size)
  }

  public static func sfProTextBold(size: CGFloat) -> UIFont {
    font(.sfProTextBold, size: size)
  }

  // MARK: - Internal static

  public static func font(_ font: Font, size: CGFloat) -> UIFont {
    if let font = UIFont(name: font.name, size: size) {
      return font
    } else {
      loadCustomFont(font)
      return UIFont(name: font.name, size: size) ?? .systemFont(ofSize: size)
    }
  }

  // MARK: - Private static

  private static func loadCustomFont(_ font: Font) {
    let frameworkBundle = Bundle(for: BundleToken.self)
    guard let pathForResourceString = frameworkBundle.path(forResource: font.name, ofType: font.ext),
      let fontData = NSData(contentsOfFile: pathForResourceString),
      let dataProvider = CGDataProvider(data: fontData),
      let fontRef = CGFont(dataProvider) else {
      return
    }
    var errorRef: Unmanaged<CFError>?

    if CTFontManagerRegisterGraphicsFont(fontRef, &errorRef) == false {
      #if DEBUG
        print("Failed to register font - register graphics font failed - this font may have already been registered in the main bundle.")
      #endif
    }
  }
}
