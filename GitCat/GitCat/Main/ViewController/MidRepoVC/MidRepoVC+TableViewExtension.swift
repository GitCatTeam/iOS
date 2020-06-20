//
//  MidRepoVC+TableViewExtension.swift
//  GitCat
//
//  Created by 조윤영 on 2020/06/20.
//  Copyright © 2020 조윤영. All rights reserved.
//

import Foundation
import UIKit
import FSCalendar

extension MidRepoVC:  UITableViewDelegate, UITableViewDataSource  {
    func numberOfSections(in tableView: UITableView) -> Int {
        return commits.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return commits[section].commit?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? CommitDetailTVCell
        
        cell?.commitLabel.text = commits[indexPath.section].commit?[indexPath.row].message ?? ""
        cell?.timeLabel.text = commits[indexPath.section].commit?[indexPath.row].time ?? ""
        
        cell?.circleView.circleRadius()
        
        if(indexPath.row == commits[indexPath.section].commit!.count-1) {
            cell?.lineView.backgroundColor = UIColor.white
        }else{
            cell?.lineView.backgroundColor = #colorLiteral(red: 0.7529411765, green: 0.7529411765, blue: 0.7529411765, alpha: 1)
        }
        
        return cell!
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let height = tableView.frame.width/20
        return height
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
        } else {
            return nil
        }
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {

        if monthPosition == .next || monthPosition == .previous {
            calendar.setCurrentPage(date, animated: true)
        }
        
        if(commitCountDetailData.data?.detailCommits[self.formatter.string(from: date)] == nil) {
            noneCommitView.alpha = 1
            tableView.alpha = 0
        
            calendar.appearance.selectionColor = UIColor.white
        
        } else {
            self.setCurrentDayColor(commitCount: self.gino(self.commitCountDetailData.data?.detailCommits[self.formatter.string(from: date)]?.count))
        
            noneCommitView.alpha = 0
            tableView.alpha = 1
            
            self.scoreLabel.text = "+\(self.gino(commitCountDetailData.data?.detailCommits[self.formatter.string(from: date)]?.score))"
            self.totalCommitLabel.text = "+\(self.gino(commitCountDetailData.data?.detailCommits[self.formatter.string(from: date)]?.count))"

            let item = gsno(commitCountDetailData.data?.detailCommits[self.formatter.string(from: date)]?.levelUp)
            self.itemLabel.text = item
            
            if(item == "") {
                self.noneItem.alpha = 1
                self.itemLabel.alpha = 0
            } else {
                self.noneItem.alpha = 0
                self.itemLabel.alpha = 1
            }
            
            setCommitData(date:self.formatter2.string(from: date))
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("\(self.formatter.string(from: calendar.currentPage))")

        let values = Calendar.current.dateComponents([Calendar.Component.month, Calendar.Component.year], from: self.calendar.currentPage)
               
        let intYear:Int = gino(values.year)
        let intMonth:Int = gino(values.month)

        setCalendarCommitBackgroundColor(year: intYear, month: intMonth, isFirst:false)
    }
    
    func calendar(_ calendar: FSCalendar, appearance: FSCalendarAppearance, fillDefaultColorFor date: Date) -> UIColor? {
        let dateString = self.formatter.string(from: date)
        
        if self.commitLevel1.contains(dateString) {
                return #colorLiteral(red: 0.8705882353, green: 0.9450980392, blue: 0.9882352941, alpha: 1)
            } else if self.commitLevel2.contains(dateString) {
                return #colorLiteral(red: 0.7294117647, green: 0.8784313725, blue: 0.968627451, alpha: 1)
            } else if self.commitLevel3.contains(dateString) {
                return #colorLiteral(red: 0.537254902, green: 0.8039215686, blue: 0.9647058824, alpha: 1)
            }else{
                return #colorLiteral(red: 1, green: 1, blue: 1, alpha: 1)
            }
        }
}
