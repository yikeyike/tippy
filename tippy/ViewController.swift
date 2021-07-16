//
//  ViewController.swift
//  tippy
//
//  Created by Yike Li on 8/29/20.
//  Copyright © 2020 codepath. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let tipLabel = UILabel.init()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.updateTipRange()
        self.view.addSubview(tipLabel)
    }

    @IBOutlet weak var billTextField: UITextField!
    
    @IBOutlet weak var shareNumTextField: UITextField!
    
    @IBOutlet weak var tipSlider: UISlider!
//    @IBOutlet var tipRangeLabel: UILabel!
    
    @IBAction func changeBill(_ sender: Any) {
        self.calculateTip()
    }
    @IBAction func changeShare(_ sender: Any) {
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
    
    func setUISliderThumbValueWithLabel(slider: UISlider) -> CGPoint {
        let slidertTrack : CGRect = slider.trackRect(forBounds: slider.bounds)
        let sliderFrm : CGRect = slider.thumbRect(forBounds: slider.bounds, trackRect: slidertTrack, value: slider.value)
        return CGPoint(x: sliderFrm.origin.x + slider.frame.origin.x + 20, y: slider.frame.origin.y - 40)
    }

    
}

