//
//  Collection+Extensions.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 13/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

public struct SafeCollection<Base: Collection> {

  private var base: Base

  init(_ base: Base) {
    self.base = base
  }

  private func distance(from startIndex: Base.Index) -> Int {
    return base.distance(from: startIndex, to: base.endIndex)
  }

  private func distance(to endIndex: Base.Index) -> Int {
    return base.distance(from: base.startIndex, to: endIndex)
  }

  public subscript(index: Base.Index) -> Base.Iterator.Element? {
    if distance(to: index) >= 0, distance(from: index) > 0 {
      return base[index]
    }
    return nil
  }

  public subscript(bounds: Range<Base.Index>) -> Base.SubSequence? {
    if distance(to: bounds.lowerBound) >= 0, distance(from: bounds.upperBound) >= 0 {
      return base[bounds]
    }
    return nil
  }

  public subscript(bounds: ClosedRange<Base.Index>) -> Base.SubSequence? {
    if distance(to: bounds.lowerBound) >= 0, distance(from: bounds.upperBound) > 0 {
      return base[bounds]
    }
    return nil
  }
}

extension Collection {
  var safe: SafeCollection<Self> {
    return SafeCollection(self)
  }
}
