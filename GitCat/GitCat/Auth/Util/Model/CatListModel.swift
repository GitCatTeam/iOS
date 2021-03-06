//
//  CatListModel.swift
//  GitCat
//
//  Created by 조윤영 on 27/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

class CatListModel: Codable {
    var message:String?
    var data: CatListDataModel?
}

class CatListDataModel:Codable {
    var isNewExist: Bool?
    var normal: [CatDataModel]?
    var special: [CatDataModel]?
    var new: [CatNewDataModel]?
}
class CatDataModel:Codable {
    var id: Int?
    var profileImg: String?
    var cost: Int?
    var description:String?
    var payType: String?
    var isAvailable: Bool?
    var isNew: Bool?
}

class CatNewDataModel:Codable {
    var profileImg:String?
    var description:String?
}

