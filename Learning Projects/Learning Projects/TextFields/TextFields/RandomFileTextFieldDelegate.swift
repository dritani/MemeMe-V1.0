//
//  RandomFileTextFieldDelegate.swift
//  TextFields
//
//  Created by Dritani on 2016-02-12.
//  Copyright © 2016 Udacity. All rights reserved.
//

import Foundation
import UIKit

class RandomFileTextFieldDelegate : NSObject, UITextFieldDelegate {

    
    
    func textField(textField: UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool {
        textField.textColor = self.randomColor()

        return true
    }

    
    func randomColor() -> UIColor {
        let colors = [UIColor.redColor(), UIColor.orangeColor(),
            UIColor.yellowColor(), UIColor.greenColor(),
            UIColor.blueColor(), UIColor.purpleColor(),
            UIColor.brownColor()];
        let randomIndex = Int(arc4random() % UInt32(colors.count))
        
        return colors[randomIndex]
    }

}