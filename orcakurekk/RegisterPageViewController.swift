//
//  RegisterPageViewController.swift
//  orca
//
//  Created by Asel Şeşen on 10.06.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import UIKit



class RegisterPageViewController: UIViewController {
    
    
    @IBOutlet weak var userNameField: UITextField!
    
    @IBOutlet weak var userEmailTextField: UITextField!
    
    @IBOutlet weak var userPasswordTextField: UITextField!
    
    @IBOutlet weak var userRepeatPasswordTextField: UITextField!
    
    @IBOutlet weak var userPhoneTextField: UITextField!
    
    @IBOutlet weak var userBirthdayTextField: UITextField!
    
    @IBOutlet weak var uncheckbox: UIButton!
    
    
    
    var checkBox = UIImage(named: "CheckBox")
    var uncheckBox = UIImage(named: "UncheckBox")
    var isBoxClicked:Bool!
    
    let datePicker = UIDatePicker()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        isBoxClicked = false
        createDatePicker()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
         
    
    
    func createDatePicker() {
        //toolbar
        
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        
        //done button for tool bar
        let done = UIBarButtonItem(barButtonSystemItem: .Done , target: nil , action: #selector(donePressed) )
        toolbar.setItems([done], animated: false)
        
        userBirthdayTextField.inputAccessoryView = toolbar
        userBirthdayTextField.inputView = datePicker
        
        
        //format picker for date
        datePicker.datePickerMode = .Date
        
    }
    @objc func donePressed() {
        
        //edit fot only date -- date format
        let formatter = NSDateFormatter()
        formatter.dateStyle = .MediumStyle
        formatter.timeStyle = .NoStyle
        formatter.dateFormat = "MM-dd-yyyy"
        let dateString = formatter.stringFromDate(datePicker.date)
        
        
        //gives whole date with hours
        userBirthdayTextField.text = "\(dateString)"
        self.view.endEditing(true)
        
    }
    
    
    
    @IBAction func clickBoxTapped(sender: AnyObject) {
        if isBoxClicked == true {
            isBoxClicked = false   }
            
        else {
            isBoxClicked = true
        }
        
        if isBoxClicked == true {
            uncheckbox.setImage(checkBox, forState: UIControlState.Normal)
            
        } else {
            uncheckbox.setImage(uncheckBox, forState: UIControlState.Normal)
        } }
    
    
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Alert", message: userMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default , handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true , completion: nil)
    }
    
    
    
    @IBAction func signupButtonTapped(sender: AnyObject) {
        
        let userName = userNameField.text!
        let userEmail = userEmailTextField.text!
        let userPassword = userPasswordTextField.text!
        let userRepassword = userRepeatPasswordTextField.text!
        let userPhone = userPhoneTextField.text!
        let userBirthday = userBirthdayTextField.text!
        
      
        
        
        
        //Check empty fields
        if(userName.isEmpty || userEmail.isEmpty || userPassword.isEmpty || userRepassword.isEmpty || userPhone.isEmpty || userBirthday.isEmpty  || isBoxClicked == false ) {
            
            displayAlertMessage("All fields are required!");
            return;
        }
        
        //Check if passwords match
        if(userPassword != userRepassword) {
            
            displayAlertMessage("Passwords do not match!");
            return;
        }
        
        
        //Store data on device
        NSUserDefaults.standardUserDefaults().setObject(userName, forKey: "userName")
        NSUserDefaults.standardUserDefaults().setObject(userEmail, forKey: "userEmail")
        NSUserDefaults.standardUserDefaults().synchronize()
        
        
        
        
        //Store data   (for mySql)
        
        let parameters = ["fName": userName , "email": userEmail , "phone": userPhone , "password": userPassword , "bDate": userBirthday ]
        guard let signUpURL = NSURL(string: "http://10.151.103.127:8080/signup" ) else {return }
        var request = NSMutableURLRequest(URL: signUpURL)
        
       
        request.HTTPMethod = "POST"
       request .addValue("application/json", forHTTPHeaderField: "Content-Type")
        request.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? NSJSONSerialization.dataWithJSONObject(parameters , options: [] ) else {return }
        
        request.HTTPBody = httpBody
        
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(request) { (data, response, error) in
            
            if let response = response {
                
                print(response)
            }
            if let data = data {
                
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    print(json)
                    
                }catch{
                    print(error)
                }
                
            }
        }.resume()
        
        
        
        //Display msg confirmation
        let myAlert = UIAlertController(title: "Alert", message: "Registration is succesful.Thank you!", preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default) { action in
            self.dismissViewControllerAnimated(true, completion: nil)
      
            
        }
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true, completion: nil)
    }
    
  
    
    
    
    
}



    