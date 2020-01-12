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
    @IBOutlet weak var lineChart: LineChartView!
    @IBOutlet weak var barChart: BarChartView!
    
    
    
    //FIXME: PIECHART - 임의로 이해를 돕기 위해 넣어두는 더미 데이터
    var iosDataEntry = PieChartDataEntry(value: 20)
    var macDataEntry = PieChartDataEntry(value: 30)
    
    //FIXME: LINECHART - 임의로 이해를 돕기 위해 넣어두는 더미 데이터
    var numbers : [Double] = [10.0,40.0,20.0]
    
    //FIXME: BARCHART - 임의로 이해를 돕기 위해 넣어두는 더미 데이터
    var months: [String]!
    var dataEntries = [BarChartDataEntry]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        updateLineChartData()
        updatePieChartData()
        updateBarChartData()

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
        line.drawValuesEnabled = false
        let data = LineChartData()
        data.addDataSet(line)
        
        lineChart.xAxis.labelPosition = .bottom
        lineChart.xAxis.drawGridLinesEnabled = false
        
        lineChart.leftAxis.gridColor = UIColor(red: 192/255, green: 192/255, blue: 192/255, alpha: 1)
        lineChart.rightAxis.drawAxisLineEnabled = false
        lineChart.rightAxis.drawGridLinesEnabled = false
        lineChart.rightAxis.drawLabelsEnabled = false
        
        
        
        lineChart.legend.enabled = false
        lineChart.chartDescription?.text = ""
        lineChart.doubleTapToZoomEnabled = false
        
        
        lineChart.data = data
        
    }
    func updatePieChartData() {
        //일단 다 때려넣을테니 나중에 다시 정리 ^^
        
        var numberOfDownloadsDataEntries = [PieChartDataEntry]()
        
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
        let chartDataSet = PieChartDataSet(entries: numberOfDownloadsDataEntries, label: nil)
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        //색 리스트 초기화해주는 공간
        let colors = [UIColor.CustomColor.skyBlue, UIColor.CustomColor.brownishGrey]
        chartDataSet.colors = colors
        
        pieChart.data = chartData
    }
    
    func updateBarChartData() {
        
        months = ["Jan", "Feb", "Mar"]
        let unitSold = [20.0, 4.0, 6.0]
        setBarChart(dataPoints: months, values: unitSold)
        
    }
    func setBarChart(dataPoints: [String], values: [Double]) {
        barChart.noDataText = "You need to provide data for the chart."

        for i in 0..<dataPoints.count {
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries, label: "Units Sold")

        let chartData = BarChartData(dataSet: chartDataSet)
            

        barChart.data = chartData
    }

}
