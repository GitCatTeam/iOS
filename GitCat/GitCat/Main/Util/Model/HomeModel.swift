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
    var todayScore: Int?
    var catName:String?
    var catImg:String?
    
    var totalScore: Int?
    var currentLevel: Int?
    var currentItem: String?
    var nextLevel: Int?
    var nextLevelItem: String?
    var nextLevelScore: Int?
    var graduScore: Int?
    var progressPer: Int?
    
    var ments:[String]?
    
    var isLevelUp:Bool?
    var isGraduate:Bool?
    var isLeave:Bool?
}
