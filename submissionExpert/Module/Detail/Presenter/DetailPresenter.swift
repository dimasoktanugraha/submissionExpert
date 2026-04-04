//
//  DetailPresenter.swift
//  SubmissionExpert
//
//  Created by Dimas Oktanugraha on 06/11/25.
//

import SwiftUI
import Alamofire
import Combine
import CorePackage
import Shared
import Detail
import Favorite

public protocol DetailUseCase: CorePackage.UseCase where Request == Any, Response == DetailDomainModel {}

extension Interactor: DetailUseCase where Request == Any, Response == DetailDomainModel {}

class DetailPresenter: ObservableObject {
  private let detailUseCase: any DetailUseCase
  private let favoriteUseCase: FavoriteInteractor<FavoritesLocaleDataSource>
  
  private var cancellables: Set<AnyCancellable> = []

  @Published var game: DetailDomainModel?
  @Published var errorMessage: String = ""
  @Published var isLoading: Bool = false
  @Published var isError: Bool = false
  @Published var isFavorite = false
  
  init(detailUseCase: any DetailUseCase,
       favoriteUseCase: FavoriteInteractor<FavoritesLocaleDataSource>) {
    self.detailUseCase = detailUseCase
    self.favoriteUseCase = favoriteUseCase
  }
  
  func getGameDetail() {
    isLoading = true
    detailUseCase.execute(request: nil)
      .receive(on: RunLoop.main)
      .sink(receiveCompletion: { completion in
        switch completion {
        case .failure:
          self.isError = true
          self.errorMessage = String(describing: completion)
        case .finished:
          self.isLoading = false
        }
      }, receiveValue: { game in
        self.game = game
        self.checkFavorite(id: game.id)
      })
      .store(in: &cancellables)
   }
  
    func checkFavorite(id: Int) {
      print("Checking favorite")
      favoriteUseCase.isFavorite(id: id)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { exists in
          print("isFavorite : ", exists)
          self.isFavorite = exists
        })
        .store(in: &cancellables)
    }
  
    func toggleFavorite() {
      guard let game = game else { return }
  
      if isFavorite {
        deleteFavorite(id: game.id)
      } else {
        addFavorite(game: game)
      }
    }
  
    private func addFavorite(game: DetailDomainModel) {
      let data = GameDomainModel(
        id: game.id,
        name: game.name,
        released: game.released,
        backgroundImage: game.backgroundImage,
        rating: game.rating
      )
      
      favoriteUseCase.addFavorite(game: data)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.errorMessage = String(describing: completion)
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { _ in
          self.isFavorite.toggle()
        })
        .store(in: &cancellables)
    }
  
    private func deleteFavorite(id: Int?) {
      guard let id = id else { return }
      
      favoriteUseCase.deleteFavorite(id: id)
        .receive(on: RunLoop.main)
        .sink(receiveCompletion: { completion in
          switch completion {
          case .failure:
            self.isLoading = true
            self.errorMessage = String(describing: completion)
          case .finished:
            self.isLoading = false
          }
        }, receiveValue: { _ in
          self.isFavorite.toggle()
        })
        .store(in: &cancellables)
    }
}
