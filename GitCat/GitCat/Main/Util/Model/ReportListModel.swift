//
//  ReportListModel.swift
//  GitCat
//
//  Created by 조윤영 on 18/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

class ReportListModel:Codable {
    var message:String?
    var data:ReportListDataModel?
}
class ReportListDataModel:Codable {
    var resultList:[ResultListDataModel]?
}
class ResultListDataModel:Codable {
    var id:Int?
    var title:String?
    var totalCount:String?
    var mainLanguage:String?
}
