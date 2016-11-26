//
//  ViewController.swift
//  image post
//
//  Created by sgcs on 2016. 7. 21..
//  Copyright © 2016년 sgcs. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, NSURLSessionDelegate {

    @IBOutlet weak var image: UIImageView!
    var encodedImage : String?
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    @IBAction func Choose(sender: AnyObject) {
        
        let ImagePicker = UIImagePickerController()
        ImagePicker.delegate = self
        ImagePicker.sourceType = UIImagePickerControllerSourceType.PhotoLibrary

        self.presentViewController(ImagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : AnyObject]) {
        
        image.image = info[UIImagePickerControllerOriginalImage] as? UIImage
        picker.dismissViewControllerAnimated(false, completion:nil)
    }
    
    
    @IBAction func Upload(sender : AnyObject) {
        
        if image.image != nil {
            let imageData = UIImageJPEGRepresentation(image.image!, 0.8)
            encodedImage = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        }
        
        else {
            encodedImage = "none"
        }
        
        
        let parameters = ["username": "Kimkihwan", "password": "123456", "kind": "풍경", "title": "바위", "image1": encodedImage!, "image2": "none", "image3": "none", "contents": "바위가 멋있게 물을 적시고 있습니다"]
        
        let postURL = "http://163.239.169.54:5002/mylogin"
        
        let myUrl = NSURL(string: postURL);
        
        let request = NSMutableURLRequest(URL: myUrl!)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("application/json", forHTTPHeaderField: "Accept")
        request.HTTPMethod = "POST"
        do {
            request.HTTPBody = try NSJSONSerialization.dataWithJSONObject(parameters, options: [])
        } catch {
            
        }
        
        let session = NSURLSession.sharedSession()
        let task = session.dataTaskWithRequest(request, completionHandler: { data, response, error -> Void in
            //print(NSString(data: data!, encoding: NSUTF8StringEncoding))
            
            if error != nil {
                print("error=\(error)")
                return
            }
            
            // You can print out response object
            print("******* response = \(response)")
            
            // Print out reponse body
            //let responseString = NSString(data: data!, encoding: NSUTF8StringEncoding)
            //print("****** response data = \(responseString!)")
            // process the response
        })
        
        task.resume()
        
        
        }
    
    /*
    @IBAction func Upload(sender: AnyObject) {
     
        var imageData = UIImagePNGRepresentation(image.image!)
        
        var request = NSMutableURLRequest(URL: NSURL(string:"http://163.239.169.54:5002/mylogin")!)
            
        request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringLocalAndRemoteCacheData
        
        var session = NSURLSession.sharedSession()
        request.HTTPMethod = "POST"
        
        var boundary = NSString(format: "---------------------------14737809831466499882746641449")
        var contentType = NSString(format: "multipart/form-data; boundary=%@",boundary)
        
        request.addValue(contentType as String, forHTTPHeaderField: "Content-Type")
        
        var body = NSMutableData()
        
        // Add
        body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"add\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("Test".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        
        // Image Internal Type, mime later
        body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"content_type\"\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData("jpeg".dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        
        // Token
//        body.appendData(NSString(format: "\r\n--%@\r\n",boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
  //      body.appendData(NSString(format:"Content-Disposition: form-data; name=\"tok\"\r\n\r/\n").dataUsingEncoding(NSUTF8StringEncoding)!)
      //  body.appendData(token.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)!)
        
        
        //Other fields
        
        
        body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        
        
        body.appendData(NSString(format:"Content-Disposition: form-data; name=\"image\"; filename=\"img\(NSDate()).png\"\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(NSString(format: "Content-Type: image/png\r\n\r\n").dataUsingEncoding(NSUTF8StringEncoding)!)
        body.appendData(imageData!)
        
        
        body.appendData(NSString(format: "\r\n--%@\r\n", boundary).dataUsingEncoding(NSUTF8StringEncoding)!)
        request.HTTPBody = body
        
        
        //  session.uploadTaskWithRequest(request, fromData: body)
        // NSURLSessionUploadTask()
        let task = session.uploadTaskWithRequest(request, fromData: body, completionHandler: { (data, response, error) -> Void in
            var returnString:String?
            if let data = data, string = NSString(data: data, encoding: NSUTF8StringEncoding) {
                returnString = string as String
            }
            
            var errorText:String?
            if let error = error{
                errorText = error.description
            }
            
            print(returnString)
            
        })
        task.resume()

    }
 */
 /*
    @IBAction func Upload(sender: AnyObject) {

        let imageData = UIImageJPEGRepresentation(image.image!, 1)
        if imageData != nil{
            let url:NSURL = NSURL(string: "http://163.239.169.54:5002/mylogin")!
            //let session = NSURLSession.sharedSession()
            
            let request = NSMutableURLRequest(URL: url)
            request.HTTPMethod = "POST"
            //request.cachePolicy = NSURLRequestCachePolicy.ReloadIgnoringCacheData
            
            //let boundary = "Boundary-\(NSUUID().UUIDString)"
            //request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
            //request.setValue("multipart/form-data", forHTTPHeaderField: "Content-type")
           // let body = NSMutableData()
            
//            body.appendString("--\(boundary)\r\n")
 //           body.appendString("Content-Disposition: form-data; name=\"kimkihwan\"; filename=\"hi.jpeg\"\r\n")
  //          body.appendString("Content-Type: image/jpg\r\n\r\n")
 //           body.appendData(imageData!)
 //           body.appendString("\r\n")
            
    //        body.appendString("--\(boundary)--\r\n")
      //      request.HTTPBody = body
            
         //   let data = "data=Hi".dataUsingEncoding(NSUTF8StringEncoding)
            
            
            /*let task = session.dataTaskWithRequest(request, completionHandler: {(data,response,error) in
                guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                    print("error")
                    return
                }
                
                let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                print(dataString)
                })*/
            
            //request.setValue("Keep-Alive", forHTTPHeaderField: "Connection")
            request.HTTPBody = imageData
            request.addValue("multipart/form-data; boundary=" + "----------V2ymHFg03esomerandomstuffhbqgZCaKO6jy", forHTTPHeaderField: "Content-Type")
            request.addValue("multipart/form-data", forHTTPHeaderField: "Accept")
            let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
            let session = NSURLSession(configuration: configuration, delegate: self, delegateQueue: NSOperationQueue.mainQueue())
            let task = session.uploadTaskWithRequest(request, fromData: imageData, completionHandler:
                {(data,response,error) in
                    
                    guard let _:NSData = data, let _:NSURLResponse = response  where error == nil else {
                        print("error")
                        return
                    }
                    
                    print("******* response = \(response)")
                    
                    let dataString = NSString(data: data!, encoding: NSUTF8StringEncoding)
                    print(dataString)
                }
            )
            
            task.resume()
        }
    }
    */
   /*
    @IBAction func Upload(sender: AnyObject) {
        let url = NSURL(string: "http://163.239.169.54:5002/mylogin")
        
        let request = NSMutableURLRequest(URL: url!)
        request.HTTPMethod = "POST"
        
//        let boundary = generateBoundaryString()
        guard let png = UIImagePNGRepresentation(image.image!) else{
            print("error")
            return
        }
 
//        let boundary = "Boundary-\(NSUUID().UUIDString)"
        
        let printpng = NSString(data: png, encoding: NSUTF8StringEncoding)
        
        print(printpng)
        
//        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")
        
        request.HTTPBody = png
        
 //       let base64String = imageData!.base64EncodedStringWithOptions(NSDataBase64EncodingOptions())

   
   //     request.HTTPBody = createBodyWithParameters(param, filePathKey: "file", imageDataKey: imageData!, boundary: boundary)

        
        //myActivityIndicator.startAnimating();

        let task =  NSURLSession.sharedSession().dataTaskWithRequest(request, completionHandler: {(data, response, error) -> Void in
            if let data = data {
                // You can print out response object
                print("******* response = \(response)")
                                                                            
                // Print out reponse body
                let responseString = NSString(data: data, encoding: NSUTF8StringEncoding)
                print("****** response data = \(responseString!)")
                
                dispatch_async(dispatch_get_main_queue(),{
                    //self.myActivityIndicator.stopAnimating()
                    //self.imageView.image = nil;
                });
                                                                            
            } else if let error = error {
                print(error.description)
            }
        })
        task.resume()
        
    }
    */
/*
    func createBodyWithParameters(parameters: [String: String]?, filePathKey: String?, imageDataKey: NSData, boundary: String) -> NSData {
        let body = NSMutableData()
        
        if parameters != nil {
            for (key, value) in parameters! {
                body.appendString("--\(boundary)\r\n")
                body.appendString("Content-Disposition: form-data; name=\"\(key)\"\r\n\r\n")
                body.appendString("\(value)\r\n")
            }
        }
        
        let filename = "user-profile.jpg"
        
        let mimetype = "image/jpg"
        
        body.appendString("--\(boundary)\r\n")
        body.appendString("Content-Disposition: form-data; name=\"\(filePathKey!)\"; filename=\"\(filename)\"\r\n")
        body.appendString("Content-Type: \(mimetype)\r\n\r\n")
        body.appendData(imageDataKey)
        body.appendString("\r\n")
        
        body.appendString("--\(boundary)--\r\n")
        
        return body
    }
    
    func generateBoundaryString() -> String {
        return "Boundary-\(NSUUID().UUIDString)"
    }
    */
}// extension for impage uploading

extension NSMutableData {
    
    func appendString(string: String) {
        let data = string.dataUsingEncoding(NSUTF8StringEncoding, allowLossyConversion: true)
        appendData(data!)
    }
}
