//
//  MidRepoVC.swift
//  GitCat
//
//  Created by 조윤영 on 30/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit
import FSCalendar

class MidRepoVC: UIViewController, FSCalendarDelegate, FSCalendarDataSource, FSCalendarDelegateAppearance {
    @IBOutlet weak var calendar: FSCalendar!
    
    var somedays : Array = [String]()
    
    
    //포맷터 초기화
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    let selectedDates = ["2019-12-20", "2019-12-21","2019-12-22"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        
        calendar.appearance.headerDateFormat = "yyyy년 MM월";
        calendar.appearance.titleFont = UIFont(name: "BBTree_R", size: 14)
        calendar.appearance.borderSelectionColor = UIColor.CustomColor.skyBlue
        
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        print("did select date \(self.formatter.string(from: date))")
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
         print("did deselect date \(self.formatter.string(from: date))")
    }
    
    
    //글자 색
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
        somedays = ["2019-12-20", "2019-12-21","2019-12-22"]
        let dateString : String = formatter.string(from: date)
        if self.somedays.contains(dateString) {
            return UIColor.green
        }else{
            return nil
        }
    }

    //글자 배경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateString = self.formatter.string(from: date)

        if self.selectedDates.contains(dateString) {
            return UIColor.green
        }

        return appearance.selectionColor
    }
   
}
