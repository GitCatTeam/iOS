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
    
    @IBOutlet weak var loadingBackgroundView: UIView!
    @IBOutlet weak var loadingView: UIImageView!
    @IBOutlet weak var loadingBackgroundView2: UIView!
    
    @IBOutlet weak var loadingView2: UIImageView!
    @IBOutlet weak var desc1: CustomLabel!
    @IBOutlet weak var desc2: CustomLabel!
    @IBOutlet weak var desc3: CustomLabel!
    @IBOutlet weak var desc4: CustomLabel!
    
    @IBOutlet weak var scoreLabel: CustomLabel!
    
    @IBOutlet weak var totalCommitLabel: CustomLabel!
    @IBOutlet weak var itemLabel: CustomLabel!
    
    @IBOutlet weak var desc5: CustomLabel!
    
    @IBOutlet weak var noneItem: CustomLabel!
    
    
    var commitCountData: CommitCountModel?
    
    let cellIdentifier:String = "CommitDetailTVcell";
    let headerIdentifier:String = "CustomHeaderTVcell";
    
    var somedays : Array = [String]()
    
    var commits = [CommitListDataDetailModel]()
    
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
    
    fileprivate let formatter2: DateFormatter = {
        let formatter2 = DateFormatter()
        formatter2.dateFormat = "yyyyMMdd"
        return formatter2
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

    var selectedYear:String!
    var selectedMonth:String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.alpha = 1
        loadingBackgroundView.alpha = 1
        loadingView.loadGif(name: "gif_loading2")
        
        loadingBackgroundView2.alpha = 1
        loadingView2.loadGif(name: "gif_loading2")
        tableView.allowsSelection = false
        
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
        visitedMonth[intMonth] = true
        setCalendarCommitBackgroundColor(year: intYear, month: intMonth)
        
        self.view.addGestureRecognizer(self.scopeGesture)

        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.tableView.rowHeight = 26;
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
        
        let showCommitDate:String = formatter2.string(from: Date())
        setCommitData(date: showCommitDate)
    }
    
    func setFontSize() {
        desc1.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        desc2.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        desc3.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        desc4.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        desc5.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        scoreLabel.dynamicFont(fontSize: 32, name: "BBTreeGo_R")
        totalCommitLabel.dynamicFont(fontSize: 32, name: "BBTreeGo_R")
        itemLabel.dynamicFont(fontSize: 32, name: "BBTreeGo_R")
        noneItem.dynamicFont(fontSize: 14, name: "BBTreeGo_R")
        
        
        
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
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! CommitDetailTVCell
        
        cell.commitLabel.text = commits[indexPath.section].commit?[indexPath.row].message ?? ""
        cell.timeLabel.text = commits[indexPath.section].commit?[indexPath.row].time ?? ""
 
        
        if(indexPath.row == commits.count-1) {
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
        
        let headerCell = tableView.dequeueReusableCell(withIdentifier: headerIdentifier) as! CustomHeaderTVCell
        
        headerCell.repoNameLabel.text = commits[section].repoName
        
        headerCell.repoNameLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
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

        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
        setCommitData(date:self.formatter2.string(from: date))

    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.formatter.string(from: calendar.currentPage))")

        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calendar.currentPage)
               
        let intYear:Int = gino(values.year)
        let intMonth:Int = gino(values.month)
        
        if(currentYear != intYear) {
            currentYear = intYear
            print("바뀐년도:\(intYear)")
            visitedMonth = [false, false, false, false, false, false, false, false, false, false, false, false, false, false]
            
            visitedMonth[intMonth] = true
            print(visitedMonth)
            print("새로운 년도, 달력 넘김: \(intYear)년 \(intMonth)월")
            
            setCalendarCommitBackgroundColor(year: intYear, month: intMonth)
        }
        else if(visitedMonth[intMonth] != true) {
            visitedMonth[intMonth] = true
            
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
                return #colorLiteral(red: 0.9490196078, green: 0.9803921569, blue: 1, alpha: 1)
            } else if self.commitLevel2.contains(dateString) {
                return #colorLiteral(red: 0.8666666667, green: 0.9490196078, blue: 1, alpha: 1)
            } else if self.commitLevel3.contains(dateString) {
                return #colorLiteral(red: 0.7921568627, green: 0.9215686275, blue: 1, alpha: 1)
            }

            return appearance.selectionColor
        }
}


extension MidRepoVC {
    
    //커밋 잔디 불러오기
    func setCalendarCommitBackgroundColor(year:Int, month:Int) {
        
        loadingBackgroundView.alpha = 1
        
        if (month<10) {
            selectedMonth = ("0" + String(month))
        }else{
            selectedMonth = String(month)
        }
        selectedYear = String(year)
        
        CommitCountService.sharedInstance.getCommit(month: "\(gsno(selectedYear))\(gsno(selectedMonth))") { (result) in
            switch result {
                
            case .networkSuccess(let data) :
                
                let detailData = data as? CommitCountModel
                
                if let resResult = detailData {
                    print("level1:\(self.gono(resResult.data?.commits?.level_1))")
                    self.commitLevel1 += resResult.data?.commits?.level_1 ?? []
                    self.commitLevel2 += resResult.data?.commits?.level_2 ?? []
                    self.commitLevel3 += resResult.data?.commits?.level_3 ?? []
                    
                    self.calendar.reloadData()
                    self.loadingBackgroundView.alpha = 0

                }
                break
                
            case .networkFail :
                self.networkErrorAlert()
                self.loadingBackgroundView.alpha = 0
                
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
                self.loadingBackgroundView.alpha = 0
                break
            }
        }
        
        
        
    }
    
    //커밋내역 불러오기
    func setCommitData(date:String?) {
        self.loadingBackgroundView2.alpha = 1
        CommitListService.sharedInstance.getCommitData(date: date!) { (result) in
           switch result {
           
           case .networkSuccess(let data) :
            let detailData = data as? CommitListModel
                            
            if let resResult = detailData {
                self.scoreLabel.text = "+\(self.gino(resResult.data?.score))"
                self.totalCommitLabel.text = "\(self.gino(resResult.data?.totalCommit))"
                self.itemLabel.text = resResult.data?.item ?? "없음"
                if(resResult.data?.item == "없음") {
                    //다른 label alpha값 1로 변경(교체)
                    self.noneItem.alpha = 1
                    self.itemLabel.alpha = 0
                }else {
                    self.noneItem.alpha = 0
                    self.itemLabel.alpha = 1
                }
                
                self.commits = resResult.data?.commits ?? []
                
            }
            self.tableView.reloadData()
            self.loadingBackgroundView2.alpha = 0
            break
                            
           case .networkFail :
            self.networkErrorAlert()
            self.loadingBackgroundView2.alpha = 0
                            
           default:
            self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요")
            self.loadingBackgroundView2.alpha = 0

            break
            
            }
        }
    }
                
}
