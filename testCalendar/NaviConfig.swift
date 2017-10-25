//
//  NaviConfig.swift
//  testCalendar
//
//  Created by yuki.pro on 2017. 10. 24..
//  Copyright © 2017년 yuki. All rights reserved.
//

import UIKit

final class NaviConfig {
    var menuTitleColor: UIColor?
    var cellHeight: CGFloat!
    var cellBackgroundColor: UIColor?
    var cellSeparatorColor: UIColor?
    var cellTextLabelColor: UIColor?
    var selectedCellTextLabelColor: UIColor?
    var cellTextLabelFont: UIFont!
    var navigationBarTitleFont: UIFont!
    var cellTextLabelAlignment: NSTextAlignment!
    var cellSelectionColor: UIColor?
    var checkMarkImage: UIImage!
    var shouldKeepSelectedCellColor: Bool!
    var arrowTintColor: UIColor?
    var arrowImage: UIImage!
    var arrowPadding: CGFloat!
    var animationDuration: TimeInterval!
    var maskBackgroundColor: UIColor!
    var maskBackgroundOpacity: CGFloat!
    var shouldChangeTitleText: Bool!
    
    init() {
        self.defaultValue()
    }
    
    func defaultValue() {
        // Path for image
        //let bundle = Bundle(for: NaviConfig.self)
        //let bundle = Bundle()
        //let url = bundle.url(forResource: "NaviConfig", withExtension: "bundle")
        
        
        //let imageBundle = Bundle(url: url!)
        //let imageBundle = Bundle.main.url(forResource: "Image", withExtension: "png")
        //let checkMarkImagePath = imageBundle?.path(forResource: "checkmark_icon", ofType: "png")
        //let arrowImagePath = imageBundle?.path(forResource: "arrow_down_icon")
        //let arrowImagePath = Bundle.main.url(forResource: "arrow_down_icon", withExtension: "png")
        
        // Default values
        self.menuTitleColor = UIColor.FlatColor.Green.PersianGreen
        self.arrowTintColor = UIColor.FlatColor.Green.MountainMeadow
        self.animationDuration = 0.5
        
        
        self.cellHeight = 50
        self.cellBackgroundColor = UIColor.white
        
        self.cellSeparatorColor = UIColor.darkGray
        self.cellTextLabelColor = UIColor.darkGray
        self.selectedCellTextLabelColor = UIColor.darkGray
        self.cellTextLabelFont = UIFont(name: "HelveticaNeue-Bold", size: 17)
        self.navigationBarTitleFont = UIFont(name: "Verdana", size: 15)
        self.cellTextLabelAlignment = NSTextAlignment.left
        self.cellSelectionColor = UIColor.lightGray
        //self.checkMarkImage = UIImage(contentsOfFile: checkMarkImagePath!)
        self.shouldKeepSelectedCellColor = false
        
        //self.arrowImage = UIImage(contentsOfFile: arrowImagePath!)
        self.arrowImage = UIImage(named: "arrow_down_icon")
        self.arrowPadding = 5
        self.maskBackgroundColor = UIColor.black
        self.maskBackgroundOpacity = 0.3
        self.shouldChangeTitleText = true
    }
}
