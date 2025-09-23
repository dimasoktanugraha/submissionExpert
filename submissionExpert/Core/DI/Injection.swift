//
//  Injection.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 14/09/25.
//

import Foundation
import RealmSwift

final class Injection: NSObject {

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
}
