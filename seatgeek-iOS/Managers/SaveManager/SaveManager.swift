//
//  SaveManager.swift
//  seatgeek-iOS
//
//  Created by Mohammed HIMOUD on 16/01/2022.
//  Copyright ©2022 Mohammed HIMOUD. All rights reserved.
//

import Foundation

protocol Preference {
   var rawValue: String { get }
}

protocol PreferencesProtocol {
   associatedtype Enumeration: Preference
   static func set<T>(_ value: T, forKey key: Enumeration)
   static func get<T>(_ value: T.Type, forKey key: Enumeration) -> T?
   static func removeValue(forKey key: Enumeration)
}

extension PreferencesProtocol {
   static func set<T>(_ value: T, forKey key: Enumeration) {
      let userDefaults = UserDefaults.standard
      userDefaults.set(value, forKey: key.rawValue)
   }
   static func get<T>(_ value: T.Type, forKey key: Enumeration) -> T? {
      let userDefaults = UserDefaults.standard
      return userDefaults.object(forKey: key.rawValue) as? T
   }
   static func removeValue(forKey key: Enumeration) {
      let userDefaults = UserDefaults.standard
      userDefaults.removeObject(forKey: key.rawValue)
   }
}

enum MediaPreferences: String, Preference {
   case favoriteEvent
}

class SaveManager: PreferencesProtocol {
   typealias Enumeration = MediaPreferences
}
