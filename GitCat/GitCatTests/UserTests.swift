//
//  UserTests.swift
//  GitCatTests
//
//  Created by 조윤영 on 2020/09/01.
//  Copyright © 2020 조윤영. All rights reserved.
//
import XCTest
@testable import GitCat

class UserTests: XCTestCase, APIService {

    override func setUpWithError() throws {
        print("유저 테스트 작동 전")
    }

    override func tearDownWithError() throws {
        print("유저 테스트 작동 후")
    }
    
    //회원가입 후 부가정보 입력 API 테스트
    func testSignUpAndAddInfo() {
        
    }
    
    //로그인 API 테스트
    func testSignIn() {
        
    }
    
    //로그아웃 API 테스트
    func testSignOut() {
        
    }
    
    //로그인 재시도
    func testSignInAgain() {
        
    }
    
    //회원탈퇴 API 테스트
    func testWithdrawaal() {
        
    }
    
}
