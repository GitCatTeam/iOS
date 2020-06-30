//
//  HttpResponseCode.swift
//  GitCat
//
//  Created by 조윤영 on 22/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

//service manager layer status
enum HttpResponseCode: Int{
    case getSuccess = 200
    case postSuccess = 201
    case needData = 204 //현재 고양이 없음
    
    case selectErr = 300
    
    case badRequest = 400
    case accessDenied = 401
    case forbidden = 403
    case nullValue = 404
    case conflict = 409
    case large = 413
    case maintainance = 419
    case serverErr = 500
    case notImplemented = 501
    case nginXErr = 502
}

//Access API status
enum Result<T> {
    case success(T)
    case noContents
    case error(String)
    case failure(Error)
}

//middle layer status
enum NetworkResult<T> {
    case networkSuccess(T) //200
    case dataNeeded //204
    case badRequest //400
    case accessDenied //401
    case nullValue //404
    case duplicated //409
    case wrongInput
    case large //413
    case maintainance(T) //419
    case serverErr //500
    case requestFail //501
    case networkFail
}
