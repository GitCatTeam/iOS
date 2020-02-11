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
    @IBOutlet weak var view1: RoundView!
    @IBOutlet weak var view2: RoundView!
    @IBOutlet weak var view3: RoundView!
    @IBOutlet weak var view4: RoundView!
    @IBOutlet weak var dottedLine1: UIView!
    @IBOutlet weak var dottedLine2: UIView!
    @IBOutlet weak var dottedLine3: UIView!
    @IBOutlet weak var dottedLine4: UIView!
    
    @IBOutlet weak var statusBox: RoundView!
    @IBOutlet weak var statusBox2: RoundView!
    @IBOutlet weak var statusBox3: RoundView!
    @IBOutlet weak var statusBox4: RoundView!
    
    
    @IBOutlet weak var pieChart: PieChartView!
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var barChart: BarChartView!
    
    //FIXME: PIECHART - 임의로 이해를 돕기 위해 넣어두는 더미 데이터
    var iosDataEntry = PieChartDataEntry(value: 20)
    var macDataEntry = PieChartDataEntry(value: 30)
    var DataEntry3 = PieChartDataEntry(value: 50)
    var DataEntry4 = PieChartDataEntry(value: 10)
    
    //FIXME: LINECHART - 임의로 이해를 돕기 위해 넣어두는 더미 데이터
    var numbers : [Double] = [10,40,20.0,10.0,40.0,20.0,60.0]
    
    //FIXME: BARCHART - 임의로 이해를 돕기 위해 넣어두는 더미 데이터
    var months: [String]!
    var dataEntries1 = [BarChartDataEntry]()
    var dataEntries2 = [BarChartDataEntry]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLineChartData()
        updatePieChartData()
        updateBarChartData()
        
        setBackBtn(color: UIColor.CustomColor.brownishGrey)
        setStyle()
    
    }
    
    func updateLineChartData() {
        var lineChartEntries = [ChartDataEntry]()
        
        //나중에 통신으로 받아올거면 이렇게 하는게 더 낫겠지
        for i in 0..<numbers.count {
            let value = ChartDataEntry(x: Double(i), y: numbers[i])
            lineChartEntries.append(value)
        }
        
        let line = LineChartDataSet(entries:lineChartEntries, label:"Number")

        line.colors = [UIColor.clear]
        line.mode = .cubicBezier
        line.drawFilledEnabled = true
        line.fillColor = UIColor.CustomColor.skyBlue
        line.circleColors = [#colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)]
//        line.drawCirclesEnabled = false
        line.circleRadius = 3
        line.circleHoleRadius = 1
        
        
        line.drawValuesEnabled = false
        let data = LineChartData()
        
        data.addDataSet(line)
        
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        lineChart.xAxis.axisLineDashPhase = CGFloat(signOf: 0,magnitudeOf: 0)
        
        lineChart.xAxis.gridColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        lineChart.xAxis.labelTextColor = UIColor.CustomColor.brownishGrey
        lineChart.xAxis.labelFont = UIFont(name: "BBTreeGo_R", size: 11)!
        
        
        lineChart.leftAxis.drawAxisLineEnabled = false
        lineChart.leftAxis.gridColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        lineChart.leftAxis.labelTextColor = #colorLiteral(red: 0.5320672393, green: 0.8002378345, blue: 0.9608486295, alpha: 1)
        lineChart.leftAxis.labelFont = UIFont(name: "BBTreeGo_R", size: 11)!
    
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.drawGridLinesEnabled = false
        lineChart.rightAxis.drawLabelsEnabled = false
        
        lineChart.legend.enabled = false
        lineChart.chartDescription?.text = ""
        lineChart.doubleTapToZoomEnabled = false
        lineChart.pinchZoomEnabled = false
        
        
        let days = ["1", "5", "10", "15", "20", "25", "30"]
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:days)
        lineChart.xAxis.granularity = 1
        
        lineChart.data = data
        
    }
    func updatePieChartData() {
        //일단 다 때려넣을테니 나중에 다시 정리 ^^
        
        var numberOfDownloadsDataEntries = [PieChartDataEntry]()
        
        pieChart.legend.enabled = false
        
        numberOfDownloadsDataEntries = [iosDataEntry, macDataEntry, DataEntry3, DataEntry4]
                
        pieChart.chartDescription?.text = ""
        pieChart.centerText = "언어 비율\n(%)"
        pieChart.drawCenterTextEnabled = true
        pieChart.clipsToBounds = false
        pieChart.highlightPerTapEnabled = false
        pieChart.transparentCircleColor = nil
        
                
        let paragraphStyle = NSMutableParagraphStyle(); paragraphStyle.alignment = .center
                
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "BBTreeGo_R", size: 12.0)!,
                            NSAttributedString.Key.foregroundColor : UIColor.CustomColor.brownishGrey, NSAttributedString.Key.paragraphStyle: paragraphStyle
        ]
        let myAttrString = NSAttributedString(string: "언어 비율\n(%)", attributes: myAttribute)

        pieChart.centerAttributedText = myAttrString
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        //색 리스트 초기화해주는 공간
        
        let colors = [#colorLiteral(red: 0.4854287505, green: 0.7172181606, blue: 0.8653311133, alpha: 1),#colorLiteral(red: 0.797280252, green: 0.9200312495, blue: 1, alpha: 1), #colorLiteral(red: 0.9469732642, green: 0.981259644, blue: 0.9980216622, alpha: 1), #colorLiteral(red: 0.9332618117, green: 0.9333737493, blue: 0.9332236052, alpha: 1)]
        chartDataSet.colors = colors
        
        
        pieChart.data = chartData
    }
    
    func updateBarChartData() {
        
        months = ["레파1", "레파2", "레파3"]
        let unitSold = [20, 4, 6.0]
        setBarChart(dataPoints: months, values: unitSold)
    }
    
    func setBarChart(dataPoints: [String], values: [Double]) {
        barChart.noDataText = "데이터가 없습니다."

        barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:dataPoints)
        barChart.xAxis.granularity = 1
        barChart.xAxis.labelPosition = .bottom
        barChart.xAxis.labelTextColor = UIColor.CustomColor.brownishGrey
        barChart.xAxis.labelFont = UIFont(name: "BBTreeGo_R", size: 11)!
        barChart.xAxis.drawGridLinesEnabled = false

        barChart.leftAxis.drawGridLinesEnabled = false
        barChart.leftAxis.drawAxisLineEnabled = false
        barChart.leftAxis.drawLabelsEnabled = false
        
        barChart.rightAxis.drawLabelsEnabled = false
        barChart.rightAxis.drawAxisLineEnabled = false
        barChart.rightAxis.drawGridLinesEnabled = false
        
        barChart.legend.enabled = false
        barChart.doubleTapToZoomEnabled = false
        barChart.pinchZoomEnabled = false
        barChart.highlightFullBarEnabled = false
        barChart.highlightPerTapEnabled = false
        barChart.highlightPerDragEnabled = false
        
        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries1.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries1, label: "Units Sold")
        
        chartDataSet.colors = [#colorLiteral(red: 0.8022227883, green: 0.9198918939, blue: 1, alpha: 1), #colorLiteral(red: 0.5390568376, green: 0.7959131598, blue: 0.9652681947, alpha: 1), #colorLiteral(red: 0.8410330415, green: 0.8754420877, blue: 0.8878466487, alpha: 1)]
        
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.5

        barChart.data = chartData
    }
    
    func setStyle() {
        self.view1.layer.cornerRadius = 8
        self.view2.layer.cornerRadius = 8
        self.view3.layer.cornerRadius = 8
        self.view4.layer.cornerRadius = 8
        
        self.view1.addShadow()
        self.view2.addShadow()
        self.view3.addShadow()
        self.view4.addShadow()
        
        self.dottedLine1.createDottedLine(width: 1, color: #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1))
        self.dottedLine2.createDottedLine(width: 1, color: #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1))
        self.dottedLine3.createDottedLine(width: 1, color: #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1))
        self.dottedLine4.createDottedLine(width: 1, color: #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1))
        
        
        self.statusBox.layer.borderWidth = 0.5
        self.statusBox2.layer.borderWidth = 0.5
        self.statusBox3.layer.borderWidth = 0.5
        self.statusBox4.layer.borderWidth = 0.5
        self.statusBox.layer.borderColor = #colorLiteral(red: 0.4391697049, green: 0.4392478466, blue: 0.4391593933, alpha: 1)
        self.statusBox2.layer.borderColor = #colorLiteral(red: 0.4391697049, green: 0.4392478466, blue: 0.4391593933, alpha: 1)
        self.statusBox3.layer.borderColor = #colorLiteral(red: 0.4391697049, green: 0.4392478466, blue: 0.4391593933, alpha: 1)
        self.statusBox4.layer.borderColor = #colorLiteral(red: 0.4391697049, green: 0.4392478466, blue: 0.4391593933, alpha: 1)
    }

}
