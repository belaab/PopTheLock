//
//  GameViewController.swift
//  PickerLocker
//
//  Created by Iza on 11.02.2017.
//  Copyright © 2017 IB. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

class GameViewController: UIViewController {
    
    
//    let scene = GameScene(size: view.bounds.size)
//    let skView = view as! SKView
//    skView.showsFPS = false
//    skView.showsNodeCount = false
//    skView.ignoresSiblingOrder = true
//    scene.scaleMode = .ResizeFill
//    skView.presentScene(scene)

    override func viewDidLoad() {
        super.viewDidLoad()
        //self.backgroundColor = SKColor(red: 0.15, green:0.15, blue:0.3, alpha: 1.0)

        if let view = self.view as! SKView? {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
    }

    override var shouldAutorotate: Bool {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask {
        if UIDevice.current.userInterfaceIdiom == .phone {
            return .allButUpsideDown
        } else {
            return .all
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool {
        return true
    }
}
