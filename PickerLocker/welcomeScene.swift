//
//  welcomeScene.swift
//  PickerLocker
//
//  Created by Iza on 21.02.2017.
//  Copyright © 2017 IB. All rights reserved.
//

import Foundation
import SpriteKit

class GameScene: SKScene{
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        let welcomeLabel = SKLabelNode()
        welcomeLabel.text = "Pop the Lock!"
        welcomeLabel.fontColor = SKColor.white
        welcomeLabel.fontSize = 80
        welcomeLabel.colorBlendFactor = 0.5
        welcomeLabel.color = SKColor.gray
        welcomeLabel.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        
        self.addChild(welcomeLabel)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let myScene = SecondScene(size: self.size)
        myScene.scaleMode = scaleMode
        let reveal = SKTransition.crossFade(withDuration: 1)
        self.view?.presentScene(myScene, transition: reveal)
    }
    
    
}
