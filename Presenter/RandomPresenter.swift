//
//  RandomPresenter.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 13.06.2021.
//

import Foundation

protocol RandomPresenterDelegate : NSObjectProtocol {
    func fetchMovie(_ movies : [MovieCustom.Movie])
}

class RandomPresenter {
    
    weak var controller : RandomPresenterDelegate! = nil
    
    init(_ controller : RandomPresenterDelegate) {
        self.controller = controller
    }
    
    func fetchMovieFromAPI(){
        APIManager.shareInstance.getTrendingMovies { [weak self] (movies) in
            self?.controller?.fetchMovie(movies)
        }
    }
}
