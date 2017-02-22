//
//  CGFloatExtension.swift
//  PickerLocker
//
//  Created by Iza on 13.02.2017.
//  Copyright © 2017 IB. All rights reserved.
//

import Foundation
import CoreGraphics

public extension CGFloat{
    
    public static func random() -> CGFloat{
        
        return CGFloat(Float(arc4random()) / 0xFFFFFFFF)
    }
    
    
    public static func random(min : CGFloat, max : CGFloat) -> CGFloat{
        
        return CGFloat.random() * (max - min) + min
    }
} 
