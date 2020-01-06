//
//  Token.swift
//  GitCat
//
//  Created by 조윤영 on 05/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

struct TokenResponse: Codable {
     
    var access_token: String?
    var scope: String?
    var token_type: String?
    
}

