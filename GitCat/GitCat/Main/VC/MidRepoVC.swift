//
//  MidRepoVC.swift
//  GitCat
//
//  Created by 조윤영 on 30/12/2019.
//  Copyright © 2019 조윤영. All rights reserved.
//

import UIKit
import FSCalendar

class MidRepoVC: UIViewController, UIGestureRecognizerDelegate{
    
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var status1: UIView!
    @IBOutlet weak var status2: UIView!
    @IBOutlet weak var status3: UIView!
    @IBOutlet weak var status4: UIView!
    
    var commitCountData: CommitCountModel?
    
    let cellIdentifier:String = "CommitDetailTVcell";
    let headerIdentifier:String = "CustomHeaderTVcell";
    
    var somedays : Array = [String]()
    var repositoryNameDummy: [String] = ["GitCat","카멜레On","이게뭐약"]
    var commitDummy: [String] = ["[UPDATE]레포트 화면 스크롤 동작 추가","[UPDATE]라인차트 추가","[UPDATE]설정 화면 추가","[UPDATE]Github 연동 로그인 기능 추가","[UPDATE]파이차트 추가[UPDATE]백 버튼 커스텀 적[UPDATE]달력 커스텀 적용","[UPDATE]홈화면 탭바 반영","[UPDATE]앱 아이콘 적용","[UPDATE]gitignore 수정","[UPDATE]애니메이션 추가"]
    var visitedMonth:[Bool] = [false, false, false, false, false, false, false, false, false, false, false, false, false, false]
    var currentMonth:Int?
    var currentYear:Int?
    
    
    //포맷터 초기화
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    fileprivate let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
    }()
    
    var commitLevel1 : Array = [String]()
    var commitLevel2 : Array = [String]()
    var commitLevel3 : Array = [String]()
    
//    let selectedDates = ["2020-01-20", "2020-01-21","2020-01-22"]
//    let selectedDates2 = ["2020-01-17", "2020-01-18","2020-01-19"]
//    let selectedDates3 = ["2020-01-15", "2020-01-16"]
//
    var selectedYear:String!
    var selectedMonth:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setStatusBorderColor()
        setCalendarAppearnce()
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 400
        }

        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calendar.currentPage)
        
        let intYear:Int = gino(values.year)
        let intMonth:Int = gino(values.month)
        
        print("초기화: \(intYear)년 \(intMonth)월")
        currentMonth = intMonth
        currentYear = intYear
        setCalendarCommitBackgroundColor(year: intYear, month: intMonth)
        
        self.view.addGestureRecognizer(self.scopeGesture)

        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.tableView.rowHeight = 26;
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none

    }
    
    override func viewWillAppear(_ animated: Bool) {
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calendar.currentPage)
        
        let intYear:Int = gino(values.year)
        let intMonth:Int = gino(values.month)
        
        print("viewWillAppear 초기화: \(intYear)년 \(intMonth)월")

        setCalendarCommitBackgroundColor(year: intYear, month: intMonth)
    }
    
    
    

    
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            @unknown default:
                fatalError()
            }
        }
        return shouldBegin
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
        
        self.calendar.select(Date())
        self.calendar.scope = .month
        self.calendar.accessibilityIdentifier = "calendar"
        
        
    }
}


extension MidRepoVC:  UITableViewDelegate, UITableViewDataSource  {
    
    // MARK:- UITableViewDataSource

    func numberOfSections(in tableView: UITableView) -> Int {
        return repositoryNameDummy.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commitDummy.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommitDetailTVCell
        
        cell.commitLabel.text = commitDummy[indexPath.row]
        
        
        if(indexPath.row == commitDummy.count-1) {
            cell.lineView.backgroundColor = UIColor.white
        }else{
             cell.lineView.backgroundColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 192/255)
        }
        
        return cell
    }
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)

    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 20
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        //header height : 20
        let headerCell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier) as! CustomHeaderTVCell
        
        headerCell.repoNameLabel.text = repositoryNameDummy[section]
        return headerCell.contentView
        
        
    }
    
}
extension MidRepoVC: FSCalendarDelegateAppearance {
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, borderDefaultColorFor date: Date) -> UIColor? {
        
        let todayDate:String = formatter.string(from: Date())
        
        somedays = [todayDate]
        let dateString : String =  formatter.string(from: date)
        if self.somedays.contains(dateString) {
            return UIColor.CustomColor.skyBlue
        }else{
            return nil
        }
    }
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        print("did select date \(self.formatter.string(from: date))")
               let selectedDates = calendar.selectedDates.map({self.formatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }

    }
    
    func calendar(_ calendar: FSCalendar, didDeselect date: Date, at monthPosition: FSCalendarMonthPosition) {
         print("did deselect date \(self.formatter.string(from: date))")
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.formatter.string(from: calendar.currentPage))")
//        self.formatter.string(from: <#T##Date#>)
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calendar.currentPage)
               
        let intYear:Int = gino(values.year)
        let intMonth:Int = gino(values.month)
        
        if(currentYear != intYear) {
            currentYear = intYear
            visitedMonth = [false, false, false, false, false, false, false, false, false, false, false, false, false, false]
            visitedMonth[currentMonth ?? 0] = true
            
            print("새로운 년도, 달력 넘김: \(intYear)년 \(intMonth)월")
            
            setCalendarCommitBackgroundColor(year: intYear, month: intMonth)
        }
        else if(visitedMonth[currentMonth ?? 0] != true) {
            visitedMonth[currentMonth ?? 0] = true
            
            print("새로운 달, 달력 넘김: \(intYear)년 \(intMonth)월")
            
            setCalendarCommitBackgroundColor(year: intYear, month: intMonth)
        }
        
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

            if self.commitLevel1.contains(dateString) {
                return UIColor(red: 202/255, green: 235/255, blue: 1, alpha: 1)
            } else if self.commitLevel2.contains(dateString) {
                return UIColor(red: 221/255, green: 242/255, blue: 1, alpha: 1)
            } else if self.commitLevel3.contains(dateString) {
                return UIColor(red: 242/255, green: 250/255, blue: 1, alpha: 1)
            }

            return appearance.selectionColor
        }
}


extension MidRepoVC {
    func setCalendarCommitBackgroundColor(year:Int, month:Int) {
        
        if (month<10) {
            selectedMonth = ("0" + String(month))
        }else{
            selectedMonth = String(month)
        }
        selectedYear = String(year)
        
        let userEmail = UserDefaults.standard.string(forKey: "userEmail") ?? ""
        
        CommitCountService.sharedInstance.getCommit(email: userEmail
        , month: "\(gsno(selectedYear))\(gsno(selectedMonth))") { (result) in
            switch result {
            case .networkSuccess(let data) :
                let detailData = data as? CommitCountModel
                
                if let resResult = detailData {
                    print("level1:\(self.gono(resResult.data?.commits?.level_1))")
                    self.commitLevel1 += resResult.data?.commits?.level_1 ?? []
                    self.commitLevel2 += resResult.data?.commits?.level_2 ?? []
                    self.commitLevel3 += resResult.data?.commits?.level_3 ?? []
                    
                    self.calendar.reloadData()

                }
                break
                
            case .networkFail :
                self.networkErrorAlert()
                
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                break
            }
        }
    }
}
