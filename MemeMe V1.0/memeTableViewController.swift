//
//  memeTableViewController.swift
//  MemeMe V1.0
//
//  Created by Dritani on 2016-02-02.
//  Copyright © 2016 AquariusLB. All rights reserved.
//

import UIKit

class memeTableViewController: UITableViewController {

    @IBAction func newMeme(sender: AnyObject) {
        let destinationController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeEditor") as! MemeEditorViewController
            self.navigationController!.presentViewController(destinationController, animated: true, completion: nil)
    }
    
    var memes: [Meme]!
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    override func viewWillAppear(animated: Bool) {
        let applicationDelegate =  (UIApplication.sharedApplication().delegate as! AppDelegate)
        
        memes = applicationDelegate.memes
        tableView.reloadData()
    }
    // Table DataSource methods
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return memes.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("TableCell") as! memeTableCell
        
        let meme = memes[indexPath.row]
        
        cell.memeImage.image = meme.memedImage
        cell.memeLabel.text = meme.text1
        
        return cell
    }
    
    // Table Delegate methods
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {

        let meme = memes[indexPath.row]
        let destinationController = self.storyboard!.instantiateViewControllerWithIdentifier("MemeDetail") as! MemeDetailViewController
        
        destinationController.meme = meme
        
        self.navigationController!.pushViewController(destinationController, animated: true)

        
    }
}






