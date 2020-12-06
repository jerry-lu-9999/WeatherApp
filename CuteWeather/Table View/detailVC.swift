//
//  detailVC.swift
//  CuteWeather
//
//  Created by Jiahao Lu on 12/4/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import UIKit
import SpriteKit

class detailVC: UIViewController {

    @IBOutlet weak var weatherImage: UIImageView!
    @IBOutlet weak var temperatureLabel: UILabel!
    @IBOutlet weak var summaryLabel: UILabel!
    
    var details : DailyWeather!
    var celcius = false
    
    let emitterNode = SKEmitterNode(fileNamed: "rain.sks")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherImage.isUserInteractionEnabled = true
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(tapImage(_:)))
        //swipeRecognizer.numberOfTapsRequired = 1
        weatherImage.addGestureRecognizer(swipeRecognizer)
        
        NotificationCenter.default.addObserver(self, selector: #selector(changeCelcius), name: Notification.Name("system changed"), object: nil)
        
        var temp = details.temperatureHigh
        if celcius == true{
            temp = (temp - 32.0) * 5 / 9
            let tempString = String(format: "%.0f", temp) + "ºC"
            temperatureLabel?.text = tempString
        } else{
            let tempString = String(format: "%.0f", temp) + "ºF"
            temperatureLabel?.text = tempString
        }
        
        summaryLabel?.text = details.summary
        summaryLabel?.adjustsFontSizeToFitWidth = true
        
        if details.icon == "rain" {
            weatherImage?.image = UIImage(named: "rainy")
            view.backgroundColor = Constants.rainColor
            summaryLabel?.textColor = .white
            temperatureLabel?.textColor = .white
            addRain()
        } else{
            weatherImage?.image = UIImage(named: "sunny")
        }

    }
    
    @objc func tapImage(_ sender: UISwipeGestureRecognizer){
        if sender.direction == .left ||  sender.direction == .right{
            UIView.transition(with: self.weatherImage,
                              duration: 0.5,
                              options: .transitionCrossDissolve,
                              animations: {self.weatherImage.image = UIImage(named: "transparent logo")},
                              completion: nil)
        }
        self.weatherImage.layoutIfNeeded()
        self.weatherImage.setNeedsDisplay()
    }
    
    @objc func changeCelcius(){
        celcius = UserDefaults.standard.bool(forKey: dCelcius)
        self.view.setNeedsDisplay()
    }
    
    @IBAction func onSwipe(_ sender: UISwipeGestureRecognizer) {
        

    }
    
    public func addRain(){
        let skView = SKView(frame: view.frame)
        let scene = SKScene(size: view.frame.size)
        skView.backgroundColor = .clear
        scene.backgroundColor = .clear
        skView.presentScene(scene)
        skView.isUserInteractionEnabled = false
        scene.anchorPoint = CGPoint(x: 0.5, y: 0.5)
        scene.addChild(emitterNode)
        emitterNode.position.y = scene.frame.maxY
        emitterNode.particlePositionRange.dx = scene.frame.width
        view.addSubview(skView)
    }
}
