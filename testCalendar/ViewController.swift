//
//  ViewController.swift
//  testCalendar
//
//  Created by yuki.pro on 2017. 10. 23..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit
import FSCalendar

class ViewController: UIViewController {

    //@IBOutlet weak var titleButton: UIButton!
    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dropDownViewHeight: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    
    var datePicker: DatePicker!
    var rotationAngle: CGFloat!
    let customHeight: CGFloat = 80
    let formatter = DateFormatter()
    
    var userDefaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dropDownViewHeight.constant = 0
        
        datePicker = DatePicker()
        pickerView.delegate = datePicker
        pickerView.dataSource = datePicker
        
        
        titleButton()
        rotatePickerView()

        //calendar.cellShape = .Rectangle //선택된 날짜의 형태가 네모로 표시되도록
        //calendar.allowsMultipleSelection = true //여러날짜를 동시에 선택할 수 있도록
        //calendar.clipsToBounds = true //달력 구분 선 제거
        //calendar = Carendar()
        calendar.delegate = calendar as? FSCalendarDelegate
        calendar.dataSource = calendar as? FSCalendarDataSource
        
        //calendar.scope = .week
        //calendar.appearance.headerDateFormat = "MMM yyyy"
        calendar.appearance.eventDefaultColor = UIColor.black
        calendar.appearance.weekdayTextColor = UIColor.black
        calendar.appearance.titleWeekendColor = UIColor.FlatColor.Red.WellRead
        calendar.appearance.headerTitleColor = UIColor.green
        //calendar.placeholderType = .none
        //let a = formatter.date(from: "2016-01-01")
        //let a = DateFormatter.dateFromString(from: "2016-01-01")
        //print(a)
        //calendar.selectedDate(.a)
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        //NotificationCenter.default.addObserver(self, selector: #selector(saveWidgetDidChange), name: userDefaults.object(forKey: "naviTitle") as? NSNotification.Name, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(saveWidgetDidChange), name: UserDefaults.didChangeNotification, object: nil)
        
    }
    
    override func viewDidDisappear(_ animated: Bool) {
       
        super.viewDidDisappear(true)
        //NotificationCenter.default.removeObserver(self, name: userDefaults.object(forKey: "naviTitle") as? NSNotification.Name, object: nil)
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
        
    }
    
    
//    // 각 날짜에 특정 문자열을 표시할 수 있습니다. 이미지를 표시하는 메소드도 있으니 API를 참조하세요.
////    func calendar(_ calendar: FSCalendar, subtitleFor date: Date) -> String? {
////        return "W"
////    }
//    
//    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
//    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
//        print(date)
//        print("did select date \(self.dateFormatter.string(from: date))")
//        let selectedDates = calendar.selectedDates.map({self.dateFormatter.string(from: $0)})
//        print("selected dates is \(selectedDates)")
//        //print(date)
//        dateFormatter.dateFormat = "yyyy"
//        print(dateFormatter.string(from: date))
//        dateFormatter.dateFormat = "MM"
//        print(dateFormatter.string(from: date))
//        dateFormatter.dateFormat = "dd"
//        print(dateFormatter.string(from: date))
//    }
//    
//    // 스와이프를 통해서 다른 달(month)의 달력으로 넘어갈 때 발생하는 이벤트를 이 곳에서 처리할 수 있겠네요.
//    func calendarCurrentMonthDidChange(_ calendar: FSCalendar) {
//        print(calendar)
//    }
//    
////    func calendar(calendar: FSCalendar!, hasEventForDate date: NSDate!) -> Bool {
////        return shouldShowEventDot
////    }
//    
    func rotatePickerView() {
        
        rotationAngle = -90 * (.pi/180)
        let y = pickerView.frame.origin.y
        print(y)
        pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        
        pickerView.frame = CGRect(x: -150, y: y, width: view.frame.width + 300, height: customHeight)
        
        pickerView.selectRow(2, inComponent: 0, animated: true)
        
    }
    
    fileprivate var configuration = NaviConfig()
    fileprivate var menuButton: UIButton!
    fileprivate var menuTitle: UILabel!
    fileprivate var menuArrow: UIImageView!
    var titleToDisplay: String = ""
    let date = Date()
    var titleSize = CGSize()
    
    func titleButton() {
        //var titleSize: CGSize
        
        if let dt = userDefaults.object(forKey: "naviTitle") {
            titleToDisplay = dt as! String
            print("titleToDisplay 111111", titleToDisplay)
        } else {
            formatter.dateFormat = "MMMM yyyy"
            //formatter.timeZone = TimeZone.current
            
            titleToDisplay = "\(formatter.string(from: date))"
            print("titleToDisplay 222222", titleToDisplay)
        }
        
       
        
        titleSize = (titleToDisplay as NSString).size(withAttributes: [NSAttributedStringKey.font:configuration.navigationBarTitleFont])
   
        //let titleCenter = view.frame.width - (CGFloat(titleSize.width)) / 2
        //print(titleSize, titleCenter)
        // Set frame
        let frame = CGRect(x: 0, y: 0, width: titleSize.width + (configuration.arrowPadding + configuration.arrowImage.size.width), height: navigationController!.navigationBar.frame.height)
        self.navigationItem.titleView?.frame = frame
        //let frame = CGRect(x: titleCenter, y: 0, width: titleSize.width, height: navigationController!.navigationBar.frame.height)
        
        //super.init(frame:frame)

        //let titleButton =  UIButton(type: .custom)
        //button.frame = CGRectMake(0, 0, 100, 40) as CGRect
        //titleButton.frame = CGRect(x: 0, y: 0, width: 130, height: 40)

        // Init button as navigation title
        menuButton = UIButton(frame: frame)
        //menuButton.addTarget(self, action: #selector(BTNavigationDropdownMenu.menuButtonTapped(_:)), for: UIControlEvents.touchUpInside)
        menuButton.addTarget(self, action: #selector(self.clickOnTitleButton), for: UIControlEvents.touchUpInside)
        //self.addSubview(self.menuButton)
        
        menuTitle = UILabel()
        //menuTitle.frame = CGRect(x: 0, y: 0, width: titleSize.width, height: navigationController!.navigationBar.frame.height)
        //menuTitle = UILabel(frame: frame)
        menuTitle.frame = CGRect(x: 0, y: 0, width: titleSize.width, height: navigationController!.navigationBar.frame.height)
        menuTitle.text = titleToDisplay
        menuTitle.textColor = configuration.menuTitleColor
        menuTitle.font = configuration.navigationBarTitleFont
        menuTitle.textAlignment = configuration.cellTextLabelAlignment
        menuButton.addSubview(menuTitle)
        
        menuArrow = UIImageView(image: configuration.arrowImage)
        menuArrow.frame = CGRect(x: titleSize.width + configuration.arrowPadding, y: (navigationController!.navigationBar.frame.height - 18) / 2, width: 18, height: 18)
        menuArrow.tintColor = configuration.arrowTintColor
        menuButton.addSubview(menuArrow)
        

        self.navigationItem.titleView = menuButton
    }
    
    
    @objc func clickOnTitleButton() {
        
        rotateArrow()
        print("fdsafdsa")
    }
    
 
    func rotateArrow() {
        UIView.animate(withDuration: configuration.animationDuration, animations: {[weak self] () -> () in
            if let selfie = self {
                selfie.menuArrow.transform = selfie.menuArrow.transform.rotated(by: 180 * CGFloat(Double.pi/180))
            }
            if self?.dropDownViewHeight.constant == 50 {
                UIView.animate(withDuration: 0.5) {
                    self?.dropDownViewHeight.constant = 0
                    self?.view.layoutIfNeeded()
                }
            } else {
                UIView.animate(withDuration: 0.5) {
                    self?.dropDownViewHeight.constant = 50
                    self?.view.layoutIfNeeded()
                }
            }
        })
    }
    
    @objc func saveWidgetDidChange() {
        
        if let d = userDefaults.object(forKey: "naviTitle") {
            titleToDisplay = d as! String
            
            titleSize = (titleToDisplay as NSString).size(withAttributes: [NSAttributedStringKey.font:configuration.navigationBarTitleFont])

            let frame = CGRect(x: 0, y: 0, width: titleSize.width + (configuration.arrowPadding + configuration.arrowImage.size.width), height: navigationController!.navigationBar.frame.height)
            self.navigationItem.titleView?.frame = frame

            
            menuButton = UIButton(frame: frame)
            
            menuTitle.frame = CGRect(x: 0, y: 0, width: titleSize.width, height: navigationController!.navigationBar.frame.height)
            menuTitle.text = titleToDisplay
            menuArrow.frame = CGRect(x: titleSize.width + configuration.arrowPadding, y: (navigationController!.navigationBar.frame.height - 18) / 2, width: 18, height: 18)
            
            
            //self.navigationItem.titleView?.layoutIfNeeded()
            //calendar.setCurrentPage(d as! Date, animated: false)
            print("유저디폴트 변함")
        }
        
        if let nd : Date = userDefaults.object(forKey: "naviDate") as? Date {
            
            //formatter.dateFormat = "yyyyMMddhhmmss"
            //let date = formatter.date(from: nd as Date)

            //let date:NSDate = nd as! NSDate
            print("nd", nd)
            calendar.setCurrentPage(nd, animated: false)
        }
    }
    
    @IBAction func goTodayButton(_ sender: Any) {
        //calendar.reloadData()
        calendar.setCurrentPage(Date(), animated: false)
        
        print("goToday")
    }
}

