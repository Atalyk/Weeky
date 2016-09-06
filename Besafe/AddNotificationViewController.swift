//
//  AddNotificationViewController.swift
//  Besafe
//
//  Created by Admin on 8/31/16.
//  Copyright © 2016 AAkash. All rights reserved.
//

import UIKit
import RealmSwift
import Photos
import SnapKit
import KMPlaceholderTextView

extension UIImageView {
    
    func imageFromAssetURL(assetURL: NSURL) {
        
        let asset = PHAsset.fetchAssetsWithALAssetURLs([assetURL], options: nil)
        
        guard let result = asset.firstObject where result is PHAsset else {
            return
        }
        
        let imageManager = PHImageManager.defaultManager()
        
        imageManager.requestImageForAsset(result as! PHAsset, targetSize: CGSize(width: 200, height: 200), contentMode: PHImageContentMode.AspectFill, options: nil) { (image, dict) -> Void in
            if let image = image {
                self.image = image
            }
        }
    }
    
    func cropToBounds(image: UIImage, width: CGFloat, height: CGFloat) {
        
        let contextImage: UIImage = UIImage(CGImage: image.CGImage!)
        
        let contextSize: CGSize = contextImage.size
        
        var posX: CGFloat = 0.0
        var posY: CGFloat = 0.0
        var cgwidth: CGFloat = width
        var cgheight: CGFloat = height
        
        // See what size is longer and create the center off of that
        if contextSize.width > contextSize.height {
            posX = ((contextSize.width - contextSize.height) / 2)
            posY = 0
            cgwidth = contextSize.height
            cgheight = contextSize.height
        } else {
            posX = 0
            posY = ((contextSize.height - contextSize.width) / 2)
            cgwidth = contextSize.width
            cgheight = contextSize.width
        }
        
        let rect: CGRect = CGRectMake(posX, posY, cgwidth, cgheight)
        
        // Create bitmap image from context using the rect
        let imageRef: CGImageRef = CGImageCreateWithImageInRect(contextImage.CGImage, rect)!
        
        // Create a new image based on the imageRef and rotate back to the original orientation
        let image: UIImage = UIImage(CGImage: imageRef, scale: image.scale, orientation: image.imageOrientation)
        
        self.image = image
    }
}

class AddNotificationViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    var mainView = NotificationView()
    var datePickerView = DatePicker()
    var tagView = Tags()
    var imageView = UIImageView()

    var titleTextfield = UITextField()
    var noteTextfield = KMPlaceholderTextView()
    
    let screenBounds = UIScreen.mainScreen().bounds
    let imagePicker = UIImagePickerController()
    
    let colors = [UIColor.mondayColor(UIColor())(), UIColor.tuesdayColor(UIColor())(), UIColor.wednesdayColor(UIColor())(), UIColor.thursdayColor(UIColor())(), UIColor.fridayColor(UIColor())(), UIColor.saturdayColor(UIColor())(), UIColor.sundayColor(UIColor())()]
    
    var titleNotify = ""
    var noteNotify = ""
    var day = ""
    var color = 1
    var url = ""
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setup()
        
        updateView()
        
        imagePicker.delegate = self
        
        self.edgesForExtendedLayout = UIRectEdge.None
        self.automaticallyAdjustsScrollViewInsets = true
    }
    
    func setup() {
        
        self.view.backgroundColor = UIColor(red: 236/255, green: 236/255, blue: 236/255, alpha: 1.0)
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddNotificationViewController.hideViews))
        self.view.addGestureRecognizer(tap)
        
        
        mainView = NotificationView(frame: CGRect(x: 0, y: 0, width: screenBounds.width, height: screenBounds.height))
        mainView.submitButton.addTarget(self, action: #selector(AddNotificationViewController.submitButtonPressed), forControlEvents: .TouchUpInside)
        mainView.submitButton.layer.backgroundColor = colors[returnRandomNumber()].CGColor
        mainView.uploadImageButton.addTarget(self, action: #selector(AddNotificationViewController.uploadImageButtonPressed), forControlEvents: .TouchUpInside)
        mainView.datePickerButton.addTarget(self, action: #selector(AddNotificationViewController.datePickerButtonPressed), forControlEvents: .TouchUpInside)
        mainView.tagButton.addTarget(self, action: #selector(AddNotificationViewController.tagsButtonPressed), forControlEvents: .TouchUpInside)
        self.view.addSubview(mainView)
        
        imageView = UIImageView(frame: CGRect(x: 0, y: 0.0, width: screenBounds.width, height: screenBounds.height*0.4))
        self.view.addSubview(imageView)
        
        titleTextfield = UITextField(frame: CGRect(x: screenBounds.width*0.07, y: screenBounds.height*0.05, width: screenBounds.width*0.9, height: screenBounds.height*0.05))
        titleTextfield.placeholder = "Title"
        titleTextfield.sizeToFit()
        titleTextfield.font = UIFont(name: "Helvetica-Bold", size: screenBounds.width*0.05)
        self.view.addSubview(titleTextfield)
        
        noteTextfield = KMPlaceholderTextView(frame: CGRect(x: screenBounds.width*0.05, y: screenBounds.height*0.11, width: screenBounds.width*0.9, height: screenBounds.height*0.08))
        noteTextfield.placeholder = "Note"
        noteTextfield.font = UIFont(name: "Helvetica-Light", size: screenBounds.width*0.045)
        noteTextfield.delegate = self
        noteTextfield.contentInset = UIEdgeInsetsMake(0.0, -5.0, 0.0, 0.0)
        noteTextfield.scrollEnabled = false
        self.view.addSubview(noteTextfield)
        
        datePickerView = DatePicker(frame: CGRect(x: 0, y: screenBounds.height, width: screenBounds.width, height: screenBounds.height*0.3))
        self.view.addSubview(datePickerView)
        
        tagView = Tags(frame: CGRect(x: 0, y: screenBounds.height, width: screenBounds.width, height: screenBounds.height*0.2))
        tagView.tagOneButton.addTarget(self, action: #selector(AddNotificationViewController.chooseColorButtonPressed(_:)), forControlEvents: .TouchUpInside)
        tagView.tagTwoButton.addTarget(self, action: #selector(AddNotificationViewController.chooseColorButtonPressed(_:)), forControlEvents: .TouchUpInside)
        tagView.tagThreeButton.addTarget(self, action: #selector(AddNotificationViewController.chooseColorButtonPressed(_:)), forControlEvents: .TouchUpInside)
        tagView.tagFourButton.addTarget(self, action: #selector(AddNotificationViewController.chooseColorButtonPressed(_:)), forControlEvents: .TouchUpInside)
        tagView.tagFiveButton.addTarget(self, action: #selector(AddNotificationViewController.chooseColorButtonPressed(_:)), forControlEvents: .TouchUpInside)
        tagView.tagSixButton.addTarget(self, action: #selector(AddNotificationViewController.chooseColorButtonPressed(_:)), forControlEvents: .TouchUpInside)
        tagView.tagSevenButton.addTarget(self, action: #selector(AddNotificationViewController.chooseColorButtonPressed(_:)), forControlEvents: .TouchUpInside)
        self.view.addSubview(tagView)
        
        self.title = "Compose"
  
    }
    
    func updateView() {
        
        if titleNotify != "" {
            titleTextfield.text = titleNotify
        }
        if noteNotify != "" {
            noteTextfield.text = noteNotify
        }
        
        if let url = NSURL(string: url) {
            imageView.imageFromAssetURL(url)
        }
        
        refreshView()
    }
    
    func returnRandomNumber() -> Int {
        let random = Int(arc4random_uniform(UInt32(colors.count)))
        
        return random
    }
    
    func submitButtonPressed() {
  
        let notificationRealm = NotificationObject()
        
        notificationRealm.title = titleTextfield.text!
        notificationRealm.note = noteTextfield.text!
        notificationRealm.deadline = mainView.deadlinePicker.date
        notificationRealm.UUID = NSUUID().UUIDString
        notificationRealm.url = url
        notificationRealm.day = day
        notificationRealm.color = color
        
 
        NotificationList.sharedInstance.addNotification(notificationRealm)
        
        let feedViewController = self.storyboard!.instantiateViewControllerWithIdentifier("FeedViewController") as! FeedViewController
        feedViewController.day = day
        self.presentViewController(feedViewController, animated:true, completion: nil)
    }
    
    func datePickerButtonPressed() {
        UIView.animateWithDuration(0.5, animations: {[weak self] in
            self!.datePickerView.frame = CGRectMake(0, self!.screenBounds.height*0.6, self!.screenBounds.width, self!.screenBounds.height*0.3)
            })
    }
    
    func tagsButtonPressed() {
        UIView.animateWithDuration(0.5, animations: {[weak self] in
            self!.tagView.frame = CGRectMake(0, self!.screenBounds.height*0.85, self!.screenBounds.width, self!.screenBounds.height*0.1)
            })
    }
    
    func chooseColorButtonPressed(button: UIButton) {
        color = button.tag

        UIView.animateWithDuration(0.5, animations: {[weak self] in
            self!.tagView.frame = CGRectMake(0, self!.screenBounds.height, self!.screenBounds.width, self!.screenBounds.height*0.1)
            })
    }
    
    func textViewDidChange(textView: UITextView) {
        let fixedWidth = textView.frame.size.width
        textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        let newSize = textView.sizeThatFits(CGSize(width: fixedWidth, height: CGFloat.max))
        var newFrame = textView.frame
        newFrame.size = CGSize(width: max(newSize.width, fixedWidth), height: newSize.height)
        textView.frame = newFrame
    }
    
    func hideViews() {
        view.endEditing(true)
        
        UIView.animateWithDuration(0.5, animations: {[weak self] in
            self!.datePickerView.frame = CGRectMake(0, self!.screenBounds.height, self!.screenBounds.width, self!.screenBounds.height*0.3)
            })
        
        UIView.animateWithDuration(0.5, animations: {[weak self] in
            self!.tagView.frame = CGRectMake(0, self!.screenBounds.height, self!.screenBounds.width, self!.screenBounds.height*0.1)
            })
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let pickerImage = info[UIImagePickerControllerOriginalImage] as? UIImage {
            let imageUrl = info[UIImagePickerControllerReferenceURL] as! NSURL
            
            let imageName         = imageUrl.lastPathComponent
            let documentDirectory = NSSearchPathForDirectoriesInDomains(.DocumentDirectory, .UserDomainMask, true).first as String!
            let photoURL          = NSURL(fileURLWithPath: documentDirectory)
            let localPath         = photoURL.URLByAppendingPathComponent(imageName!)
            let image             = info[UIImagePickerControllerOriginalImage]as! UIImage
            let data              = UIImagePNGRepresentation(image)!
            
            data.writeToFile(localPath.absoluteString, atomically: true)
            
            url = String(imageUrl)
            
            imageView.image = UIImage(data: data)
            
            self.refreshView()
        }
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(picker: UIImagePickerController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func uploadImageButtonPressed() {
        imagePicker.allowsEditing = false
        imagePicker.sourceType = .PhotoLibrary
        
        presentViewController(imagePicker, animated: true) { 
            //
        }
    }
    
    func refreshView() {
        
        if imageView.image == nil {
            titleTextfield.frame = CGRect(x: screenBounds.width*0.05, y: screenBounds.height*0.05, width: screenBounds.width*0.9, height: screenBounds.height*0.05)
            noteTextfield.frame = CGRect(x: screenBounds.width*0.05, y: screenBounds.height*0.11, width: screenBounds.width*0.9, height: screenBounds.height*0.08)
        } else {
            titleTextfield.frame = CGRect(x: screenBounds.width*0.05, y: screenBounds.height*0.43, width: screenBounds.width*0.9, height: screenBounds.height*0.05)
            noteTextfield.frame = CGRect(x: screenBounds.width*0.05, y: screenBounds.height*0.48, width: screenBounds.width*0.9, height: screenBounds.height*0.08)
        }
    }
    
}
