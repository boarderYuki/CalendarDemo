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
    //var rotationAngle: CGFloat!
    let customWidth: CGFloat = 60
    let customHeight: CGFloat = 80
    
    var pickerMonth = ["01", "02", "03", "04", "05", "06", "07", "08", "09", "10", "11", "12", "01", "02", "03", "04"]
    var pickerYear = ["2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2017", "2018", "2018", "2018", "2018"]
    
    let dateFormatter = DateFormatter()
    var userDefaults = UserDefaults.standard
    
//    fileprivate var configuration = NaviConfig()
//    fileprivate var menuArrow: UIImageView!
//    var dropDownViewHeight: NSLayoutConstraint!
    
    
//    func rotateArrow() {
//        let gf = ViewController().dropDownViewHeight.constant
//        print(gf)
//        menuArrow = UIImageView(image: configuration.arrowImage)
//        //menuArrow.frame = CGRect(x: ViewController().titleSize.width + configuration.arrowPadding, y: (ViewController().navigationController!.navigationBar.frame.height - 18) / 2, width: 18, height: 18)
//        //menuArrow.tintColor = configuration.arrowTintColor
//
//        UIView.animate(withDuration: configuration.animationDuration, animations: {[weak self] () -> () in
//            if let selfie = self {
//                selfie.menuArrow.transform = selfie.menuArrow.transform.rotated(by: 180 * CGFloat(Double.pi/180))
//            }
//            if self?.dropDownViewHeight.constant == 50 {
//                self?.dropDownViewHeight.constant = 0
//            } else {
//                self?.dropDownViewHeight.constant = 50
//            }
//        })
//    }
    
    
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
        dateFormatter.dateFormat = "yyyyMMdd"
        dateFormatter.timeZone = TimeZone.current
        let selectedDate = selectedYear + selectedMonth + "01"
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
