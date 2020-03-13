//
//  CatCollectionModel.swift
//  GitCat
//
//  Created by 조윤영 on 13/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

class CatCollectionModel: Codable {
    var message:String?
    var data: [CatCollectionDataModel]?
}

class CatCollectionDataModel:Codable {
    var name:String?
    var endingMent:String?
    var isMedal:Bool?
    var img:String?
}
