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
    var repositories = [String]() // "레파1", "레파2", "레파3"
    var repoCommits = [Double]() //20, 4, 6.0
    var dataEntries1 = [BarChartDataEntry]()
    var dataEntries2 = [BarChartDataEntry]()
    
    var id:Int!
    var reportTitle:String!
    var totalCommit:String!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadingView.alpha = 1
        loadingBackgroundView.alpha = 1
        
        self.navigationItem.title = reportTitle
        let textAttributes = [NSAttributedString.Key.foregroundColor:UIColor(red: 137/255, green: 204/255, blue: 246/255, alpha: 1)]
               navigationController?.navigationBar.titleTextAttributes = textAttributes
        
        percentOfLanguageEntries = [] //사용언어비율 pieChart 데이터 초기화
        setBackBtn(color: UIColor.CustomColor.brownishGrey)
        
        loadingView.loadGif(name: "gif_loading2")
        
        totalCount.text = totalCommit
        setReportDetailData(id: id)
        
        setStyle()
        setFontSize()
        
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        self.dottedLine1.createDottedLine(width: 1, color: #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1))
        self.dottedLine2.createDottedLine(width: 1, color: #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1))
        self.dottedLine3.createDottedLine(width: 1, color: #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1))
        self.dottedLine4.createDottedLine(width: 1, color: #colorLiteral(red: 0.7528660893, green: 0.7529937625, blue: 0.7528492808, alpha: 1))
        
    }
    
    
    func setFontSize() {
        descLabel1.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        descLabel2.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        descLabel3.dynamicFont(fontSize: 14, name: "BBTreeG_B")
        
        compareCount.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        totalCount.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        averageCount.dynamicFont(fontSize: 20, name: "BBTreeG_B")
        
        commitDescLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        languageDescLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        repoDescLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        finalDescLabel.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        top3Label.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        statusLabel1.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        statusPercentLabel1.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        statusLabel2.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        statusPercentLabel2.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        statusLabel3.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        statusPercentLabel3.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        statusLabel4.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        statusPercentLabel4.dynamicFont(fontSize: 12, name: "BBTreeG_B")
        
        description1.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        description2.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        description3.dynamicFont(fontSize: 11, name: "BBTreeGo_R")
        
    }
    
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
        
        
        
        lineChart.xAxis.valueFormatter = IndexAxisValueFormatter(values:days)
        lineChart.xAxis.granularity = 1
        
        lineChart.data = data
        
    }
    
    func updatePieChartData() {

        pieChart.legend.enabled = false
                
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
        let chartDataSet = PieChartDataSet(entries: percentOfLanguageEntries, label: nil)
        chartDataSet.drawValuesEnabled = false
        
        let chartData = PieChartData(dataSet: chartDataSet)
        
        //색 리스트 초기화해주는 공간
        
        let colors = [#colorLiteral(red: 0.4854287505, green: 0.7172181606, blue: 0.8653311133, alpha: 1),#colorLiteral(red: 0.797280252, green: 0.9200312495, blue: 1, alpha: 1), #colorLiteral(red: 0.9469732642, green: 0.981259644, blue: 0.9980216622, alpha: 1), #colorLiteral(red: 0.9332618117, green: 0.9333737493, blue: 0.9332236052, alpha: 1)]
        chartDataSet.colors = colors
        
        
        pieChart.data = chartData
    }
    
    func updateBarChartData() {
        setBarChart(dataPoints: repositories, values: repoCommits)
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

        let chartDataSet = BarChartDataSet(entries: dataEntries1, label: nil)
        
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

extension ReportDetailVC {
    func setReportDetailData(id:Int) {
        ReportDetailService.sharedInstance.getReportDetail(id: id) { (result) in
            switch result {
            case .networkSuccess(let data):
                let reportDetailData = data as? ReportDetailModel
                
                if let resResult = reportDetailData {
                    print("[\(String(describing: resResult.message))]")
                    
                    //comment
                    self.description1.text = resResult.data?.comment?[0]
                    self.description2.text = resResult.data?.comment?[1]
                    self.description3.text = resResult.data?.comment?[2]
      
                    //상위 수치 3개
                    self.averageCount.text = resResult.data?.avgCount
                    self.compareCount.text = "+\(self.gsno(resResult.data?.comparedLastMonth))"
                    
                    //커밋수 통계 - Line Chart
                    self.days = resResult.data?.dailyCount?.dayArray  as! [String]
                    self.commitNumbers = resResult.data?.dailyCount?.countArray as! [Int]
                    
                    //사용 언어 비율 - Pie Chart
                    //PieChartDataEntry(value: 10)
                    let ratios:[Double] = resResult.data?.languageRatio?.percentArray as! [Double]
                    for ratio in ratios {
                        print(ratio)
                        self.percentOfLanguageEntries += [PieChartDataEntry(value: ratio)]
                    }
                    
                    let resultLanguageList:[ResultLanguagesModel] = resResult.data?.languageRatio?.resultLanguages as! [ResultLanguagesModel]
                    
                    
                    if (resultLanguageList.count == 1) {
                        self.statusView1.alpha = 1
                        
                        self.statusLabel1.text = resultLanguageList[0].language
                        
                        self.statusPercentLabel1.text = "\(self.gdno(resultLanguageList[0].percent))"
                        
                    }else if (resultLanguageList.count == 2) {
                        self.statusView1.alpha = 1
                        self.statusView2.alpha = 1
                        
                        self.statusLabel1.text = resultLanguageList[0].language
                        self.statusLabel2.text = resultLanguageList[1].language
                        
                        self.statusPercentLabel1.text = "\(self.gdno(resultLanguageList[0].percent))"
                        self.statusPercentLabel2.text = "\(self.gdno(resultLanguageList[1].percent))"
                        
                    }else if (resultLanguageList.count == 3) {
                        self.statusView1.alpha = 1
                        self.statusView2.alpha = 1
                        self.statusView3.alpha = 1
                        
                        self.statusLabel1.text = resultLanguageList[0].language
                        self.statusLabel2.text = resultLanguageList[1].language
                        self.statusLabel3.text = resultLanguageList[2].language
                        
                        self.statusPercentLabel1.text = "\(self.gdno(resultLanguageList[0].percent))"
                        self.statusPercentLabel2.text = "\(self.gdno(resultLanguageList[1].percent))"
                        self.statusPercentLabel3.text = "\(self.gdno(resultLanguageList[2].percent))"
                        
                    }else if (resultLanguageList.count == 4) {
                        self.statusView1.alpha = 1
                        self.statusView2.alpha = 1
                        self.statusView3.alpha = 1
                        self.statusView4.alpha = 1
                        
                        self.statusLabel1.text = resultLanguageList[0].language
                        self.statusLabel2.text = resultLanguageList[1].language
                        self.statusLabel3.text = resultLanguageList[2].language
                        self.statusLabel4.text = resultLanguageList[3].language
                        
                        self.statusPercentLabel1.text = "\(self.gdno(resultLanguageList[0].percent))"
                        self.statusPercentLabel2.text = "\(self.gdno(resultLanguageList[1].percent))"
                        self.statusPercentLabel2.text = "\(self.gdno(resultLanguageList[2].percent))"
                        self.statusPercentLabel2.text = "\(self.gdno(resultLanguageList[3].percent))"
                    }
                    
                    self.repositories = resResult.data?.contributedRepository?.repoNames as! [String]
                    self.repoCommits = resResult.data?.contributedRepository?.count as! [Double]
                    
                    self.updateLineChartData()
                    self.updatePieChartData()
                    self.updateBarChartData()
                    
                    self.loadingView.alpha = 0
                    self.loadingBackgroundView.alpha = 0
                    
                }
                break
                
            case .networkFail:
                self.networkErrorAlert()
                self.loadingView.alpha = 0
                self.loadingBackgroundView.alpha = 0
            default:
                self.simpleAlert(title: "오류 발생!", message: "다시 시도해주세요.")
                self.loadingView.alpha = 0
                self.loadingBackgroundView.alpha = 0
                break
            }
        }
    }
}

