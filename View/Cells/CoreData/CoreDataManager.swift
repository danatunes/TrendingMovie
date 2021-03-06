//
//  CoreDataManager.swift
//  TrendingMovies
//
//  Created by Магжан Бекетов on 17.05.2021.
//

import Foundation
import CoreData

final class CoreDataManager {
    
    static let shared = CoreDataManager()
    
    private init() {}
    
    private lazy var persistentContainer: NSPersistentContainer = {
        
        let container = NSPersistentContainer(name: "LocalDBModel")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()
    
    func save(){
        let context = persistentContainer.viewContext
        do {
            try context.save()
        } catch  {
            print(error)
        }
    }
    
//    func addMovie(_ movie : MovieDetailedModel){
//        let context = persistentContainer.viewContext
//        context.perform {
//            let newMovie = MovieEntity(context: context)
//            newMovie.id = Int64(movie.id ?? 0)
//            newMovie.title = movie.title
//            newMovie.poster = movie.poster
//            newMovie.rating = movie.rating
//            newMovie.releaseDate = movie.releaseDate
//        }
//        save()
//    }
    
    func addMovie(_ movie : MovieCustom.Movie){
        let context = persistentContainer.viewContext
        context.perform {
            let newMovie = MovieEntity(context: context)
            newMovie.id = Int64(movie.movie.id )
            newMovie.title = movie.movie.name
            newMovie.poster = movie.movie.imgUrl
            newMovie.rating = Double(movie.movie.ageRating)
            newMovie.releaseDate = movie.movie.releaseDate
        }
        save()
    }
    
    func addMovie(_ movie : MovieDTO){
        let context = persistentContainer.viewContext
        context.perform {
            let newMovie = MovieEntity(context: context)
            newMovie.id = Int64(movie.id )
            newMovie.title = movie.title
            newMovie.poster = movie.poster
            newMovie.rating = movie.rating
            newMovie.releaseDate = movie.releaseDate
        }
        save()
    }
    
    func findMovie(with id : Int) -> MovieEntity? {
        let context = persistentContainer.viewContext
        let requestResult : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        requestResult.predicate = NSPredicate(format: "id == %d", id)
        
        do {
            let movies = try context.fetch(requestResult)
            if movies.count > 0 {
                assert(movies.count == 1 , "It means DB has duplicates")
                return movies[0]
            }
        } catch  {
            print(error)
        }
        
        return nil
    }
    
    func deleteMovie(with id : Int){
        let context = persistentContainer.viewContext
        
        let movie = findMovie(with: id)
        
        if let movie = movie{
            context.delete(movie)
            save()
        }
        
    }
    
    func allMovies() -> [MovieDTO] {
        let context = persistentContainer.viewContext
        let request : NSFetchRequest<MovieEntity> = MovieEntity.fetchRequest()
        
        let moviess = try? context.fetch(request)
        
        guard let movies = moviess else {
            print("... movies is nil")
            return []
        }
        
        return movies.map ({ MovieDTO(movie: $0) })
        
    }
    
}
