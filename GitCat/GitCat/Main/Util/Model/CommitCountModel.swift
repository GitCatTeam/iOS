//
//  CommitModel.swift
//  GitCat
//
//  Created by 조윤영 on 23/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

class CommitCountModel: Codable {
    var message:String?
    var data: CommitDataModel?
}

class CommitDataModel:Codable {
    var commits: CommitLevelModel?
}
class CommitLevelModel:Codable {
    var level_1:[String]?
    var level_2:[String]?
    var level_3:[String]?
}

