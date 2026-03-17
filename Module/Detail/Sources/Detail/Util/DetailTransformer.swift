//
//  Untitled.swift
//  Detail
//
//  Created by Dimas Oktanugraha on 04/11/25.
//

import CorePackage
import Shared

public struct DetailTransformer: Mapper {
  public typealias Entity = Never
  public typealias Response = DetailResponse
  public typealias Domain = DetailDomainModel
  
  public init() {}
  
  public func transformResponseToDomain(response: DetailResponse) -> DetailDomainModel {
    return DetailDomainModel(
      id: response.id ?? 0,
      name: response.name ?? "Unknow",
      released: response.released ?? "",
      backgroundImage: response.backgroundImage ?? "",
      rating: response.rating ?? 0.0,
      description: response.description ?? ""
    )
  }
  
  public func transformResponseToEntity(response: DetailResponse) -> Never {
    fatalError("transformResponseToEntity not implemented")
  }
  
  public func transformEntityToDomain(entity: Never) -> DetailDomainModel {
    fatalError("transformEntityToDomain not implemented")
  }
}
