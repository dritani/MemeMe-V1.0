//
//  ViewController.swift
//  MemeMe V2.0
//
//  Created by Dritani on 2016-01-20.
//  Copyright © 2016 AquariusLB. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {


    /// Initiation
    
    // Initiate outlets
    @IBOutlet weak var cameraButton: UIBarButtonItem!
    @IBOutlet weak var shareButton: UIBarButtonItem!
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var topText: UITextField! {
        didSet{topText.delegate = self}
    }
    @IBOutlet weak var botText: UITextField! {
        didSet{botText.delegate = self}
    }

    // Initiate variables
    var activityViewController:UIActivityViewController!
    var meme:Meme!
    
    let memeTextAttributes = [
        NSStrokeColorAttributeName : UIColor.blackColor(),        NSForegroundColorAttributeName : UIColor.whiteColor(),        NSFontAttributeName : UIFont(name: "HelveticaNeue-CondensedBlack", size: 40)!,
        NSStrokeWidthAttributeName : -4.0    ]
    
    // viewDidLoad and viewWillAppear
    override func viewDidLoad() {
        super.viewDidLoad()
        shareButton.enabled = false
        
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)

        cameraButton.enabled = UIImagePickerController.isSourceTypeAvailable(UIImagePickerControllerSourceType.Camera)
        imageView.backgroundColor = UIColor.blackColor()
        topText.defaultTextAttributes = memeTextAttributes
        botText.defaultTextAttributes = memeTextAttributes
        topText.text = "TOP"
        botText.text = "BOTTOM"
        
        subscribeToKeyboardNotifications()
    }


    
    /// 4 buttons with actions
    
    // Image from Album button
    @IBAction func pickAnImageFromAlbum(sender:
        UIBarButtonItem) {
            pickAnImageFromSource(.PhotoLibrary)
    }
    
    // Image from Camera button
    @IBAction func pickAnImageFromCamera(sender: UIBarButtonItem) {
        pickAnImageFromSource(.Camera)
    }

    
    func pickAnImageFromSource(source:UIImagePickerControllerSourceType) {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = source
        
        presentViewController(imagePicker, animated: true, completion: nil)
    }

    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imageView.image = image
            shareButton.enabled = true
            dismissViewControllerAnimated(true, completion: nil)
        }
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    

    /// Keyboard functions
    
    // Subscribe Keyboard
    func subscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillShow:", name: UIKeyboardWillShowNotification, object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "keyboardWillHide:", name: UIKeyboardWillHideNotification, object: nil)
    }
    
    // Unsubscribe Keyboard
    func unsubscribeToKeyboardNotifications() {
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillShowNotification, object: self.view.window)
        NSNotificationCenter.defaultCenter().removeObserver(self, name: UIKeyboardWillHideNotification, object: self.view.window)
    }
    
    // Keyboard showing
    func keyboardWillShow(notification: NSNotification) {
        if botText.isFirstResponder() {
            view.frame.origin.y -= getKeyboardHeight(notification)
        }
    }
    
    func keyboardWillHide(notification: NSNotification) {
        if botText.isFirstResponder() {
            view.frame.origin.y = 0
        }
    }
    
    // Keyboard height
    func getKeyboardHeight(notification: NSNotification) -> CGFloat {
        let userInfo = notification.userInfo
        let keyboardSize = userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue // of CGRect
        return keyboardSize.CGRectValue().height
    }
    
    // View Disappearing
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        unsubscribeToKeyboardNotifications()
    }
    
    // TextField ending -> return keyboard
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder();
        return true;
    }
    
    // Share Button
    @IBAction func shareButton(sender: UIBarButtonItem) {
        
        var sharingItems = [AnyObject]()
        let memedImage = generateMemedImage()
        sharingItems.append(memedImage)
        
        let activityViewController = UIActivityViewController(activityItems: sharingItems, applicationActivities: nil)
        activityViewController.completionWithItemsHandler = { (activityType:String?, completed:Bool, returnedItems:[AnyObject]?, activityError: NSError?) -> Void in
            if completed {
                self.save(memedImage)
                activityViewController.dismissViewControllerAnimated(true, completion: nil)
                self.dismissViewControllerAnimated(true, completion: nil)
            }
        }
        
        self.presentViewController(activityViewController, animated: true, completion: nil)
    }
    /// Save meme and show collection view -- this code happens when you press the share button.
    
    // Create meme
    func save(memedImage: UIImage) {
        print(topText.text!)
        print(botText.text!)
        meme = Meme(text1: topText.text!, text2: botText.text!, image:
            imageView.image!, memedImage: memedImage)
        // Add it to the memes array in the Application Delegate
        (UIApplication.sharedApplication().delegate as!
            AppDelegate).memes.append(meme)
    }
    
    func generateMemedImage() -> UIImage {
        // TODO: Hide toolbar and navbar
        
        // render view to an image
        UIGraphicsBeginImageContext(self.view.frame.size)
        view.drawViewHierarchyInRect(self.view.frame, afterScreenUpdates: true)
        let memedImage : UIImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        // TODO:  Show toolbar and navbar
        return memedImage
    }
    
    // Collection view
    
    
    // Cancel BUtton
//    @IBAction func cancelButton(sender: UIBarButtonItem) {
//        self.dismissViewControllerAnimated(true, completion: nil)
//    }
    

    


   
    

    
    

}

