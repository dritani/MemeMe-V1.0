//
//  MemeCollectionViewController.swift
//  MemeMe V1.0
//
//  Created by Dritani on 2016-01-30.
//  Copyright © 2016 AquariusLB. All rights reserved.
//

import UIKit

class MemeCollectionViewController: UICollectionViewController {


    @IBOutlet var collectView: UICollectionView!
    
    @IBAction func newMeme(sender: AnyObject) {
        let destinationController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditorViewController
        self.navigationController!.presentViewController(destinationController, animated: true, completion: nil)
    }
    
    var memes: [Meme]!
        
    override func viewDidLoad() {
        super.viewDidLoad()
        collectView.backgroundColor = UIColor.whiteColor()
    }
    
    override func viewWillAppear(animated: Bool) {
        let applicationDelegate =  (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
        
        collectView.reloadData()
    }
    override func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("CollectionCell", forIndexPath: indexPath) as! memeCollectionCell
        
        let meme = memes[indexPath.row]
        cell.memeImage.image = meme.memedImage
        
        return cell
    }
    
    // MARK: -
    // MARK: UICollectionViewDelegate
    
    override func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        
        let meme = memes[indexPath.row]
        let destinationController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetail") as! MemeDetailViewController
        
        destinationController.meme = meme
        
        self.navigationController!.pushViewController(destinationController, animated: true)
    }
    
    

    
    
    
    
}