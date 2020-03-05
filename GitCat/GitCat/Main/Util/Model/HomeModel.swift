//
//  HomeModel.swift
//  GitCat
//
//  Created by 조윤영 on 05/03/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

class HomeModel:Codable {
    var message:String?
    var data:HomeDataModel?
}
class HomeDataModel:Codable {
    var todayCommitCount:Int?
    var catImg:String?
    var catName:String?
    var catLevel:Int?
    var isLevelUp:Bool?
    var isGraduate:Bool?
    var todayScore:Int?
    var nextLevelScore:Int?
}
