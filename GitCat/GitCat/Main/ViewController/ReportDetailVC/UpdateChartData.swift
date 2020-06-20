//
//  UpdateChartData.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import Charts

extension ReportDetailVC {
    func updateLineChartData() {
        var lineChartEntries = [ChartDataEntry]()
        
        for i in 0..<commitNumbers.count {
            let value = ChartDataEntry(x: Double(i), y: Double(commitNumbers[i]))
            lineChartEntries.append(value)
        }
        
        let line = LineChartDataSet(entries:lineChartEntries, label:"Number")

        line.colors = [UIColor.clear]
        line.mode = .cubicBezier
        line.drawFilledEnabled = true
        line.fillColor = UIColor.CustomColor.skyBlue
        line.circleColors = [#colorLiteral(red: 0.537254902, green: 0.8, blue: 0.9647058824, alpha: 1)]
        line.drawCirclesEnabled = true
        line.drawCircleHoleEnabled = true
        line.circleRadius = 2
        line.circleHoleRadius = 1

        
        line.drawValuesEnabled = false
        let data = LineChartData()
        
        data.addDataSet(line)
        
        self.lineChart.xAxis.labelPosition = .bottom
        self.lineChart.xAxis.drawGridLinesEnabled = false
        self.lineChart.xAxis.axisLineDashPhase = CGFloat(signOf: 0,magnitudeOf: 0)
        self.lineChart.xAxis.gridColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.lineChart.xAxis.labelTextColor = UIColor.CustomColor.brownishGrey

        if UIDevice.current.model.hasPrefix("iPad") {
            self.lineChart.xAxis.labelFont = UIFont(name: "BBTreeGo_R", size: 18)!
        }else{
            self.lineChart.xAxis.labelFont = UIFont(name: "BBTreeGo_R", size: 11)!
        }
        
        self.lineChart.leftAxis.drawAxisLineEnabled = false
        self.lineChart.leftAxis.gridColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        self.lineChart.leftAxis.labelTextColor = #colorLiteral(red: 0.5320672393, green: 0.8002378345, blue: 0.9608486295, alpha: 1)
        self.lineChart.leftAxis.gridLineDashLengths = [2,3]
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.lineChart.leftAxis.labelFont = UIFont(name: "BBTreeGo_R", size: 18)!
        } else {
            self.lineChart.leftAxis.labelFont = UIFont(name: "BBTreeGo_R", size: 11)!
        }

        self.lineChart.rightAxis.drawAxisLineEnabled = false
        self.lineChart.rightAxis.drawGridLinesEnabled = false
        self.lineChart.rightAxis.drawLabelsEnabled = false
        
        self.lineChart.legend.enabled = false
        self.lineChart.chartDescription?.text = ""
        self.lineChart.doubleTapToZoomEnabled = false
        self.lineChart.pinchZoomEnabled = false
        
        self.lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:days)
        self.lineChart.xAxis.granularity = 1
        
        self.lineChart.data = data
        
    }

    func updatePieChartData() {

        self.pieChart.legend.enabled = false
                
        self.pieChart.chartDescription?.text = ""
        self.pieChart.centerText = "언어 비율\n(%)"
        self.pieChart.drawCenterTextEnabled = true
        self.pieChart.clipsToBounds = false
        self.pieChart.highlightPerTapEnabled = false
        self.pieChart.transparentCircleColor = UIColor.clear
        self.pieChart.transparentCircleRadiusPercent = 0.0

        let paragraphStyle = NSMutableParagraphStyle(); paragraphStyle.alignment = .center
        
        if UIDevice.current.model.hasPrefix("iPad") {
            let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "BBTreeGo_R", size: 20.0)!,
                                       NSAttributedString.Key.foregroundColor : UIColor.CustomColor.brownishGrey, NSAttributedString.Key.paragraphStyle: paragraphStyle
                   ]
            let myAttrString = NSAttributedString(string: "언어 비율\n(%)", attributes: myAttribute)
            self.pieChart.centerAttributedText = myAttrString
        }
        else{
            let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "BBTreeGo_R", size: 12.0)!,
                                NSAttributedString.Key.foregroundColor : UIColor.CustomColor.brownishGrey, NSAttributedString.Key.paragraphStyle: paragraphStyle
            ]
            let myAttrString = NSAttributedString(string: "언어 비율\n(%)", attributes: myAttribute)
            self.pieChart.centerAttributedText = myAttrString
        }
                   
        let chartDataSet = PieChartDataSet(entries: percentOfLanguageEntries, label: nil)
        
        chartDataSet.drawValuesEnabled = false
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        //색 리스트 초기화해주는 공간
        
        let colors = [#colorLiteral(red: 0.537254902, green: 0.8, blue: 0.9647058824, alpha: 1),#colorLiteral(red: 0.797280252, green: 0.9200312495, blue: 1, alpha: 1), #colorLiteral(red: 0.9490196078, green: 0.981259644, blue: 1, alpha: 1), #colorLiteral(red: 0.9332618117, green: 0.9333737493, blue: 0.9332236052, alpha: 1)]
        chartDataSet.colors = colors
        
        
        self.pieChart.data = chartData
    }

    func updateBarChartData() {
        setBarChart(dataPoints: repositories, values: repoCommits)
    }

    func setBarChart(dataPoints: [String], values: [Double]) {
        self.barChart.noDataText = "데이터가 없습니다."

        self.barChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:dataPoints)

        self.barChart.xAxis.granularity = 1
        self.barChart.xAxis.labelPosition = .bottom
        self.barChart.xAxis.labelTextColor = UIColor.CustomColor.brownishGrey
        
        if UIDevice.current.model.hasPrefix("iPad") {
            self.barChart.xAxis.labelFont = UIFont(name: "BBTreeGo_R", size: 18)!
        }else{
            self.barChart.xAxis.labelFont = UIFont(name: "BBTreeGo_R", size: 11)!
        }
        
        self.barChart.xAxis.drawGridLinesEnabled = false

        self.barChart.leftAxis.drawGridLinesEnabled = false
        self.barChart.leftAxis.drawAxisLineEnabled = false
        self.barChart.leftAxis.drawLabelsEnabled = false
        
        self.barChart.rightAxis.drawLabelsEnabled = false
        self.barChart.rightAxis.drawAxisLineEnabled = false
        self.barChart.rightAxis.drawGridLinesEnabled = false
        
        self.barChart.legend.enabled = false
        self.barChart.doubleTapToZoomEnabled = false
        self.barChart.pinchZoomEnabled = false
        self.barChart.highlightFullBarEnabled = false
        self.barChart.highlightPerTapEnabled = false
        self.barChart.highlightPerDragEnabled = false
        

        for i in 0..<dataPoints.count {
            
            let dataEntry = BarChartDataEntry(x: Double(i), yValues: [values[i]])
            dataEntries1.append(dataEntry)
        }

        let chartDataSet = BarChartDataSet(entries: dataEntries1, label: nil)
        
        chartDataSet.colors = [#colorLiteral(red: 0.8022227883, green: 0.9198918939, blue: 1, alpha: 1), #colorLiteral(red: 0.5390568376, green: 0.7959131598, blue: 0.9652681947, alpha: 1), #colorLiteral(red: 0.8410330415, green: 0.8754420877, blue: 0.8878466487, alpha: 1)]
        
        
        let chartData = BarChartData(dataSet: chartDataSet)
        chartData.barWidth = 0.3

        self.barChart.data = chartData
    }
}
