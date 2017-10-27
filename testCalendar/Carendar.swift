//
//  Carendar.swift
//  testCalendar
//
//  Created by yuki.pro on 2017. 10. 25..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit
import FSCalendar

class Carendar: FSCalendar, FSCalendarDataSource, FSCalendarDelegate {

    //let gregorian = Calendar(identifier: .gregorian)
    var userDefaults = UserDefaults.standard
    
    fileprivate lazy var dateFormatter: DateFormatter = {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy/MM/dd"
        //formatter.timeZone = TimeZone.current
        return formatter
    }()
    
    // 각 날짜에 특정 문자열을 표시할 수 있습니다. 이미지를 표시하는 메소드도 있으니 API를 참조하세요.
    //    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
    //        return "W"
    //    }
    
//    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
//    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
//        print(date)
//        
//        print("did select date \(self.dateFormatter.string(from: date))")
//        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
//        print("selected dates is \(selectedDates)")
//        
//        let storyboard = UIStoryboard(name: "Main", bundle: nil)
//        let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as! ViewController
//        mainVC.selectedLabel.text = self.dateFormatter.string(from: date)
//        
//        //print(date)
//        dateFormatter.dateFormat = "yyyy"
//        print(dateFormatter.string(from: date))
//        dateFormatter.dateFormat = "MM"
//        print(dateFormatter.string(from: date))
//        dateFormatter.dateFormat = "dd"
//        print(dateFormatter.string(from: date))
//        
//
//        
//    }
    
    // 스와이프를 통해서 다른 달(month)의 달력으로 넘어갈 때 발생하는 이벤트를 이 곳에서 처리할 수 있겠네요.
//    func calendarCurrentMonthDidChange(_ calendar: FSCalendar) {
//        print(calendar)
//    }
    
//    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
//        dateFormatter.dateFormat = "yyyy/MM/dd"
//        print("did select date \(self.dateFormatter.string(from: date))")
//        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
//        print("selected dates is \(selectedDates)")
//        if monthPosition == .next || monthPosition == .previous {
//            
//            calendar.setCurrentPage(date, animated: true)
//        }
//    }
//    
//    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
//        print("달력스와이프")
//        dateFormatter.dateFormat = "MMMM yyyy"
//        let navi = self.dateFormatter.string(from: calendar.currentPage)
//        userDefaults.set(navi, forKey: "naviTitle")
//        
//        let naviDate = self.dateFormatter.string(from: calendar.currentPage)
//        dateFormatter.dateFormat = "yyyyMMddhhmmss"
//        let date = dateFormatter.date(from: naviDate)
//        //selectedDate = dateFormatter.date(from: selectedDate)
//        userDefaults.set(date, forKey: "naviDate")
//        print("\(self.dateFormatter.string(from: calendar.currentPage))")
//    }


}

