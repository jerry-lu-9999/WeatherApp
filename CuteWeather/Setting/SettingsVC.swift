//
//  SettingsVC.swift
//
//
//  Created by Jiahao Lu on 12/3/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return orderType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return orderType(rawValue: row)?.title()
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        //var selectedRow =
    }
    
    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var animationLabel: UILabel!
    
    @IBOutlet weak var celciusSwitch: UISwitch!
    @IBOutlet weak var celciusDescription: UILabel!
    @IBOutlet weak var layoutOrderPickerView: UIPickerView!
    @IBOutlet weak var layoutDescription: UILabel!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var undoBtn: UIBarButtonItem!
    
    let defaults = UserDefaults.standard
    
    override func viewWillAppear(_ animated: Bool) {
        
        celciusSwitch.isOn = defaults.bool(forKey: dCelcius)
        celciusDescription?.text = NSLocalizedString("str_celcius_des", comment: "")
        animationLabel?.text = NSLocalizedString("str_animation", comment: "")
        layoutDescription?.text = NSLocalizedString("str_layout_des", comment: "")
        celciusDescription?.adjustsFontSizeToFitWidth = true
        layoutDescription?.adjustsFontSizeToFitWidth = true
        
        self.layoutOrderPickerView.delegate = self
        self.layoutOrderPickerView.dataSource = self
        
    }
    
    @IBAction func onSwitch(_ sender: UISwitch) {
        defaults.set(sender.isOn, forKey: dCelcius)
        NotificationCenter.default.post(name: Notification.Name("system changed"), object: nil, userInfo: nil)
    }
    
    @IBAction func onSave(_ sender: Any) {
        defaults.set(layoutOrderPickerView.selectedRow(inComponent: 0), forKey: dAnimated)
        NotificationCenter.default.post(name: Notification.Name("animation changed"), object: nil, userInfo: nil)
        
        let alert = UIAlertController(title: NSLocalizedString("str_save_succ", comment: ""),
                                      message: NSLocalizedString("str_save_desc", comment: ""),
                                      preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("str_gotcha", comment: ""),
                                      style: .default,
                                      handler: nil))
        self.present(alert, animated: true)
    }
    
    @IBAction func undo(_ sender: Any) {
        celciusSwitch.isOn = false
        layoutOrderPickerView?.selectRow(0, inComponent: 0, animated: true)
    }
    
}
