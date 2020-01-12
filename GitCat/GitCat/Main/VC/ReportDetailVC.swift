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
    
    @IBOutlet weak var pieChart: PieChartView!
    
    var iosDataEntry = PieChartDataEntry(value: 20)
    var macDataEntry = PieChartDataEntry(value: 30)
    
    var numberOfDownloadsDataEntries = [PieChartDataEntry]()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        pieChart.legend.enabled = false
        iosDataEntry.label = nil
        macDataEntry.label = nil
        
        numberOfDownloadsDataEntries = [iosDataEntry, macDataEntry]
        
        pieChart.chartDescription?.text = ""
        pieChart.centerText = "언어 비율\n(%)"
        pieChart.drawCenterTextEnabled = true
        
        let paragraphStyle = NSMutableParagraphStyle(); paragraphStyle.alignment = .center
        
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "BBTreeGo_R", size: 12.0)!,
                            NSAttributedString.Key.foregroundColor : UIColor.CustomColor.brownishGrey, NSAttributedString.Key.paragraphStyle: paragraphStyle
]
            let myAttrString = NSAttributedString(string: "언어 비율\n(%)", attributes: myAttribute)

        pieChart.centerAttributedText = myAttrString
        
        updateData()
        
        
        
    }
    
    func updateData() {
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        //색 리스트 초기화해주는 공간
        let colors = [UIColor.CustomColor.skyBlue, UIColor.CustomColor.brownishGrey]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
    

}
