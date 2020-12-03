//
//  AboutVC.swift
//  p3
//
//  Created by Jiahao Lu on 12/3/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import UIKit

class AboutVC: UIViewController {

    @IBOutlet weak var appIcon: UIImageView!
    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var copyrightLabel: UILabel!
    @IBOutlet weak var appNameLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        appIcon?.image = UIImage(named: "weather")
        versionLabel?.text = Bundle.main.version
        copyrightLabel?.text = Bundle.main.copyright
        appNameLabel?.text = Bundle.main.displayName
    }
    
    
}
