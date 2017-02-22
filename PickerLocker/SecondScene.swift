//
//  GameScene.swift
//  PickerLocker
//
//  Created by Iza on 11.02.2017.
//  Copyright © 2017 IB. All rights reserved.

import SpriteKit
import GameplayKit


class SecondScene: SKScene{
    
    
    var Circle = SKSpriteNode()
    var Person = SKSpriteNode()
    var Dot = SKSpriteNode()
    
    var Path = UIBezierPath()
    var GameStarted = Bool()
    var MovingClockWise = Bool()
    var intersected = false
    var LevelLabel = UILabel()
    var currentLevel = Int()
    var currentScore = Int()
    var highLevel = Int()
    var increaseSpeed = 300
    
    override func didMove(to view: SKView) {
        
        loadView()
        let Defaults = UserDefaults.standard
        if Defaults.integer(forKey: "HighLevel") != 0{
            highLevel = Defaults.integer(forKey: "HighLevel") as Int!
            currentLevel = highLevel
            currentScore = currentLevel
            LevelLabel.text = "\(currentScore)"
        }else{
            Defaults.set(1, forKey: "HighLevel")
        }
    }
    
    
    func loadView(){
        MovingClockWise = true
        
        backgroundColor = SKColor(colorLiteralRed: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)

        Circle = SKSpriteNode(imageNamed: "circle")
        Circle.size = CGSize(width: 600, height: 600) //jakby wektor
        Circle.position = CGPoint(x: self.frame.midX, y: self.frame.midY)
        self.addChild(Circle)
        
        Person = SKSpriteNode(imageNamed: "person")
        Person.size = CGSize(width: 120, height: 40)
        Person.position = CGPoint(x: self.frame.midX, y: self.frame.midY + 234)
        Person.zRotation = 3.14/2 // w radianach dzielone na 2 = 90 st
        Person.zPosition = 2.0
        self.addChild(Person)
        addDot()
        
        LevelLabel = UILabel(frame: CGRect(x : 0, y: 0, width: 100, height: 100))
        LevelLabel.center = (self.view?.center)!
        LevelLabel.text = "\(currentScore)"
        LevelLabel.textAlignment = NSTextAlignment.center
        LevelLabel.textColor = SKColor.init(displayP3Red: 178/255, green: 178/255, blue: 178/255, alpha: 1.0)
        LevelLabel.font = UIFont.systemFont(ofSize: 40)
        self.view?.addSubview(LevelLabel) //treating LevelLabel as a UI view
    }

                      
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if GameStarted == false{
            moveClockWise()
            MovingClockWise = true
            GameStarted = true
        
        }else if GameStarted == true{

            if MovingClockWise == true{
                moveCounterClockWise()
                MovingClockWise = false
            }else if MovingClockWise == false{
                //changeGradient()

                moveClockWise()
                MovingClockWise = true
            }
            DotTouched()
  
        }
    
    }
    
    
    func addDot(){
        Dot = SKSpriteNode(imageNamed: "Dot")
        Dot.size = CGSize(width: 120, height: 120) //jakby wektor
        Dot.zPosition = 1.0
        let dx = Person.position.x - self.frame.midX
        let dy = Person.position.y - self.frame.midY
        
        let rad = atan2(dy, dx) //zwraca kat w radianach
        
        if MovingClockWise == true{
            let tempAngle = CGFloat.random(min : rad - 1.0, max : rad - 2.5)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x : self.frame.midX, y: self.frame.midY), radius: 234, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI * 4) , clockwise: true)
            Dot.position = Path2.currentPoint
            
        }else if MovingClockWise == false{
            let tempAngle = CGFloat.random(min : rad + 1.0, max : rad + 2.5)
            let Path2 = UIBezierPath(arcCenter: CGPoint(x : self.frame.midX, y: self.frame.midY), radius: 234, startAngle: tempAngle, endAngle: tempAngle + CGFloat(M_PI * 4) , clockwise: true)
            Dot.position = Path2.currentPoint

        }
        self.addChild(Dot)
    }
    
    
    func moveClockWise(){
        let dx = Person.position.x - self.frame.midX
        let dy = Person.position.y - self.frame.midY
        
        let rad = atan2(dy, dx) //zwraca kat w radianach
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.midY), radius: 234, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        let follow = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: true, speed: CGFloat(increaseSpeed))
        Person.run(SKAction.repeatForever(follow).reversed())
    }
    
    func moveCounterClockWise(){
        let dx = Person.position.x - self.frame.midX
        let dy = Person.position.y - self.frame.midY
        
        let rad = atan2(dy, dx) //zwraca kat w radianach
        Path = UIBezierPath(arcCenter: CGPoint(x: self.frame.midX, y: self.frame.midY), radius: 234, startAngle: rad, endAngle: rad + CGFloat(M_PI * 4), clockwise: true)
        let follow = SKAction.follow(Path.cgPath, asOffset: false, orientToPath: true, speed: CGFloat(increaseSpeed))
        Person.run(SKAction.repeatForever(follow))
        
    }
    
    func DotTouched(){
        if intersected == true{
            print(increaseSpeed)

            Dot.removeFromParent()
            addDot()
            intersected = false
            
            currentScore -= 1
            LevelLabel.text = "\(currentScore)"
            if currentScore <= 0{
                nextLevel()
            }
        }else if intersected == false{
            died()
        }
    }
    
    func nextLevel(){
        currentLevel += 1
        currentScore = currentLevel
        LevelLabel.text = "\(currentScore)"
        won()
        print(increaseSpeed)
        increaseSpeed += 5
        if currentLevel > highLevel{
            highLevel = currentLevel
            let Defaults = UserDefaults.standard
            Defaults.set(highLevel, forKey: "HighLevel")
        }
    }
    
    
    func died(){
        let col = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        self.removeAllChildren()
        let action1 = SKAction.colorize(with: UIColor.red, colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorize(with: col, colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.run(SKAction.sequence([action1, action2]))
        intersected = false //przecięte
        GameStarted = false
        LevelLabel.removeFromSuperview()
        currentScore = currentLevel
        self.loadView()
    }
    
    func won(){
        let col = UIColor(red: 51/255, green: 51/255, blue: 51/255, alpha: 1.0)
        self.removeAllChildren()
        let action1 = SKAction.colorize(with: UIColor.green, colorBlendFactor: 1.0, duration: 0.2)
        let action2 = SKAction.colorize(with: col, colorBlendFactor: 1.0, duration: 0.2)
        self.scene?.run(SKAction.sequence([action1, action2]))
        MovingClockWise = false
        intersected = false //przecięte
        GameStarted = false
        LevelLabel.removeFromSuperview()
        self.loadView()
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
        
        if Person.intersects(Dot){
            intersected = true
        }else{
            if intersected == true{
                if Person.intersects(Dot) == false{
                    died()
                    //self.scene?.removeAllActions()

                }
            }
        }
    }
}




































