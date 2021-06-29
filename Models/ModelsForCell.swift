//
//  Models.swift
//  SoftFact
//
//  Created by Магжан Бекетов on 16.04.2021.
//

import Foundation
 
enum CellModel {
    case collectionView(models : [CollectionTableCellModel] , rows : Int)
    case list(models : [ListCellModel])
}

struct ListCellModel {
    let title : String
}

struct CollectionTableCellModel {
    let title : String
    let imageName : String
}
