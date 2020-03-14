//
//  CommitListModel.swift
//  GitCat
//
//  Created by 조윤영 on 23/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
class CommitListModel:Codable {
    var message:String?
    var data:CommitListDataModel?
}
class CommitListDataModel:Codable {
    var score:Int?
    var totalCommit:Int?
    var item:String?
    var commits:[CommitListDataDetailModel]?
}
class CommitListDataDetailModel:Codable {
    var repoName:String?
    var commit:[CommitInfoModel]?
}
class CommitInfoModel:Codable {
    var time:String?
    var message:String?
}
