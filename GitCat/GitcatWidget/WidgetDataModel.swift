//
//  WidgetDataModel.swift
//  GitCat
//
//  Created by 조윤영 on 2020/10/16.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation

struct WidgetDataModel: Decodable {
    let commitCount: Int?
    let level: Int?
    let item: String?
    let needScore: Int
    let commits: [Int]?
}
