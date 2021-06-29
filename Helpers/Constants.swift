//
//  Constants.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 12.04.2021.
//

import Foundation

struct Constants {
    static let MOVIES_FROM_CUSTOM_API = "https://gambit-cinema.herokuapp.com/api/movie/get-all"
    static let base = "https://gambit-cinema.herokuapp.com/api/user"
    static let login = "\(base)/login"
    static let registration = "\(base)/registration/with-subscription"
    static let TRENDING_MOVIES_URL = "https://api.themoviedb.org/3/trending/movie/week?api_key=9ece5d65fc09b295528a6680acfcc58b"
    static let SUBSCRIBE_API_URL = "https://gambit-cinema.herokuapp.com/api/subscription/update"
    static let SUBSCRIPTION_CHECK_API = "https://gambit-cinema.herokuapp.com/api/subscription/check"

}
