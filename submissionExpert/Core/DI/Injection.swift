//
//  Injection.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import RealmSwift
import CorePackage
import Detail
import Shared
import Favorite

final class Injection: NSObject {
  
  private let realm = try? Realm()

  private func provideRepository() -> GameRepositoryProtocol {
    let locale: LocaleDataSource = LocaleDataSource.sharedInstance(realm)
    let remote: RemoteDataSource = RemoteDataSource.sharedInstance

    return GameRepository.sharedInstance(remote, locale)
  }

  func provideGame() -> GameUseCase {
    let repository = provideRepository()
    return GameInteractor(repository: repository)
  }
  
  func provideDetail<U: UseCase>(id: Int) -> U? where U.Request == Any, U.Response == DetailDomainModel {
   
    let remote = GetDetailRemoteDataSource(endpoint: Endpoints.Gets.detail(id: id).url)
   
    let mapper = DetailTransformer()
    
    let repository = GetDetailRepository(
      remoteDataSource: remote,
      mapper: mapper)
   
    return Interactor(repository: repository) as? U
  }
  
  func provideFavorite() -> Interactor<
    Any,
    [GameDomainModel],
    FavoritesRepository<
      FavoritesLocaleDataSource,
      FavoriteTransformer>
  > {
    let locale = FavoritesLocaleDataSource(realm: realm!)
    let mapper = FavoriteTransformer()
    let repository = FavoritesRepository(localeDataSource: locale, mapper: mapper)
    
    return Interactor(repository: repository)
  }
  
  func provideFavoriteDetail() -> FavoriteInteractor {
    let locale = FavoritesLocaleDataSource(realm: realm!)
    let mapper = FavoriteTransformer()
    let repository = FavoritesRepository(localeDataSource: locale, mapper: mapper)
    
    return FavoriteInteractor(repository: repository)
  }
}
