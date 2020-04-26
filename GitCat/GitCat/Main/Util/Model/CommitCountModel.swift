//
//  CommitModel.swift
//  GitCat
//
//  Created by 조윤영 on 23/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

//https://stackoverflow.com/questions/53729496/swift-codable-encode-structure-with-dynamic-keys
//FIXME!
import Foundation

class CommitCountModel: Codable {
    var message:String?
    var data: CommitDataModel?
}

class CommitDataModel:Codable {
    var commits: CommitLevelModel?
    var detailCommits: [String:CommitDetailModel] = [:]
}
class CommitLevelModel:Codable {
    var level_1:[String]?
    var level_2:[String]?
    var level_3:[String]?
}

class CommitDetailModel:Codable {
   
    var count:Int?
    var score:Int?
    var levelUp:String?
}
