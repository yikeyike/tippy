//
//  ViewController.swift
//  tippy
//
//  Created by Yike Li on 8/29/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextFieldDelegate{
    let tipLabel = UILabel.init()
    let userdefault = UserDefaults()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        billTextField.delegate = self
        shareNumTextField.delegate = self
        
        
        if let billText = userdefault.value(forKey: "bill") as? String {
            billTextField.text = billText
        }
        if let shareText = userdefault.value(forKey: "share") as? String {
            shareNumTextField.text = shareText
        }
        if let tipR = userdefault.value(forKey: "range") as? Float {
            tipSlider.value = tipR
        }
        self.updateTipRange()
        self.view.addSubview(tipLabel)
        self.calculateTip()
    }

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var shareNumTextField: UITextField!
    
    @IBOutlet weak var tipSlider: UISlider!

    @IBAction func changeBill(_ sender: Any) {
        userdefault.setValue(billTextField.text, forKey: "bill")
        self.calculateTip()
    }

    @IBAction func changeShare(_ sender: Any) {
        userdefault.setValue(shareNumTextField.text, forKey: "share")
        self.calculateTip()
    }

    @IBAction func RangeChanged(_ sender: Any) {
        self.updateTipRange()

        self.calculateTip()
    }
    
    
    @IBOutlet weak var tipAmount: UILabel!
    
    @IBOutlet weak var totalAmount: UILabel!
    
    @IBOutlet weak var eachShare: UILabel!
    
    
    func updateTipRange() {
        let x_pos = CGFloat(tipSlider.frame.origin.x + CGFloat(min(tipSlider.value, 0.8)) * tipSlider.frame.width)
        let y_pos = CGFloat(tipSlider.frame.origin.y - 40)
        
        tipLabel.frame = CGRect(x: x_pos, y: y_pos, width: 100, height: 40)
        tipLabel.text = String(format: "Tip: %.f%%", round(Double(tipSlider.value) * 100))
        userdefault.setValue(Float(round(Double(tipSlider.value) * 100) / 100), forKey: "range")
    }
    
    func calculateTip()  {
        let bill = Double(billTextField.text!) ?? 0
        let shareNum = Double(shareNumTextField.text!) ?? 0
        let tipRange = round(Double(tipSlider.value) * 100) / 100
        
        if (bill != 0.0 && shareNum != 0.0) {
            let tip = bill * tipRange
            let total = bill * (1 + tipRange)
            let eachshare = total / shareNum
            
            tipAmount.text = String(format: "$%.2f", tip)
            totalAmount.text = String(format: "$%.2f", total)
            eachShare.text = String(format: "$%.2f", eachshare)
        }
    }
}
