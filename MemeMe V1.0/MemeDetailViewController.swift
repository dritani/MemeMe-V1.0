//
//  MemeDetailViewController.swift
//  MemeMe V1.0
//
//  Created by Dritani on 2016-02-17.
//  Copyright © 2016 AquariusLB. All rights reserved.
//

import UIKit

class MemeDetailViewController: UIViewController {

    
    @IBOutlet weak var memeImage: UIImageView!
    
    var meme: Meme!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.memeImage.image = meme.memedImage
        navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .Edit, target: self, action: "editMeme:")
    }
    
    func editMeme(sender: UIBarButtonItem) {
        let destinationController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditorViewController
            destinationController.meme = meme

        self.presentViewController(destinationController, animated: true, completion: nil)
    }
    

}
