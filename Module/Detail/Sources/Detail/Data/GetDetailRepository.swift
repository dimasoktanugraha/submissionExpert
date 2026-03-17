//
//  GetDetailRepository.swift
//  Detail
//
//  Created by Dimas Oktanugraha on 05/10/25.
//

import Core
import Shared
import Combine
 
public struct GetDetailRepository<
  RemoteDataSource: DataSource,
  Transformer: Mapper
>: Repository where
  RemoteDataSource.Response == DetailResponse,
  Transformer.Response == DetailResponse,
  Transformer.Domain == DetailDomainModel {
  public typealias Request = Any
  public typealias Response = DetailDomainModel
  
  private let _remoteDataSource: RemoteDataSource
  private let _mapper: Transformer
  
  public init(
    remoteDataSource: RemoteDataSource,
    mapper: Transformer) {
    _remoteDataSource = remoteDataSource
    _mapper = mapper
  }
  
  public func execute(request: Any?) -> AnyPublisher<DetailDomainModel, Error> {
    return _remoteDataSource.execute(request: nil).map {
      _mapper.transformResponseToDomain(response: $0)
    }.eraseToAnyPublisher()
  }
}
