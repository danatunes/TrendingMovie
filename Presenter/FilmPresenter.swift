//
//  FilmPresenter.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 13.06.2021.
//

import Foundation

protocol FilmPresenterDelegate : NSObjectProtocol {
    
}

class FilmPresenter {
    
    weak var controller : FilmPresenterDelegate! = nil
    
    init(_ controller : FilmPresenterDelegate) {
        self.controller = controller
    }
    
    func findMovie(with movieId : Int) -> MovieEntity? {
     
        guard let movie = CoreDataManager.shared.findMovie(with: movieId) else{
            return nil
        }
        return movie
    }
    
    func deleteMovie(with movieId : Int){
        CoreDataManager.shared.deleteMovie(with: movieId)
    }
    
    func addMovie(movie : MovieCustom.Movie){
        CoreDataManager.shared.addMovie(movie)
    }
    
}
