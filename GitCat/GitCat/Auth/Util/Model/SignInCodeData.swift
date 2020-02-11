//
//  SignInCodeData.swift
//  GitCat
//
//  Created by 조윤영 on 05/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

struct SignInCodeData: Codable {
    var message:String?
    var data:UserData?
}
struct UserData: Codable {
    var email:String?
    var name:String?
    var profile_img:String?
    var token:String?
    var isFirst:Bool?
}

/*
 {"message":"로그인 성공",
 "data":{
 "email":"onisley0424@gmail.com",
 "name":"onisley",
 "profile_img":"https://avatars2.githubusercontent.com/u/40830852?v=4",
 "token":"eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJHaXRDYXQiLCJzdWIiOiJvbmlzbGV5MDQyNEBnbWFpbC5jb20iLCJpYXQiOjE1ODExNDQ1NTY0NzUsImV4cCI6MTU4MTIzMDk1NjQ3NX0.5oKs2OzMEifl-1EO-X6jnM85nv7qB5tXR7maAo8Bvj8",
 "isFirst":true
 }
 
 }
 */
