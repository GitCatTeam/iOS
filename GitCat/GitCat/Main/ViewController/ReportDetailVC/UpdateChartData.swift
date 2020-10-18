//
//  UpdateChartData.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import UIKit

extension ReportDetailVC {
    func updateLineChartData() {
        let lineChartFrame = CGRect(x: 0, y: 0, width: self.lineChart.frame.width, height: self.lineChart.frame.height)
        let lineChartView = LineChartView(frame: lineChartFrame, values: commitNumbers, dates: days, animated: true)
        lineChartView.center = CGPoint(x: self.lineChart.frame.size.width / 2, y: self.lineChart.frame.size.height / 2)
        
        self.lineChart.addSubview(lineChartView)
    }

    func updatePieChartData() {
        let pieChartFrame = CGRect(x: 0, y: 0, width: self.pieChart.frame.width, height: self.pieChart.frame.height)
         let pieChartColors = [ #colorLiteral(red: 0.537254902, green: 0.8, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0.7960784314, green: 0.9215686275, blue: 1, alpha: 1), #colorLiteral(red: 0.9490196078, green: 0.9803921569, blue: 1, alpha: 1), #colorLiteral(red: 0.9333333333, green: 0.9333333333, blue: 0.9333333333, alpha: 1) ]
        let pieChartView = PieChartView(frame: pieChartFrame, values: self.percentOfLanguage, colors: pieChartColors, width: Double(self.pieChart.frame.size.width))
        pieChartView.center = CGPoint(x: self.pieChart.frame.size.width / 2, y: self.pieChart.frame.size.height / 2)
        self.pieChart.addSubview(pieChartView)
        
        addPieChartLabel()
    }
    
    func addPieChartLabel() {
        //설명 Label 추가
        var pieChartDesciptionLabel: UILabel!
        pieChartDesciptionLabel = UILabel(frame: CGRect(x: self.pieChart.frame.width/2, y: self.pieChart.frame.height/2, width: 50, height: 50))
        pieChartDesciptionLabel.center = CGPoint(x: self.pieChart.frame.size.width / 2, y: self.pieChart.frame.size.height / 2)
        pieChartDesciptionLabel.numberOfLines = 2
        
        let paragraphStyle = NSMutableParagraphStyle(); paragraphStyle.alignment = .center
        let myAttribute = [ NSAttributedString.Key.font: UIFont(name: "BBTreeG_B", size: 12.0)!,
                                        NSAttributedString.Key.foregroundColor : #colorLiteral(red: 0.4392156863, green: 0.4392156863, blue: 0.4392156863, alpha: 1),
                                        NSAttributedString.Key.paragraphStyle: paragraphStyle
                                    ]
        let ratio = "Ratio\n(%)".localized()
        let myAttrString = NSAttributedString(string: ratio, attributes: myAttribute)
        pieChartDesciptionLabel.attributedText = myAttrString
        pieChartDesciptionLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        pieChart.addSubview(pieChartDesciptionLabel)
    }

    func updateBarChartData() {
        let barChartFrame = CGRect(x: 0, y: 0, width: self.barChart.frame.width, height: self.barChart.frame.height)
        let barChartColors = [ #colorLiteral(red: 0.8, green: 0.9215686275, blue: 1, alpha: 1), #colorLiteral(red: 0.5411764706, green: 0.7960784314, blue: 0.9647058824, alpha: 1), #colorLiteral(red: 0.9490196078, green: 0.9803921569, blue: 1, alpha: 1)]
        let barTitles:[String] = repositories
        let barValues:[Double] = repoCommits
        let barChartView = BarChartView(frame: barChartFrame, values: barValues, titles: barTitles, colors: barChartColors, animated: true)
        
        barChartView.center = CGPoint(x: self.barChart.frame.size.width / 2, y: self.barChart.frame.size.height / 2)
        self.barChart.addSubview(barChartView)
    }
}
