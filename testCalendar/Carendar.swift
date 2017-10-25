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
    
    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        print(date)
        
        print("did select date \(self.dateFormatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        //print(date)
        dateFormatter.dateFormat = "yyyy"
        print(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "MM"
        print(dateFormatter.string(from: date))
        dateFormatter.dateFormat = "dd"
        print(dateFormatter.string(from: date))
    }
    
    // 스와이프를 통해서 다른 달(month)의 달력으로 넘어갈 때 발생하는 이벤트를 이 곳에서 처리할 수 있겠네요.
    func calendarCurrentMonthDidChange(_ calendar: FSCalendar) {
        print(calendar)
    }
    
    //    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
    //        return shouldShowEventDot
    //    }
    

}

