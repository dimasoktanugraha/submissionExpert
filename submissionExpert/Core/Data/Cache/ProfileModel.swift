//
//  ProfileModel.swift
//  submissionfundamental1
//
//  Created by Dimas Oktanugraha on 12/09/25.
//

import Foundation

struct ProfileModel {
  static let nameKey = "name"
  static let jobKey = "job"
  
  static var name: String {
    get {
      return UserDefaults.standard.string(forKey: nameKey) ?? "Dimas Oktanugraha"
    }
    set {
      UserDefaults.standard.set(newValue, forKey: nameKey)
    }
  }
  
  static var job: String {
    get {
      return UserDefaults.standard.string(forKey: jobKey) ?? "Mobile Developer"
    }
    set {
      UserDefaults.standard.set(newValue, forKey: jobKey)
    }
  }
  
  static func deleteAll() -> Bool {
    if let domain = Bundle.main.bundleIdentifier {
      UserDefaults.standard.removePersistentDomain(forName: domain)
      synchronize()
      return true
    } else { return false }
  }
  
  static func synchronize() {
    UserDefaults.standard.synchronize()
  }
}
