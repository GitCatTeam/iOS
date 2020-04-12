//
//  RefreshTokenModel.swift
//  GitCat
//
//  Created by 조윤영 on 12/04/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

class RefreshTokenModel:Codable {
    var message:String?
    var data:RefreshTokenDataModel?
}
class RefreshTokenDataModel:Codable {
    var accessToken:String?
    var refreshToken:String?
}
