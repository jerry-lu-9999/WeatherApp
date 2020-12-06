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
    var animation = 0
    
    let emitterNode = SKEmitterNode(fileNamed: "rain.sks")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        weatherImage.isUserInteractionEnabled = true
        let swipeRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(swipeImage(_:)))
        weatherImage.addGestureRecognizer(swipeRecognizer)
        
        NotificationCenter.default.addObserver(forName: Notification.Name("system changed"),object: nil, queue: nil){ _ in
            self.changeCelcius()
        }
        NotificationCenter.default.addObserver(forName: Notification.Name("animation changed"), object: nil, queue: nil){ _ in
            self.changeAnimation()
        }
        
        var temp = details.temperatureHigh
        if self.celcius == true{
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
            view.backgroundColor = UIColor(red: 135/255.0, green: 206/255.0, blue: 250/255.0, alpha: 1)
            weatherImage?.image = UIImage(named: "sunny")
        }

    }
    
    @objc func swipeImage(_ sender: UISwipeGestureRecognizer){
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
    
    func changeCelcius(){
        OperationQueue.main.addOperation {
            self.celcius = UserDefaults.standard.bool(forKey: dCelcius)
            self.view.layoutIfNeeded()
        }
        //self.viewDidLoad()
    }
    
     func changeAnimation(){
        OperationQueue.main.addOperation {
            self.animation = UserDefaults.standard.integer(forKey: dAnimated)
            print(self.animation)
            self.view.layoutIfNeeded()
        }
        //self.viewDidLoad()
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
