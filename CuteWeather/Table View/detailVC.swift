//
//  detailVC.swift
//  CuteWeather
//
//  Created by Jiahao Lu on 12/4/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import UIKit

class detailVC: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var details : DailyWeather!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if details.icon == "rain" {
            weatherImage?.image = UIImage(named: "rainy")
        } else{
            weatherImage?.image = UIImage(named: "sunny")
        }
        temperatureLabel?.text = "\(details.temperatureHigh)"
        summaryLabel?.text = details.summary
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
