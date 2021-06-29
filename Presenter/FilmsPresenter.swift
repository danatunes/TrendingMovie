//
//  FilmsPresenter.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 13.06.2021.
//

import Foundation

protocol FilmsPresenterDelegate : NSObjectProtocol{
    
    func fetchMovie(_ movies : [MovieCustom.Movie])
    
}

class FilmsPresenter {
    
    weak var controller: FilmsPresenterDelegate? = nil
    
    init(_ controller: FilmsPresenterDelegate) {
        self.controller = controller
    }
    
    func fetchMovieFromAPI(){
        APIManager.shareInstance.getTrendingMovies { [weak self] (movies) in
            self?.controller?.fetchMovie(movies)
        }
    }
    
}
