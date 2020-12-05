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
    
    let emitterNode = SKEmitterNode(fileNamed: "rain.sks")!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if details.icon == "rain" {
            weatherImage?.image = UIImage(named: "rainy")
            addRain()
        } else{
            weatherImage?.image = UIImage(named: "sunny")
        }
        temperatureLabel?.text = "\(details.temperatureHigh)"
        summaryLabel?.text = details.summary

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
