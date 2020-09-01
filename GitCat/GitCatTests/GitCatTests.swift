//
//  GitCatTests.swift
//  GitCatTests
//
//  Created by 조윤영 on 2020/09/01.
//  Copyright © 2020 조윤영. All rights reserved.
//

import XCTest

class GitCatTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        //테스트 클래스에서 진행되는 모든 테스트 케이스에서 공통으로 필요로하는 행위들을 정의해줍니다.
        //즉 클래스 안에 속하는 테스트 메서드들이 호출되기 전 항상 setUp 메서드가 호출됩니다.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        //모든 테스트 케이스 메서드들이 종료된 후 호출되는 메서드들입니다.
        //setUp에서 생성되고 테스트에서 사용된 것들을 정리해주고 해체할 퓨ㅣㄹ요가 있을 때 해당 내용들을 작성해주면 됩니다.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //태스트 메서드는 test접두어를 붙인 메서드로 이런 접두어가 붙은 메서드 옆에는 다이아몬드 모양의 버튼이 생기고, 이 버튼을 눌러 테스트를 진행할 수 있습니다.
        //각 케이스는 하나의 메서드로 분리하여 작성해야 합니다.
        //테스트 메서드도 메서드 하나의 기능만을 수행하는 것이 원칙이기 때문에 하나의 테스트 메서드 안에 여러 케이스를 넣는 것은 권장사항이 아닙니다.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        measure {
            // Put the code you want to measure the time of here.
        }
    }

}
