//
//  User.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 12.04.2021.
//

import Foundation

public struct Role : Codable{
    var name : String?
}

public struct User : Codable {
    var userId : Int
    var username : String?
    var email : String?
    var birthDate : String?
    var role : Role?
    var subscribed : Bool
    //var favoriteMovies : [MovieEntity.Movie]?
}

public struct UserSubscriptionExtend : Codable{
    var expirationDate : String
}
