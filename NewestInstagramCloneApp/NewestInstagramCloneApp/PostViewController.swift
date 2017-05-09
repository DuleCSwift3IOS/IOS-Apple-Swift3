//
//  PostViewController.swift
//  NewestInstagramCloneApp
//
//  Created by Dushko Cizaloski on 5/7/17.
//  Copyright © 2017 Big Nerd Ranch. All rights reserved.
//

import Foundation

class PostViewController: UIViewController, UINavigationControllerDelegate, UIImagePickerControllerDelegate {
    
    var credentialsProvider:AWSCognitoCredentialsProvider = AWSServiceManager.default().defaultServiceConfiguration.credentialsProvider as! AWSCognitoCredentialsProvider
    
    let databaseService = DatabaseService()
    
    var activityIndicator = UIActivityIndicatorView()
    
    let S3BucketName = "newestinstagram-clone-project" //this needs to be moved to a settings file
    
    @IBOutlet var imagePost: UIImageView!
    
    @IBOutlet var setMessage: UITextField!
    
    @IBAction func chooseAnImage(sender: AnyObject) {
        let image = UIImagePickerController()
        image.delegate = self
        image.sourceType = UIImagePickerControllerSourceType.photoLibrary
        image.allowsEditing = false
        
        self.present(image, animated: true, completion: nil)
    }
    
//    func imagePickerController(picker: UIImagePickerController, didFinishPickingImage image: UIImage, editingInfo: [String : AnyObject]?) {
//        self.dismiss(animated: true, completion:nil)
//        imagePost.image = image
//    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        if let image = info[UIImagePickerControllerOriginalImage] as? UIImage {
            imagePost.image = image
        } else{
            print("Something went wrong")
        }
        
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postAnImage(sender: AnyObject) {
        activityIndicator.startAnimating()
        UIApplication.shared.beginIgnoringInteractionEvents()
        
        let S3UploadKeyName = NSUUID().uuidString + ".png"
        var location = ""
        
       
        
       do
       {
        if let data = UIImagePNGRepresentation(self.imagePost.image!) {
            location = databaseService.getDocumentsDirectory().appendingPathComponent(S3UploadKeyName)
            try data.write(to: NSURL.fileURL(withPath: location))
        } else {
            self.displayAlert(title: "Error", message: "Could not process selected image. UIImagePNGRepresentation failed.")
            return
        }
    
        
        let uploadFileUrl = NSURL.fileURL(withPath: location)
        
        let expression = AWSS3TransferUtilityUploadExpression()
        expression.progressBlock = {(task: AWSS3TransferUtilityTask, progress: Progress) in
            print("Progress is: %f", progress.fractionCompleted)
        }
        
        let completionHandler = { (task, error) -> Void in
            DispatchQueue.main.async(execute: {
                self.activityIndicator.stopAnimating()
                UIApplication.shared.endIgnoringInteractionEvents()
                
                if error != nil {
                    print(error!)
                    self.displayAlert(title: "Could not post image", message: "Please try again later")
                } else {
                    self.savePostToDatabase(bucket: self.S3BucketName, key: S3UploadKeyName)
                }
            })
            } as AWSS3TransferUtilityUploadCompletionHandlerBlock
        
        
        let transferUtility = AWSS3TransferUtility.default()
        
        transferUtility.uploadFile(uploadFileUrl, bucket: S3BucketName, key: S3UploadKeyName, contentType: "image/png", expression: expression, completionHandler: completionHandler).continueWith { (task) -> AnyObject! in
            if let error = task.error {
                print("Error: %@", error.localizedDescription);
                //self.statusLabel.text = "Failed"
            }
            let exception = task.description
            if exception == task.description  {
                print("Exception: %@", exception.description);
                //self.statusLabel.text = "Failed"
            }
            if let _ = task.result {
                print("Upload Started")
            }
            
            return nil;
        }
        
      }
    
    catch
    {
        print("Could'n set a image into data")
    }

        
    }
    
    func savePostToDatabase(bucket: String, key: String) {
        let identityId = credentialsProvider.identityId! as String
        let mapper = AWSDynamoDBObjectMapper.default()
        let post = Post()
        
        post?.id = NSUUID().uuidString
        post?.bucket = bucket
        post?.filename = key
        post?.userId = identityId
        
        if (!self.setMessage.text!.isEmpty) {
            post?.message = self.setMessage.text!
        } else {
            post?.message = nil //we cannot save a message that is an empty string
        }
        
        mapper.save(post!).continueWith { (task:AWSTask) -> AnyObject? in
            if (task.error != nil) {
                print(task.error!)
            }
            
            if (task.description != nil) {
                print(task.description)
            }
            
            DispatchQueue.main.async(execute: {
                self.displayAlert(title: "Saved", message: "Your post has been saved")
            })
            
            return nil
        }
    }
    
    func displayAlert(title: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addAction((UIAlertAction(title: "OK", style: .default, handler: { (action) -> Void in
            self.navigationController?.popViewController(animated: true)
        })))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator = UIActivityIndicatorView(frame: self.view.frame)
        activityIndicator.backgroundColor = UIColor(white: 1.0, alpha: 0.5)
        activityIndicator.center = self.view.center
        activityIndicator.hidesWhenStopped = true
        activityIndicator.activityIndicatorViewStyle = UIActivityIndicatorViewStyle.gray
        view.addSubview(activityIndicator)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
