//
//  ReportDetailModel.swift
//  GitCat
//
//  Created by 조윤영 on 18/02/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
class ReportDetailModel:Codable {
    var message:String?
    var data:ReportDetailDataModel?
}
class ReportDetailDataModel:Codable {
    var comparedLastMonth:String?
    var avgCount:String?
    var dailyCount:DailyCountModel?
    var languageRatio:LanguageRatioModel?
    var contributedRepository:ContributedRepositoryModel?
    var comment:[String]?
}
class DailyCountModel:Codable {
    var dayArray:[String?]
    var countArray:[Int?]
}
class LanguageRatioModel:Codable {
    var percentArray:[Double?]
    var resultLanguages:[ResultLanguagesModel?]
}
class ContributedRepositoryModel:Codable {
    var count:[Int?]
    var repoNames:[String?]
}
class ResultLanguagesModel:Codable {
    var percent:Double?
    var language:String?
}
