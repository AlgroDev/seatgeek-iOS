//
//  UIViewStyle.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 14/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//
// https://github.com/marinbenc/UIView-Styling

import UIKit

public struct UIViewStyle<T> {

  /// The styling function that takes a `UIView` instance
  /// and performs side-effects on it.
  public let styling: (T) -> Void

  public init(styling: @escaping (T) -> Void) {
    self.styling = styling
  }

  /// A factory method that composes multiple styles.
  ///
  /// - Parameter styles: The styles to compose.
  /// - Returns: A new `UIViewStyle` that will call the input styles'
  ///            `styling` method in succession.
  public static func compose(_ styles: UIViewStyle<T>...) -> UIViewStyle<T> {
    return UIViewStyle { view in
      for style in styles {
        style.styling(view)
      }
    }
  }

  /// Compose this style with another.
  ///
  /// - Parameter other: Other style to compose this style with.
  /// - Returns: A new `UIViewStyle` which will call this style's `styling`,
  ///            and then the `other` style's `styling`.
  public func composing(with other: UIViewStyle<T>) -> UIViewStyle<T> {
    UIViewStyle { view in
      self.styling(view)
      other.styling(view)
    }
  }

  /// Compose this style with another styling function.
  ///
  /// - Parameter otherStyling: The function to compose this style with.
  /// - Returns: A new `UIViewStyle` which will call this style's `styling`,
  ///            and then the input `styling`.
  public func composing(with otherStyling: @escaping (T) -> Void) -> UIViewStyle<T> {
    composing(with: UIViewStyle(styling: otherStyling))
  }

  public func apply(to view: T) {
    styling(view)
  }

  public func apply(to views: [T]) {
    for view in views {
      styling(view)
    }
  }

  /// Apply this style to multiple views.
  ///
  /// - Parameter views: the views to style
  public func apply(to views: T...) {
    for view in views {
      styling(view)
    }
  }
}

import Foundation
