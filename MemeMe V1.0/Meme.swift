//
//  Meme.swift
//  MemeMe V1.0
//
//  Created by Dritani on 2016-01-21.
//  Copyright © 2016 AquariusLB. All rights reserved.
//

import Foundation
import UIKit

class Meme : NSObject {
    var text1: String
    var text2: String
    var image: UIImage
    var memedImage: UIImage
    
    init(text1:String,text2:String,image:UIImage,memedImage:UIImage){
        self.text1 = text1
        self.text2 = text2
        self.image = image
        self.memedImage = memedImage
    
    }
    
    
}