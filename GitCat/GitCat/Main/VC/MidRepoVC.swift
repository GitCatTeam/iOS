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
    
    @IBOutlet weak var status1: UIView!
    @IBOutlet weak var status2: UIView!

    @IBOutlet weak var status3: UIView!
    @IBOutlet weak var status4: UIView!
    
    
    var somedays : Array = [String]()
    
    
    //포맷터 초기화
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    let selectedDates = ["2020-01-20", "2020-01-21","2020-01-22"]
    let selectedDates2 = ["2020-01-17", "2020-01-18","2020-01-19"]
    let selectedDates3 = ["2020-01-15", "2020-01-16"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        calendar.delegate = self
        calendar.dataSource = self
        
        setStatusBorderColor()
        setCalendarAppearnce()
    }
    
    func setStatusBorderColor() {
        status1.layer.borderColor = UIColor.CustomColor.brownishGrey.cgColor
        status1.layer.borderWidth = 0.5
        status2.layer.borderColor = UIColor.CustomColor.brownishGrey.cgColor
        status2.layer.borderWidth = 0.5
        status3.layer.borderColor = UIColor.CustomColor.brownishGrey.cgColor
        status3.layer.borderWidth = 0.5
        status4.layer.borderColor = UIColor.CustomColor.brownishGrey.cgColor
        status4.layer.borderWidth = 0.5
        
        
    }
    
    func setCalendarAppearnce() {
        calendar.appearance.headerDateFormat = "yyyy년 MM월";
        calendar.appearance.titleFont = UIFont(name: "BBTree_R", size: 14)
        calendar.appearance.borderSelectionColor = UIColor.CustomColor.brownishGrey
        
        calendar.appearance.todayColor = UIColor(red: 137/255, green: 204/255, blue: 246/255, alpha: 1)
        
    }
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        somedays = ["2020-01-01"]
        let dateString : String =  formatter.string(from: date)
        if self.somedays.contains(dateString) {
            return UIColor.CustomColor.skyBlue
        }else{
            return nil
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        
        print("did select date \(self.formatter.string(from: date))")
    }
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
         print("did deselect date \(self.formatter.string(from: date))")
    }
    
    
    //글자 색
//    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, titleDefaultColorFor date: Date) -> UIColor? {
//        somedays = ["2019-12-20", "2019-12-21","2019-12-22"]
//        let dateString : String = formatter.string(from: date)
//        if self.somedays.contains(dateString) {
//            return UIColor.green
//        }else{
//            return nil
//        }
//    }

    //글자 배경
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateString = self.formatter.string(from: date)

        if self.selectedDates.contains(dateString) {
            return UIColor(red: 202/255, green: 235/255, blue: 1, alpha: 1)
        } else if self.selectedDates2.contains(dateString) {
            return UIColor(red: 221/255, green: 242/255, blue: 1, alpha: 1)
        } else if self.selectedDates3.contains(dateString) {
            return UIColor(red: 242/255, green: 250/255, blue: 1, alpha: 1)
        }

        return appearance.selectionColor
    }
   
}
