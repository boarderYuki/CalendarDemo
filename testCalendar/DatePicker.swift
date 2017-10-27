//
//  DatePicker.swift
//  testCalendar
//
//  Created by yuki.pro on 2017. 10. 25..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit

class DatePicker: UIPickerView {
    var selectedMonth: String = ""
    var selectedYear: String = ""
    let customWidth: CGFloat = 60
    let customHeight: CGFloat = 80
    
    var pickerMonth = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "01", "02", "03", "04"]
    var pickerYear = ["2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2018", "2018", "2018", "2018"]
    
    let dateFormatter = DateFormatter()
    var userDefaults = UserDefaults.standard
    
}

extension DatePicker: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return pickerMonth.count
    }
    
}

extension DatePicker: UIPickerViewDelegate {
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        selectedMonth = pickerMonth[row]
        selectedYear = pickerYear[row]
        
        dateFormatter.dateFormat = "yyyyMMddhhmmss"
        dateFormatter.timeZone = TimeZone.current
        let selectedDate = selectedYear + selectedMonth + "01000000"
        let date = dateFormatter.date(from: selectedDate)
        userDefaults.set(date, forKey: "naviDate")
        
        let date2 = dateFormatter.date(from: selectedDate)!
        
        dateFormatter.dateFormat = "MMMM yyyy"
        let final = dateFormatter.string(from: date2)
        userDefaults.set(final, forKey: "naviTitle")
        
        userDefaults.synchronize()
        print("피커선택", selectedMonth, selectedYear, selectedDate, date2, final)
    }
    
    func pickerView(_ pickerView: UIPickerView, rowHeightForComponent component: Int) -> CGFloat {
        return customHeight
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        let customView = UIView(frame: CGRect(x: 0, y: 0, width: customWidth, height: customHeight))
        //customView.backgroundColor = UIColor.green
        let topLabel = UILabel(frame: CGRect(x: 0, y: 8, width: customWidth, height: 20))
        topLabel.text = pickerMonth[row]
        topLabel.textColor = .white
        topLabel.textAlignment = .center
        topLabel.font = UIFont(name: "Verdana", size: 18)
        customView.addSubview(topLabel)
        
        let customLable2 = UILabel(frame: CGRect(x: 0, y: 18, width: customWidth, height: 30))
        customLable2.text = pickerYear[row]
        customLable2.textColor = .white
        customLable2.textAlignment = .center
        customLable2.font = UIFont(name: "Verdana", size: 13)
        customView.addSubview(customLable2)
        
        customView.transform = CGAffineTransform(rotationAngle: (90 * (.pi / 180)))
        return customView
    }
    
    
}
