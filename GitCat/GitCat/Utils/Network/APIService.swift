//
//  APIService.swift
//  GitCat
//
//  Created by 조윤영 on 22/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

protocol APIServie {
    
}
import Alamofire
import UIKit
import SwiftyJSON
extension APIServie {
    
    func url(_ path: String) -> String {
        return "https://a.gitcat.app/api" + path
    }
}


class APIServiceCode {
    static let TEST = 0
    static let SERVER_ERROR = 1
    static let PARAMENTER_ERROR = 2
    static let EXCEPTION_ERROR1 = 3
    static let EXCEPTION_ERROR2 = 4

    static let PHOTO_URL = 99
    static let FUNDING_MAIN = 100
    static let FUNDING_LIST = 101
    static let FUNDING_BANNER_LIST = 102
    static let FUNDING_DETAIL = 103

    static let GEOCODE = 140
    static let REVERSE_GEOCODE = 141
}
