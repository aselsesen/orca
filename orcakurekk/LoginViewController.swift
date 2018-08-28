//
//  LoginViewController.swift
//  orca
//
//  Created by Asel Şeşen on 11.06.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import UIKit



class LoginViewController: UIViewController {
    
    
    
    @IBOutlet weak var userEmailTextField: UITextField!
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    

    
    
    
    @IBAction func loginButtonTapped(sender: AnyObject) {
       
        let userEmail = userEmailTextField.text!
        let userPassword = userPasswordTextField.text!
        
        let logInURL = NSURL(string:"http://10.151.103.127:8080/login?email=" + userEmail + "&password=" + userPassword )
        
        let session = NSURLSession.sharedSession()
        
        session.dataTaskWithURL(logInURL!) { (data, response, error) in
            
            /*
             if let response = response {
             print(response)
             
             } */
          
           if let data = data {
                
                do{
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options:[] )
                    
                    if let result = json["result"] as? String {
                        
                        if(result == "Succesfully logged in!") {
                            print(result)
                            
                            NSUserDefaults.standardUserDefaults().setBool(true, forKey: "isUserLoggedIn")
                            NSUserDefaults.standardUserDefaults().synchronize()
                            self.dismissViewControllerAnimated(true, completion: nil)
                            
                        }
                        if(result == "No user found with that e-mail address.") {
                            
                            //alert user "no user found "
                            
                            
                            print(result)
                            
                        }
                        
                        
                        if(result == "Login failed due to wrong password!") {
                            
                            //alert user "wrong pw"
                            
                            print(result)
                            
                        } }
                    //    print(json) --> prints the result as json
                    
                }       // end of do
                catch {
                    print(error)
                }
            }
            }.resume()
        
    }            // end of logInButtonTapped
    
        
    
    
    
    
    
}