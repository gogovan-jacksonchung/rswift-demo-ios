//
//  ViewController.swift
//  RSwiftDemo
//
//  Created by Jackson Chung on 31/8/2018.
//  Copyright © 2018 Jackson Chung. All rights reserved.
//

import UIKit
import Localize_Swift

class ViewController: UIViewController {

    @IBOutlet weak var label: UILabel!
    @IBOutlet weak var label2: UILabel!
    @IBOutlet weak var itemLabel: UILabel!
    @IBOutlet weak var itemsLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var placeholderLabel: UILabel!
    @IBOutlet weak var placeholderCHLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        debugPrint(Localize.availableLanguages())
        
        Bundle.setLanguage("en")
        
        self.label.font = R.font.averiaLibreRegular(size: 16.0)
        self.label.backgroundColor = R.color.paleGray()
        self.imageView.image = R.image.menuDefaultProfile()
        
        debugPrint("TableViewCell ID: \(R.reuseIdentifier.myTableViewCell)")
        
        self.updateText()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    fileprivate func updateText() {
        self.label.text = R.string.localizable.main_title()
        self.label2.text = R.string.localizable.cancel()
        
        self.itemLabel.text = R.string.localizable.item_count(localized_format_key: 1)
        self.itemsLabel.text = R.string.localizable.item_count(localized_format_key: 2)
        self.placeholderLabel.text = String(format: NSLocalizedString("placeholder_test", comment: ""), 1, "cake", 10.99)
        
        // uncomment the following to test date format
//        let formatter1 = DateFormatter()
//        formatter1.dateFormat = R.string.localizable.datetime_format_dm()
//
//        let formatter2 = DateFormatter()
//        formatter2.dateFormat = R.string.localizable.datetime_format_dm_hm()
//
//        let formatter3 = DateFormatter()
//        formatter3.dateFormat = R.string.localizable.datetime_format_dmy_hm()
//
//        let now = Date()
//        self.itemLabel.text = formatter1.string(from: now)
//        self.itemsLabel.text = formatter2.string(from: now)
//        self.placeholderLabel.text = formatter3.string(from: now)
    }
    
    
    @IBAction func langValueDidChange(_ sender: UISwitch) {
        Bundle.setLanguage(sender.isOn ? "en" : "zh-Hant")
        self.updateText()
    }
}

