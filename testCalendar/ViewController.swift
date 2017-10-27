//
//  ViewController.swift
//  testCalendar
//
//  Created by yuki.pro on 2017. 10. 23..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit
import FSCalendar

class ViewController: UIViewController, FSCalendarDataSource, FSCalendarDelegate, UIGestureRecognizerDelegate{

    @IBOutlet weak var calendar: FSCalendar!
    @IBOutlet weak var dropDownViewHeight: NSLayoutConstraint!
    @IBOutlet weak var calendarHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var selectedLabel: UILabel!
    @IBOutlet weak var tableView: UITableView!
    
    // 가로 피커뷰 관련
    var datePicker: DatePicker!
    var rotationAngle: CGFloat!
    let customHeight: CGFloat = 80
    let formatter = DateFormatter()
    
    // 네비게이션 타이틀 관련
    fileprivate var configuration = NaviConfig()
    fileprivate var menuButton: UIButton!
    fileprivate var menuTitle: UILabel!
    fileprivate var menuArrow: UIImageView!
    var titleToDisplay: String = ""
    let date = Date()
    var titleSize = CGSize()
    
    var userDefaults = UserDefaults.standard
    
    // 달력 제스쳐
    fileprivate lazy var scopeGesture: UIPanGestureRecognizer = {
        [unowned self] in
        let panGesture = UIPanGestureRecognizer(target: self.calendar, action: #selector(self.calendar.handleScopeGesture(_:)))
        panGesture.delegate = self
        panGesture.minimumNumberOfTouches = 1
        panGesture.maximumNumberOfTouches = 2
        return panGesture
        }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dropDownViewHeight.constant = 0
        
        datePicker = DatePicker()
        pickerView.delegate = datePicker
        pickerView.dataSource = datePicker
        
        
        titleButton()
        rotatePickerView()

        //calendar.cellShape = .Rectangle //선택된 날짜의 형태가 네모
        //calendar.allowsMultipleSelection = true //여러날짜를 동시에 선택
        calendar.clipsToBounds = true //달력 구분 선 제거
        //calendar.delegate = calendar as? FSCalendarDelegate
        //calendar.dataSource = calendar as? FSCalendarDataSource
        calendar.delegate = self
        calendar.dataSource = self

        self.view.addGestureRecognizer(self.scopeGesture)
        self.tableView.panGestureRecognizer.require(toFail: self.scopeGesture)
        self.calendar.scope = .month
        
    }


    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        NotificationCenter.default.addObserver(self, selector: #selector(saveWidgetDidChange), name: UserDefaults.didChangeNotification, object: nil)
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        NotificationCenter.default.removeObserver(self, name: UserDefaults.didChangeNotification, object: nil)
    }
    
    
    @IBAction func goTodayButton(_ sender: Any) {
        calendar.setCurrentPage(Date(), animated: false)
    }
    
    //MARK: - 네비게이션 타이틀 설정
    func titleButton() {
        //var titleSize: CGSize
        
        if let dt = userDefaults.object(forKey: "naviTitle") {
            titleToDisplay = dt as! String
        } else {
            formatter.dateFormat = "MMMM yyyy"
            titleToDisplay = "\(formatter.string(from: date))"
            print("titleToDisplay 222222", titleToDisplay)
        }
        
        titleSize = (titleToDisplay as NSString).size(withAttributes: [NSAttributedStringKey.font:configuration.navigationBarTitleFont])
        
        let frame = CGRect(x: 0, y: 0, width: titleSize.width + (configuration.arrowPadding + configuration.arrowImage.size.width), height: navigationController!.navigationBar.frame.height)
        self.navigationItem.titleView?.frame = frame
        menuButton = UIButton(frame: frame)
        menuButton.addTarget(self, action: #selector(self.clickOnTitleButton), for: UIControlEvents.touchUpInside)
        
        menuTitle = UILabel()
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
        self.navigationItem.titleView?.layoutIfNeeded()
    }
    
    // 네비게이션 옆 화살표 로테이션
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
    
    // 가로 피커뷰
    func rotatePickerView() {
        rotationAngle = -90 * (.pi/180)
        let y = pickerView.frame.origin.y
        pickerView.transform = CGAffineTransform(rotationAngle: rotationAngle)
        pickerView.frame = CGRect(x: -150, y: y, width: view.frame.width + 300, height: customHeight)
        pickerView.selectRow(2, inComponent: 0, animated: true)
    }
    
    @objc func clickOnTitleButton() {
        rotateArrow()
    }
    
    // 네비게이션 타이틀 변화 체크
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
            
            self.navigationItem.titleView?.layoutIfNeeded()
            print("유저디폴트 변함")
        }
        
        if let nd : Date = userDefaults.object(forKey: "naviDate") as? Date {
            
            print("nd", nd)
            calendar.setCurrentPage(nd, animated: false)
        }
    }
    
    
    
    
    
    //MARK: - 특정일 선택
    // 특정 날짜를 선택했을 때, 발생하는 이벤트는 이 곳에서 처리할 수 있겠네요.
    func calendar(_ calendar: FSCalendar, didSelect date: Date) {
        print(date)
        
        print("did select date \(self.formatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.formatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        
        //let storyboard = UIStoryboard(name: "Main", bundle: nil)
        //let mainVC = storyboard.instantiateViewController(withIdentifier: "MainVC") as! ViewController
        //mainVC.selectedLabel.text = self.dateFormatter.string(from: date)
        
        //print(date)
        formatter.dateFormat = "yyyy"
        print(formatter.string(from: date))
        formatter.dateFormat = "MM"
        print(formatter.string(from: date))
        formatter.dateFormat = "dd"
        print(formatter.string(from: date))
        
        
        
    }
    
    
    //MARK: - 달력 제스쳐
    func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        let shouldBegin = self.tableView.contentOffset.y <= -self.tableView.contentInset.top
        if shouldBegin {
            let velocity = self.scopeGesture.velocity(in: self.view)
            switch self.calendar.scope {
            case .month:
                return velocity.y < 0
            case .week:
                return velocity.y > 0
            }
        }
        return shouldBegin
    }
    
    func calendar(_ calendar: FSCalendar, boundingRectWillChange bounds: CGRect, animated: Bool) {
        self.calendarHeightConstraint.constant = bounds.height
        print("bounds.height", bounds.height)
        self.view.layoutIfNeeded()
    }
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        formatter.dateFormat = "yyyy/MM/dd"
        print("did select date \(self.formatter.string(from: date))")
        let selectedDates = calendar.selectedDates.map({self.formatter.string(from: $0)})
        print("selected dates is \(selectedDates)")
        if monthPosition == .next || monthPosition == .previous {
            
            calendar.setCurrentPage(date, animated: true)
        }
    }
    
    func calendarCurrentPageDidChange(_ calendar: FSCalendar) {
        print("달력스와이프")
        formatter.dateFormat = "MMMM yyyy"
        let navi = self.formatter.string(from: calendar.currentPage)
        userDefaults.set(navi, forKey: "naviTitle")
        
        let naviDate = self.formatter.string(from: calendar.currentPage)
        formatter.dateFormat = "yyyyMMddhhmmss"
        let date = formatter.date(from: naviDate)
        //selectedDate = dateFormatter.date(from: selectedDate)
        userDefaults.set(date, forKey: "naviDate")
        print("\(self.formatter.string(from: calendar.currentPage))")
    }
    
    
    
    
    // MARK:- UITableViewDataSource
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return [2,5][section]
    }
    
    let sections: [String] = ["11", "22", "33"]
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let view = UIView()
        view.backgroundColor = UIColor.orange
        
        return view
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == 0 {
            let identifier = ["cell_month", "cell_week"][indexPath.row]
            let cell = tableView.dequeueReusableCell(withIdentifier: identifier)!
            return cell
        } else {
            let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
            return cell
        }
    }
    
    
    // MARK:- UITableViewDelegate
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        tableView.deselectRow(at: indexPath, animated: true)
//        if indexPath.section == 0 {
//            let scope: FSCalendarScope = (indexPath.row == 0) ? .month : .week
//            self.calendar.setScope(scope, animated: self.animationSwitch.isOn)
//        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 50
    }
    
}

