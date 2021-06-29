//
//  MovieEntity.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 21.04.2021.
//

import Foundation

struct MovieDTO {
    var id : Int
    var poster : String?
    var title : String
    var releaseDate : String
    var rating : Double
    var description : String
    var isLike : Bool = false
    
    init(movie : MovieEntity){
        self.id = Int(movie.id)
        self.title = movie.title ?? "empty"
        self.poster = movie.poster
        self.releaseDate = movie.releaseDate ?? "empty"
        self.rating = movie.rating
        self.description = ""
        self.isLike = movie.isLike
    }
    
}

struct MovieCustom : Decodable {
    let list : [Movie]
    
    struct Movie : Decodable {
        var movie : MovieData
        let favorite : Bool

        struct MovieData : Decodable{
            var id : Int
            let name : String
            let releaseDate : String
            let director : String
            let ageRating : Int
            let imgUrl : String
            let description : String
            let genres : [Genre]
            let youtubeTrailerKey : String
            
            struct Genre : Decodable {
                let id : Int
                let name : String
            }
        }
    }
}

struct MovieModel : Decodable {
    let results : [Movie]
    
    struct Movie : Decodable {
        var id : Int
        var poster : String?
        var title : String
        var releaseDate : String
        var rating : Double
        var description : String
        
        enum CodingKeys : String , CodingKey {
            case id
            case poster = "poster_path"
            case title = "original_title"
            case releaseDate = "release_date"
            case rating = "vote_average"
            case description = "overview"
        }
        
        init(movie : MovieEntity){
            self.id = Int(movie.id)
            self.title = movie.title ?? "empty"
            self.poster = movie.poster
            self.releaseDate = movie.releaseDate ?? "empty"
            self.rating = movie.rating
            self.description = ""
        }
    }
}
