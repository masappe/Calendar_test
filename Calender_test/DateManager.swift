//
//  DateManager.swift
//  Calender_test
//
//  Created by Masato Hayakawa on 2019/05/06.
//  Copyright © 2019 masappe. All rights reserved.
//

import Foundation

extension Date {
    //前の月の取得
    func monthAgoDate() -> Date? {
        let addValue = -1
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents, to: self)
    }
    //次の月の取得
    func monthLaterDate() -> Date? {
        let addValue = 1
        let calendar = Calendar.current
        var dateComponents = DateComponents()
        dateComponents.month = addValue
        return calendar.date(byAdding: dateComponents, to: self)
    }
    
}

class DateManager {
    
    var currentMonthOfDates = [Date]()
    var selectedDate = Date()
    let daysPerWeek: Int = 7
    //週の数*列の数
    var numberOfItems: Int!
    
    //月ごとのセルの数を取得
    func daysAcquisition() -> Int {
        if let date = firstDateOfMonth(), let rangeOfWeeks = Calendar.current.range(of: .weekOfMonth, in: .month, for: date) {
            let numberOfweeks = rangeOfWeeks.count
            numberOfItems = numberOfweeks * daysPerWeek
            return numberOfItems
        }
        return 0
    }
    //月の初日を取得
    func firstDateOfMonth() -> Date? {
        var components = Calendar.current.dateComponents([.year,.month,.day], from: selectedDate)
        components.day = 1
        if let firstDateMonth = Calendar.current.date(from: components) {
            return firstDateMonth
        }
        return nil
    }
    //表記する日にちを取得
    func dateForCellAtIndexPath(numberOfItems: Int) {
        if let firstDateOfMonth = firstDateOfMonth(),let ordinalityOfFitstDay = Calendar.current.ordinality(of: .day, in: .weekOfMonth, for: firstDateOfMonth) {
            print(ordinalityOfFitstDay)
            for i in 0..<numberOfItems {
                var dateComponents = DateComponents()
                dateComponents.day = i - (ordinalityOfFitstDay - 1)
                if let date = Calendar.current.date(byAdding: dateComponents, to: firstDateOfMonth) {
                    currentMonthOfDates.append(date)
                }
            }
        }
    }
    //表記の変更
    func conversionDateFormat(indexPath: IndexPath) -> String {
        dateForCellAtIndexPath(numberOfItems: numberOfItems)
        let formatter = DateFormatter()
        formatter.dateFormat = "d"
        return formatter.string(from: currentMonthOfDates[indexPath.row])
    }
    //前の月へ
    func prevMonth(date: Date) -> Date? {
        currentMonthOfDates = []
        if let date = date.monthAgoDate() {
            selectedDate = date
            return selectedDate
        }
        return nil
    }
    //次の月へ
    func nextMonth(date: Date) -> Date? {
        currentMonthOfDates = []
        if let date = date.monthLaterDate() {
            selectedDate = date
            return selectedDate
        }
        return nil
    }
}
