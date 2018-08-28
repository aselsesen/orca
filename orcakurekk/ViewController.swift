//
//  ViewController.swift
//  orca
//
//  Created by Asel Şeşen on 10.06.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import UIKit

class ViewController: UIViewController , UITableViewDelegate , UITableViewDataSource {
    
 
    @IBOutlet weak var reservations: UITableView!
    
    @IBOutlet weak var settingNameLabel: UILabel!
    
   
    @IBOutlet weak var settings: UITableView!
    
    @IBOutlet weak var appointmentLabel: UILabel!
    
    @IBOutlet var settingsPopUpView: UIView!

    
    
     var effectView: UIVisualEffectView!
     var result = [Int]()
     let arrayOfSettingNames = [ "Profile" , "History" ,"About Us" ,"Logout"]
  
    
    //All information about the reservations!
     var arrayOfReservationId = [String]()
     var arrayOfReservationDate = [String]()
     var arrayOfReservationTime = [String]()
     var arrayOfBoatReserved = [String]()
     var arrayOfMemberBooked = [String]()
    
    
 
    
          override func viewDidLoad() {
            
             super.viewDidLoad()
                  settingsPopUpView.layer.cornerRadius = 5
            
    /////////////////
            let userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")!
            let parameters = [ "email": userEmail ]
            let reservationInfoURL = NSURL(string: "http://10.151.103.127:8080/reservationInfo")
            var request = NSMutableURLRequest(URL: reservationInfoURL!)
            request.HTTPMethod = "POST"
            request .addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            let httpBody = try? NSJSONSerialization.dataWithJSONObject(parameters , options: [] )
            request.HTTPBody = httpBody
            let session = NSURLSession.sharedSession()
            session.dataTaskWithRequest(request) { (data, response, error) in
                
                if let data = data {
                    do {
                        
                       
                let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
        self.arrayOfReservationTime = json.valueForKey("reservationList")!.valueForKey("reservationTime")! as! [String]
        self.arrayOfBoatReserved = json.valueForKey("reservationList")!.valueForKey("boatReserved")! as! [String]
        self.arrayOfReservationId = json.valueForKey("reservationList")!.valueForKey("reservationId")! as! [String]
        self.arrayOfMemberBooked = json.valueForKey("reservationList")!.valueForKey("memberBooked")! as! [String]
        self.result = json.valueForKey("reservationList")!.valueForKey("reservationDate")! as! [Int]
                   
                        for obj in self.result {
                            let dateFormatter = NSDateFormatter()
                            dateFormatter.dateFormat = "yyyy-MM-dd"
                            let value = obj / 1000
                            let dateValue = NSDate(timeIntervalSince1970: Double(value))
                           date
                            let resultValue = dateFormatter.stringFromDate(dateValue)
                          self.arrayOfReservationDate.append(resultValue)
                            
                           
                        }
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
                           self.reservations.reloadData()
                        })
                  
                        

                    }catch{
                        print(error)
                    }
                }
                }.resume()
          
            
              }
  
    func animateIn() {

        self.view.addSubview(settingsPopUpView)
    
        
        //enables autolayout
        settingsPopUpView.translatesAutoresizingMaskIntoConstraints = false
        settingsPopUpView.leadingAnchor.constraintEqualToAnchor(view.leadingAnchor, constant: 0)
        settingsPopUpView.bottomAnchor.constraintEqualToAnchor( view.bottomAnchor , constant: 28).active = true
        settingsPopUpView.widthAnchor.constraintEqualToConstant(320).active = true
        settingsPopUpView.heightAnchor.constraintEqualToConstant(194).active = true
        settingsPopUpView.transform = CGAffineTransformMakeScale(1.3, 1.3)
        settingsPopUpView.alpha = 0
            UIView.animateWithDuration(0.4, animations: {
            
            self.settingsPopUpView.alpha = 1
            self.settingsPopUpView.transform = CGAffineTransformIdentity
        })
    }
    func animateout() {
        UIView.animateWithDuration(0.3, animations: {
            self.settingsPopUpView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.settingsPopUpView.alpha = 0
        }) { (success:Bool) in
            self.settingsPopUpView.removeFromSuperview()
        }
        
    }

    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        //it should change when reservation count changes so basically this int value is equal to the users past total reservations
        
        
        if(tableView == settings) {
        
            return arrayOfSettingNames.count }
        
        else {
            
            return self.arrayOfReservationTime.count
            
            
        }
    }
    
    
    
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if(tableView == reservations) {
           
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! ViewControllerTableViewCell
         
            cell.reservationDateForCell.text = arrayOfReservationDate[indexPath.row]
            cell.reservationTimeForCell.text = arrayOfReservationTime[indexPath.row]
         
        //cell.cellImage.image = UIImage(named: "")
              return cell
            
            
            
            
        }
        
       else{
            
    let cell1 = tableView.dequeueReusableCellWithIdentifier("cell1", forIndexPath: indexPath) as! SettingsTableViewCell
            
         cell1.settingsLabel.text = arrayOfSettingNames[indexPath.row]
            cell1.backgroundColor = UIColor(red:1.00, green:0.72, blue:0.52, alpha:1.0)
            
          
            settings.scrollEnabled = false
     
             return cell1
           
        }
        
    }
    
    
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        
        if(tableView == reservations) {
            
        let cell = tableView.cellForRowAtIndexPath(indexPath)
        
        } else {
            
          let cell1 = tableView.cellForRowAtIndexPath(indexPath) as! SettingsTableViewCell
            if(cell1.settingsLabel.text! == "Profile") {
                
                let storyboard = UIStoryboard(name: "Main"  , bundle: nil)
                let leadingVC = storyboard.instantiateViewControllerWithIdentifier("ProfileViewController") as! ProfileViewController
                
                self.navigationController?.pushViewController(leadingVC, animated: true)
                
                
                
            }
            
            if(cell1.settingsLabel.text! == "History") {
                let storyboard = UIStoryboard(name: "Main"  , bundle: nil)
                let leadingVC = storyboard.instantiateViewControllerWithIdentifier("HistoryViewController") as! HistoryViewController
                
                self.navigationController?.pushViewController(leadingVC, animated: true)

                
                
            }
            
            if(cell1.settingsLabel.text! == "About Us") {
                let storyboard = UIStoryboard(name: "Main"  , bundle: nil)
                let leadingVC = storyboard.instantiateViewControllerWithIdentifier("AboutUsViewController") as! AboutUsViewController
                
                self.navigationController?.pushViewController(leadingVC, animated: true)

                
                
            }
            
            if(cell1.settingsLabel.text! == "Logout") {
                
                NSUserDefaults.standardUserDefaults().setBool(false, forKey: "isUserLoggedIn")
                NSUserDefaults.standardUserDefaults().synchronize()
                self.performSegueWithIdentifier("loginView", sender: self)
                
            }
            
        }
        
        
    }
    
    
    func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        
        if(tableView == reservations) {
        
        
            return true }
        
        
        else {
            
            return false
            
        }
    }
    
    func tableView(tableView: UITableView, editActionsForRowAtIndexPath indexPath: NSIndexPath) -> [UITableViewRowAction]? {
        let deleteAction = UITableViewRowAction(style: .Destructive ,
                                                title: "Cancel") { (action, indexPath) in
              self.reservations.beginUpdates()
              self.arrayOfReservationDate.removeAtIndex(indexPath.row)
              self.arrayOfReservationTime.removeAtIndex(indexPath.row)
              self.reservations.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
              self.reservations.endUpdates()
               
            let reservationId = self.arrayOfReservationId[indexPath.row]
            let parameters = ["reservationId": reservationId ]
            guard let cancelReservationURL = NSURL(string: "http://10.151.103.127:8080/cancel" ) else {return }
            var request = NSMutableURLRequest(URL: cancelReservationURL)
            request.HTTPMethod = "POST"
            request .addValue("application/json", forHTTPHeaderField: "Content-Type")
            request.addValue("application/json", forHTTPHeaderField: "Accept")
            guard let httpBody = try? NSJSONSerialization.dataWithJSONObject( parameters , options: [] ) else { return}
            request.HTTPBody = httpBody
            let session = NSURLSession.sharedSession()
            session.dataTaskWithRequest(request) { (data, response, error) in
             if let response = response {
                  print(response)
                          }
            if let data = data {
                
             do {
                 let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                if let result = json["result"] as? String {
                    
                    if(result == "Cancellation done successfully!") {
                        print(result)
                        
                    }
                   
                    if(result == "No reservation found with that reservationId!") {
                        
                        print(result)
                        
                    } } }
               catch{
               print(error)
                    }
            } }.resume()
                                                    
                                        
                                                    
                                                    
        }
       return [deleteAction]
    }
    
    
    
    func tableView(tableView: UITableView, commitEditingStyle editingStyle: UITableViewCellEditingStyle, forRowAtIndexPath indexPath: NSIndexPath) {
        
        }
    
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        // Hide the navigation bar on the this view controller
        self.navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    
    
    
    
    
    
    override func viewWillDisappear( animated: Bool) {
        super.viewWillDisappear(animated)
        
        // Show the navigation bar on other view controllers
        self.navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    
    
    
    
    
    //when protected page is loaded,this line of code will run and it will present the user with a login view.
    override func viewDidAppear(animated: Bool) {
        
        
        //open log in page if user is not logged in
        let isUserLoggedIn = NSUserDefaults.standardUserDefaults().boolForKey("isUserLoggedIn")
        
        if(!isUserLoggedIn) {
            self.performSegueWithIdentifier("loginView", sender: self)
            
        }
    }
    
   
    
    
   
    @IBAction func settingsButtonTapped(sender: AnyObject) {
     //   addBlur()
        animateIn()
        
        
        
    }
    
    
    
    @IBAction func closePopUpButtonTapped(sender: AnyObject) {
        
        animateout()
      //  removeBlur()
        
    }
    
    
    
    func addBlur() {
        
        var effect = UIBlurEffect(style: UIBlurEffectStyle.Light)
        effectView = UIVisualEffectView(effect: effect)
        effectView.frame = CGRectMake(0, 0, self.view.bounds.width, self.view.bounds.height)
        view.addSubview(effectView)
        
    }
    func removeBlur() {
        effectView.removeFromSuperview()
    }

  


}
