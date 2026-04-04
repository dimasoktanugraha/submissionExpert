//
//  FavoriteEntity.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 16/09/25.
//

import Foundation
import RealmSwift
 
public class FavoriteModuleEntity: Object {
  
  @Persisted(primaryKey: true) public var id: Int = 0
  @Persisted public var name: String = ""
  @Persisted public var released: String = ""
  @Persisted public var backgroundImage: String = ""
  @Persisted public var rating: Double = 0.0
  @Persisted public var desc: String = ""
 
  public override init() {
      super.init()
  }
}
