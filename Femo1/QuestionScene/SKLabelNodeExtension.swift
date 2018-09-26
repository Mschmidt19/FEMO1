//
//  SKLabelNodeExtension.swift
//  Femo1
//
//  Created by Marek Schmidt on 9/26/18.
//  Copyright © 2018 FEMO@Makers. All rights reserved.
//
import SpriteKit

extension SKLabelNode {
    func fitToWidth(maxWidth:CGFloat){
        while frame.size.width >= maxWidth {
            fontSize-=1.0
        }
    }
    
    func fitToHeight(maxHeight:CGFloat){
        while frame.size.height >= maxHeight {
            fontSize-=1.0
        }
    }
}
