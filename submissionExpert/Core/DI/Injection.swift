//
//  Injection.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import RealmSwift
import Core
import Detail
import Shared

final class Injection: NSObject {
  
//  private let realm = try? Realm()
//  private let endpoint = EndpointUrl(apiKey: APIConfig.apiKey)

  private func provideRepository() -> GameRepositoryProtocol {
    let realm = try? Realm()
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return GameRepository.sharedInstance(remote, locale)
  }

  func provideGame() -> GameUseCase {
    let repository = provideRepository()
    return GameInteractor(repository: repository)
  }

  func provideGameDetail(id: Int) -> GameDetailUseCase {
    let repository = provideRepository()
    return GameDetailInteractor(repository: repository, id: id)
  }
  
  func provideFavoriteGame() -> FavoriteGameUseCase {
    let repository = provideRepository()
    return FavoriteGameInteractor(repository: repository)
  }
  
  func provideDetail<U: UseCase>(id: Int) -> U? where U.Request == Any, U.Response == DetailDomainModel {
   
    let remote = GetDetailRemoteDataSource(endpoint: Endpoints.Gets.detail(id: id).url)
    
    print("🔵 Endpoint URL:", Endpoints.Gets.detail(id: id).url)
   
    let mapper = DetailTransformer()
    
    let repository = GetDetailRepository(
      remoteDataSource: remote,
      mapper: mapper)
   
    return Interactor(repository: repository) as? U
  }
}
