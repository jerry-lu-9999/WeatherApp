//
//  SettingsVC.swift
//  p3
//
//  Created by Jiahao Lu on 12/3/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import UIKit

class SettingsVC: UIViewController {

    @IBOutlet weak var celciusLabel: UILabel!
    @IBOutlet weak var celciusSwitch: UISwitch!
    @IBOutlet weak var celciusDescription: UILabel!
    @IBOutlet weak var layoutOrderLabel: UILabel!
    @IBOutlet weak var layoutOrderPickerView: UIPickerView!
    @IBOutlet weak var layoutDescription: UILabel!
    @IBOutlet weak var saveBtn: UIBarButtonItem!
    @IBOutlet weak var undoBtn: UIBarButtonItem!
    
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        celciusSwitch.isOn = defaults.bool(forKey: dCelcius)
        celciusDescription?.text = NSLocalizedString("str_celcius_des", comment: "")
        layoutDescription?.text = NSLocalizedString("str_layout_des", comment: "")
    }
    

}
