//
//  ReportDetailVC.swift
//  GitCat
//
//  Created by 조윤영 on 12/01/2020.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit
import Charts

class ReportDetailVC: UIViewController {
    @IBOutlet var realBaseView: UIView!
    @IBOutlet var baseView: UIView!
    
    @IBOutlet weak var view1: RoundView!
    @IBOutlet weak var view2: RoundView!
    @IBOutlet weak var view3: RoundView!
    @IBOutlet weak var view4: RoundView!
    @IBOutlet weak var view5: RoundView!
    
    @IBOutlet weak var dottedLine1: UIView!
    @IBOutlet weak var dottedLine2: UIView!
    @IBOutlet weak var dottedLine3: UIView!
    @IBOutlet weak var dottedLine4: UIView!
    
    @IBOutlet weak var statusView1: UIView!
    @IBOutlet weak var statusView2: UIView!
    @IBOutlet weak var statusView3: UIView!
    @IBOutlet weak var statusView4: UIView!
    
    @IBOutlet weak var statusBox: RoundView!
    @IBOutlet weak var statusBox2: RoundView!
    @IBOutlet weak var statusBox3: RoundView!
    @IBOutlet weak var statusBox4: RoundView!
    
    @IBOutlet weak var statusLabel1: UILabel!
    @IBOutlet weak var statusLabel2: UILabel!
    @IBOutlet weak var statusLabel3: UILabel!
    @IBOutlet weak var statusLabel4: UILabel!
    
    @IBOutlet weak var statusPercentLabel1: UILabel!
    @IBOutlet weak var statusPercentLabel2: UILabel!
    @IBOutlet weak var statusPercentLabel3: UILabel!
    @IBOutlet weak var statusPercentLabel4: UILabel!
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var barChart: BarChartView!
    @IBOutlet weak var averageCount: UILabel!
    @IBOutlet weak var totalCount: CustomLabel!
    @IBOutlet weak var compareCount: CustomLabel!
    
    @IBOutlet weak var description1: UILabel!
    @IBOutlet weak var description2: UILabel!
    @IBOutlet weak var description3: UILabel!
    
    @IBOutlet weak var loadingBackgroundView: UIView!
    
    @IBOutlet weak var loadingView: UIImageView!
    
    @IBOutlet weak var descLabel1: CustomLabel!
    @IBOutlet weak var descLabel2: CustomLabel!
    
    @IBOutlet weak var descLabel3: CustomLabel!
    
    @IBOutlet weak var commitDescLabel: CustomLabel!
    
    @IBOutlet weak var languageDescLabel: CustomLabel!
    
    @IBOutlet weak var repoDescLabel: CustomLabel!
    
    @IBOutlet weak var finalDescLabel: CustomLabel!
    
    @IBOutlet weak var top3Label: CustomLabel!
    
    //MARK: PIECHART
    var percentOfLanguageEntries = [PieChartDataEntry]()
    
    //MARK: LINECHART
    var days : [String] = []
    var commitNumbers : [Int] = []
    
    //MARK: BARCHART
    var repositories = [String]()
    var repoCommits = [Double]()
    var dataEntries1 = [BarChartDataEntry]()
    var dataEntries2 = [BarChartDataEntry]()
    
    var id:Int!
    var reportTitle:String!
    var totalCommit:String!
    
    var backgroundTask: UIBackgroundTaskIdentifier = .invalid
    
    override func viewDidLoad() {
        super.viewDidLoad()

        id = UserDefaults.standard.integer(forKey: "reportId")
        reportTitle = UserDefaults.standard.string(forKey: "reportTitle")
        totalCommit = UserDefaults.standard.string(forKey: "reportTotalCount")
        
        percentOfLanguageEntries = [] //사용언어비율 pieChart 데이터 초기화
        
        self.navigationItem.title = reportTitle
        self.totalCount.text = totalCommit
        setReportDetailData(id: id)
        
        if UIDevice.current.model.hasPrefix("iPad") {
                   view5.alpha = 0
        }
        
        setStyle()
        setFontSize()
    
    }
    
    @IBAction func goBackAction(_ sender: Any) {
        self.dismiss(animated: true)
    }

    func setStyle() {
        
        self.loadingBackgroundView.alpha = 1
        
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 137/255, green: 204/255, blue: 246/255, alpha: 1)]
        navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        let bar: UINavigationBar! = self.navigationController?.navigationBar
        bar.backgroundColor = UIColor.white
        
        bar.setBackgroundImage(UIImage(), for: UIBarMetrics.default)
        bar.shadowImage = UIImage()
        loadingView.loadGif(name: "gif_loading2")
        
        self.view1.layer.cornerRadius = 8
        self.view2.layer.cornerRadius = 8
        self.view3.layer.cornerRadius = 8
        self.view4.layer.cornerRadius = 8
        self.view5.layer.cornerRadius = 8
        
        self.view1.addShadow()
        self.view2.addShadow()
        self.view3.addShadow()
        self.view4.addShadow()
        self.view5.addShadow()
        
        self.statusBox.layer.borderWidth = 0.5
        self.statusBox2.layer.borderWidth = 0.5
        self.statusBox3.layer.borderWidth = 0.5
        self.statusBox4.layer.borderWidth = 0.5
        self.statusBox.layer.borderColor = #colorLiteral(red: 0.4391697049, green: 0.4392478466, blue: 0.4391593933, alpha: 1)
        self.statusBox2.layer.borderColor = #colorLiteral(red: 0.4391697049, green: 0.4392478466, blue: 0.4391593933, alpha: 1)
        self.statusBox3.layer.borderColor = #colorLiteral(red: 0.4391697049, green: 0.4392478466, blue: 0.4391593933, alpha: 1)
        self.statusBox4.layer.borderColor = #colorLiteral(red: 0.4391697049, green: 0.4392478466, blue: 0.4391593933, alpha: 1)
        
        self.statusView1.alpha = 0
        self.statusView2.alpha = 0
        self.statusView3.alpha = 0

    }
}
