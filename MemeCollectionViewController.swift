//
//  MemeCollectionViewController.swift
//  MemeMe V2.0
//
//  Created by Dritani on 2016-01-30.
//  Copyright © 2016 AquariusLB. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {

    var memes:[Meme]!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let ApplicationDelegate = (UIApplication.sharedApplication().delegate as!
            AppDelegate)
        memes = ApplicationDelegate.memes
    }
    
    
    
}
