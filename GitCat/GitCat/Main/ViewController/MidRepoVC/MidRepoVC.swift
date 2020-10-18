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
    @IBOutlet weak var statusLabel1: UILabel!
    @IBOutlet weak var statusLabel2: UILabel!
    @IBOutlet weak var statusLabel3: UILabel!
    @IBOutlet weak var statusLabel4: UILabel!
    
    @IBOutlet weak var loadingBackgroundView: UIView!
    @IBOutlet weak var loadingView: UIImageView!

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
    
    @IBOutlet weak var noneCommitView: UIView!
    @IBOutlet weak var noneCommitLabel: UILabel!
    
    var commitCountData: CommitCountModel?
    var commits = [CommitListDataDetailModel]()
    var commitCountDetailData = CommitCountModel()
    
    let cellIdentifier:String = "CommitDetailTVcell";
    let headerIdentifier:String = "CustomHeaderTVcell";
    
    var somedays : Array = [String]()
    var currentMonth:Int?
    var currentYear:Int?
    var commitLevel1 : Array = [String]()
    var commitLevel2 : Array = [String]()
    var commitLevel3 : Array = [String]()

    var selectedYear:String!
    var selectedMonth:String!
       
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    let debouncer = Debouncer(seconds: 0.5)
    
    //포맷터 초기화
    fileprivate let gregorian = Calendar(identifier: .gregorian)
    
    let formatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }()
    
    let formatter2: DateFormatter = {
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setStyle()
        setLocalization()
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.calendarHeightConstraint.constant = 450
        }

        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calendar.currentPage)
        
        let intYear:Int = gino(values.year)
        let intMonth:Int = gino(values.month)
        
        currentMonth = intMonth
        currentYear = intYear

        setCalendarCommitBackgroundColor(year: intYear, month: intMonth, isFirst:true)

        self.view.addGestureRecognizer(self.scopeGesture)
        
        let showCommitDate:String = formatter2.string(from: Date())
        setCommitData(date: showCommitDate)
    }
    
    func setStyle() {
        setStatusBorderColor()
        setCalendarAppearnce()
        setTableView()
        setAlpha()
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor.CustomColor.skyBlue]
        
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        navigationController?.navigationBar.barTintColor = #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
        self.deleteNavigationUnderbar()
        
        tabBarController?.tabBar.alpha = 1

    }
    
    func setAlpha() {
        self.noneCommitView.alpha = 0
        
        self.loadingBackgroundView.alpha = 1
        self.loadingView.loadGif(name: "gif_loading2")
        self.loadingView2.alpha = 1
        self.loadingView2.loadGif(name: "gif_loading2")
    }
    
    func setTableView() {
        self.tableView.allowsSelection = false
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.tableView.rowHeight = 26;
        self.tableView.separatorStyle = UITableViewCell.SeparatorStyle.none
    }
    
    @IBAction func refreshCalendar(_ sender: Any) {
        self.noneCommitView.alpha = 0
        
        self.loadingBackgroundView.alpha = 1
        self.loadingView.loadGif(name: "gif_loading2")
        
        self.loadingView2.alpha = 1
        self.loadingView2.loadGif(name: "gif_loading2")
        
        self.commits = []
        self.tableView.reloadData()
        
        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calendar.currentPage)
        
        let intYear:Int = gino(values.year)
        let intMonth:Int = gino(values.month)
        
        currentMonth = intMonth
        currentYear = intYear

        loadData(year: intYear, month: intMonth)
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
        self.status1.layer.borderColor = UIColor.CustomColor.brownishGrey.cgColor
        self.status1.layer.borderWidth = 0.5
        self.status2.layer.borderColor = UIColor.CustomColor.brownishGrey.cgColor
        self.status2.layer.borderWidth = 0.5
        self.status3.layer.borderColor = UIColor.CustomColor.brownishGrey.cgColor
        self.status3.layer.borderWidth = 0.5
        self.status4.layer.borderColor = UIColor.CustomColor.brownishGrey.cgColor
        self.status4.layer.borderWidth = 0.5
        
    }
    
    func setCalendarAppearnce() {
        self.calendar.appearance.headerDateFormat = "yyyy년 MM월";
        self.calendar.appearance.titleFont = UIFont(name: "BBTree_R", size: 14)
        self.calendar.appearance.borderSelectionColor = UIColor.CustomColor.brownishGrey
        self.calendar.appearance.todayColor = UIColor(red: 137/255, green: 204/255, blue: 246/255, alpha: 1)

        self.calendar.select(Date())
        
        self.calendar.scope = .month
        self.calendar.accessibilityIdentifier = "calendar"

    }
}
