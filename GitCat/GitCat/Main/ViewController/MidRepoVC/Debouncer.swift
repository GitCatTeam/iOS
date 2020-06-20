//
//  Debouncer.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//
import Foundation

class Debouncer {
    // MARK: - Properties
    private let queue = DispatchQueue.main
    private var workItem = DispatchWorkItem(block: {})
    private var group = DispatchGroup()
    private var interval: TimeInterval
  
    // MARK: - Initializer
    init(seconds: TimeInterval) {
        self.interval = seconds
        
    }
    
    // MARK: - Debouncing function
    func run(action: @escaping (() -> Void)) {
        workItem.cancel()
        workItem = DispatchWorkItem(block: {
            action()
        })
        
        queue.asyncAfter(deadline: .now() + interval, execute: workItem)
    }
}
