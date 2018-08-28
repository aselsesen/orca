//
//  RezervationPageViewController.swift
//  orca
//
//  Created by Asel Şeşen on 25.06.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import UIKit
import Foundation



class RezervationPageViewController: UIViewController , UIPickerViewDataSource , UIPickerViewDelegate , UICollectionViewDelegate , UICollectionViewDataSource , UICollectionViewDelegateFlowLayout {
    
    
    @IBOutlet weak var DaysOfWeek: UICollectionView!
    
    @IBOutlet weak var monthLabel: UILabel!
    
    @IBOutlet weak var Calendar: UICollectionView!
    
    @IBOutlet weak var boatTypeTextField: UITextField!
 
    @IBOutlet weak var avaliableHoursTextField: UITextField!
  
    @IBOutlet weak var dateLabel: UILabel!
    
    @IBOutlet weak var popUpReserverLabel: UILabel!

    @IBOutlet var reservationPopUpView: UIView!
   
  
    
    @IBOutlet weak var popUpDateLabel: UILabel!
    
    @IBOutlet weak var popUpBoatTypeLabel: UILabel!
    
    @IBOutlet weak var popUpTimeLabel: UILabel!
    
    var effectView: UIVisualEffectView!
    var tick = UIImage(named: "tick")
    var isClicked:Bool!
   
    
    let months = ["January","February","March","April","May","June","July","August","September","October","November","December"]
    
    let daysOfMonth = ["M","T","W","T","F","S","S"]
    
    let daysInMonths = [31,28,31,30,31,30,31,31,30,31,30,31]
    
    
    
    var currentMonth = String()
    
    let picker1 = UIPickerView()
    let picker2 = UIPickerView()
    
    
    let x = 3;
   
    var selectedDay: String?
    
    var resultDate: String?
    
    var hours = [String]()
    
    
    var temphour = [String]()
    
    
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
       
        
        boatTypeTextField.enabled = false
        boatTypeTextField.backgroundColor = UIColor.lightGrayColor()
        avaliableHoursTextField.enabled = false
        avaliableHoursTextField.backgroundColor = UIColor.lightGrayColor()
        
               //--------
        
        
        
        reservationPopUpView.layer.cornerRadius = 5
        
        
        picker1.dataSource = self
        picker1.delegate = self
        
        picker2.dataSource = self
        picker2.delegate = self
        
        
        picker1.tag = 1
        picker2.tag = 2;
        
        boatTypeTextField.inputView = picker1
avaliableHoursTextField.inputView = picker2
        
        
        
        isClicked = false
    
    self.view.backgroundColor = UIColor(patternImage: UIImage(named: "wallpaper")!)
        
       self.view.addSubview(Calendar)
       self.view.addSubview(DaysOfWeek)
        
        
        currentMonth = months[month]
        monthLabel.text = "\(currentMonth) \(year)"
        
       
        createToolbar()
           }
    
   
    
    
    
    func animateIn() {
        
        
        self.view.addSubview(reservationPopUpView)
        
        resultDate = "\(year)\("-")\(todaysMonth)\("-")\(selectedDay!)"
        
        
        reservationPopUpView.center = self.view.center
        reservationPopUpView.transform = CGAffineTransformMakeScale(1.3, 1.3)
        reservationPopUpView.alpha = 0
        popUpDateLabel.text = resultDate
        popUpTimeLabel.text = selectedHour
        
        popUpReserverLabel.text = NSUserDefaults.standardUserDefaults().stringForKey("userName")
        popUpBoatTypeLabel.text = selectedBoat
        
        
        UIView.animateWithDuration(0.4, animations: {
         
            self.reservationPopUpView.alpha = 1
            self.reservationPopUpView.transform = CGAffineTransformIdentity
        })
        
        
    }
    
    
    func animateout() {
        
        
        
        UIView.animateWithDuration(0.3, animations: { 
            self.reservationPopUpView.transform = CGAffineTransformMakeScale(1.3, 1.3)
            self.reservationPopUpView.alpha = 0
            
       
            
        }) { (success:Bool) in
                self.reservationPopUpView.removeFromSuperview()
        }
        
    }
    
    
    
    
    

    
    func createToolbar() {
        let toolbar = UIToolbar()
        toolbar.sizeToFit()
        
        
        toolbar.barTintColor = UIColor.blackColor()
        toolbar.tintColor = UIColor.whiteColor()
        
        
        
        let doneButton = UIBarButtonItem(title: "Done" , style: .Plain , target: self , action:  #selector(RezervationPageViewController.dismissKeyboard))
        toolbar.setItems([ doneButton ], animated: false)
        
        
        boatTypeTextField.inputAccessoryView = toolbar
        avaliableHoursTextField.inputAccessoryView = toolbar
      
        
    }
    
    
    func dismissKeyboard() {
        view.endEditing(true)
        
    }
    
    
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 7
    }
    
    
 

    @IBAction func dateSelected(_sender: UIButton)  {
        
      
        //prints the selected day -----
      selectedDay = _sender.titleLabel!.text!
     resultDate = "\(year)\("-")\(month)\("-")\(selectedDay!)"

        
        if(selectedDay != nil) {
            boatTypeTextField.enabled = true
            boatTypeTextField.backgroundColor = UIColor.whiteColor()
            
            
            let boatURL = NSURL(string:"http://10.151.103.127:8080/boat/types")
            let session = NSURLSession.sharedSession()
            session.dataTaskWithURL(boatURL!) { (data, response, error) in
                if let data = data {
                    self.boatArray.append("Boat Type")
                    
                    do{
                        let json = try NSJSONSerialization.JSONObjectWithData(data, options: [] ) as? NSArray
                        
                        for obj in json! {
                            if let dict = obj as? NSDictionary {
                                // Now reference the data you need using:
                                let boatTypeName = dict.valueForKey("boatTypeName") as! String
                                self.boatArray.append(boatTypeName)
                                
                            }
                        }
                    }
                    catch {
                        print(error)
                    }
                    
                }
                }.resume()
            
       
            
        }
     

        
        
        for cell in Calendar.visibleCells() as! [DateCollectionViewCell] {
            
            if(  cell.calendarDateLabel != _sender ) {
                
              
                cell.calendarDateLabel.selected = false
                cell.calendarDateLabel.backgroundColor = UIColor.clearColor()
            }
            
            var tag = _sender.tag
            
            if(_sender.selected == true) {
               
                _sender.selected = false
                _sender.backgroundColor = UIColor.redColor()
                
            }
            else if (_sender.selected == false) {
              
                _sender.selected = true
                _sender.backgroundColor = UIColor.clearColor()
                
            }
        
        }
 
        
        }
    
    
   
    
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        
        
        if collectionView == self.Calendar {
            
        let cell1 = collectionView.dequeueReusableCellWithReuseIdentifier("Calendar", forIndexPath: indexPath) as! DateCollectionViewCell
            
            cell1.calendarDateLabel.addTarget(self , action: #selector(dateSelected(_:)), forControlEvents: .TouchUpInside)
       
            
            
            
      collectionView.backgroundColor = UIColor.clearColor()
        cell1.backgroundColor = UIColor.clearColor()
            
            
            
            var arrayOfDays = [String]()
            
            var currentDayValue = weekday
            switch currentDayValue {
            case (1):
                print("Today is sunday")
               // cell1.calendarDateLabel.tag = 0
               
                var sixDaysBefore = NSDate().sixDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                sixDaysBefore = sixDaysBefore[1].characters.split{$0 == " "}.map(String.init)

                var fiveDaysBefore = NSDate().fiveDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                fiveDaysBefore = fiveDaysBefore[1].characters.split{$0 == " "}.map(String.init)

                var fourDaysBefore = NSDate().fourDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                fourDaysBefore = fourDaysBefore[1].characters.split{$0 == " "}.map(String.init)

                var threeDaysBefore = NSDate().threeDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                
                
                threeDaysBefore = threeDaysBefore[1].characters.split{$0 == " "}.map(String.init)
                
                var twoDaysBefore = NSDate().twoDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                
                twoDaysBefore = twoDaysBefore[1].characters.split{$0 == " "}.map(String.init)

                var yesterday = NSDate().yesterday.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                yesterday = yesterday[1].characters.split{$0 == " "}.map(String.init)

                
                

                var today = date.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                 today = today[1].characters.split{$0 == " "}.map(String.init)
   
                
                
                arrayOfDays.append(sixDaysBefore[1])
                arrayOfDays.append(fiveDaysBefore[1])
                arrayOfDays.append(fourDaysBefore[1])
                arrayOfDays.append(threeDaysBefore[1])
                arrayOfDays.append(twoDaysBefore[1])
                arrayOfDays.append(yesterday[1])
                arrayOfDays.append(today[1])
                
                
                 cell1.calendarDateLabel.setTitleColor(UIColor.grayColor(), forState: .Normal)
                
                
                
                
                var userInteraction: [Bool] = [false , false , false , false , false , false , false ]
                
                cell1.calendarDateLabel.userInteractionEnabled = userInteraction[indexPath.row]
                
                
                
                

                //WEEKDAY IS 2
            case (2):
                print("Today is monday")
               // cell1.calendarDateLabel.tag = 1
                var today = date.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                today = today[1].characters.split{$0 == " "}.map(String.init)

                var tomorrow = NSDate().tomorrow.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                tomorrow = tomorrow[1].characters.split{$0 == " "}.map(String.init)
                var twoDaysLater = NSDate().twoDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                twoDaysLater = twoDaysLater[1].characters.split{$0 == " "}.map(String.init)
                
                var threeDaysLater = NSDate().threeDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                threeDaysLater = threeDaysLater[1].characters.split{$0 == " "}.map(String.init)
                var fourDaysLater = NSDate().fourDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                fourDaysLater = fourDaysLater[1].characters.split{$0 == " "}.map(String.init)
                
                
                var fiveDaysLater = NSDate().fiveDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                fiveDaysLater = fiveDaysLater[1].characters.split{$0 == " "}.map(String.init)
                var sixDaysLater = NSDate().sixDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
              sixDaysLater = sixDaysLater[1].characters.split{$0 == " "}.map(String.init)
                
                
                
               
                arrayOfDays.append(today[1])
                arrayOfDays.append(tomorrow[1])
                arrayOfDays.append(twoDaysLater[1])
                arrayOfDays.append(threeDaysLater[1])
                arrayOfDays.append(fourDaysLater[1])
                arrayOfDays.append(fiveDaysLater[1])
                arrayOfDays.append(sixDaysLater[1])
                
                let colors = [ UIColor.grayColor() , UIColor.blackColor() , UIColor.blackColor() ,UIColor.blackColor() ,UIColor.blackColor(), UIColor.blackColor() ,UIColor.blackColor()   ]
                let bgcolor = colors[indexPath.row]
                cell1.calendarDateLabel.tintColor = bgcolor
                
                
                
                var userInteraction: [Bool] = [false , true , true , true , true , true , true]
                
                cell1.calendarDateLabel.userInteractionEnabled = userInteraction[indexPath.row]
                
                
                
                
            case (3):
                print("Today is tuesday")
                
              //  cell1.calendarDateLabel.tag = 2
                
                var yesterday = NSDate().yesterday.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                yesterday = yesterday[1].characters.split{$0 == " "}.map(String.init)

                var today = date.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                today = today[1].characters.split{$0 == " "}.map(String.init)
                var tomorrow = NSDate().tomorrow.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                tomorrow = tomorrow[1].characters.split{$0 == " "}.map(String.init)

                var twoDaysLater = NSDate().twoDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                twoDaysLater = twoDaysLater[1].characters.split{$0 == " "}.map(String.init)

                var threeDaysLater = NSDate().threeDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                threeDaysLater = threeDaysLater[1].characters.split{$0 == " "}.map(String.init)
                var fourDaysLater = NSDate().fourDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                fourDaysLater = fourDaysLater[1].characters.split{$0 == " "}.map(String.init)
                
                var fiveDaysLater = NSDate().fiveDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                fiveDaysLater = fiveDaysLater[1].characters.split{$0 == " "}.map(String.init)
                
              
                arrayOfDays.append(yesterday[1])
                arrayOfDays.append(today[1])
                arrayOfDays.append(tomorrow[1])
                arrayOfDays.append(twoDaysLater[1])
                arrayOfDays.append(threeDaysLater[1])
                arrayOfDays.append(fourDaysLater[1])
                arrayOfDays.append(fiveDaysLater[1])
                

                let colors = [ UIColor.grayColor() , UIColor.grayColor() , UIColor.blackColor() ,UIColor.blackColor() ,UIColor.blackColor(), UIColor.blackColor() ,UIColor.blackColor()   ]
                let bgcolor = colors[indexPath.row]
                cell1.calendarDateLabel.tintColor = bgcolor
                
                var userInteraction: [Bool] = [false , false , true , true , true , true , true]
                
                cell1.calendarDateLabel.userInteractionEnabled = userInteraction[indexPath.row]
                
                
            case (4):
                print("Today is wednesday")
                
               // cell1.calendarDateLabel.tag = 3
                var twoDaysBefore = NSDate().twoDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                twoDaysBefore = twoDaysBefore[1].characters.split{$0 == " "}.map(String.init)

                var yesterday = NSDate().yesterday.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                yesterday = yesterday[1].characters.split{$0 == " "}.map(String.init)

                var today = date.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
today = today[1].characters.split{$0 == " "}.map(String.init)
                var tomorrow = NSDate().tomorrow.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                
                tomorrow = tomorrow[1].characters.split{$0 == " "}.map(String.init)
                
                var twoDaysLater = NSDate().twoDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                twoDaysLater = twoDaysLater[1].characters.split{$0 == " "}.map(String.init)

                var threeDaysLater = NSDate().threeDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                threeDaysLater = threeDaysLater[1].characters.split{$0 == " "}.map(String.init)
                var fourDaysLater = NSDate().fourDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                fourDaysLater = fourDaysLater[1].characters.split{$0 == " "}.map(String.init)
                
                
                arrayOfDays.append(twoDaysBefore[1])
                arrayOfDays.append(yesterday[1])
                arrayOfDays.append(today[1])
                arrayOfDays.append(tomorrow[1])
                arrayOfDays.append(twoDaysLater[1])
                arrayOfDays.append(threeDaysLater[1])
                arrayOfDays.append(fourDaysLater[1])
                
                
                
                let colors = [ UIColor.grayColor() , UIColor.grayColor() , UIColor.grayColor() ,UIColor.blackColor() ,UIColor.blackColor(), UIColor.blackColor() ,UIColor.blackColor()   ]
                let bgcolor = colors[indexPath.row]
                cell1.calendarDateLabel.tintColor = bgcolor
                
                
                
                var userInteraction: [Bool] = [false , false , false , true , true , true , true]
                
                cell1.calendarDateLabel.userInteractionEnabled = userInteraction[indexPath.row]
                
                
            case (5):
                print("Today is thursday")
              //  cell1.calendarDateLabel.tag = 4
                var threeDaysBefore = NSDate().threeDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                
                threeDaysBefore = threeDaysBefore[1].characters.split{$0 == " "}.map(String.init)

                var twoDaysBefore = NSDate().twoDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                twoDaysBefore = twoDaysBefore[1].characters.split{$0 == " "}.map(String.init)
                
                var yesterday = NSDate().yesterday.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                yesterday = yesterday[1].characters.split{$0 == " "}.map(String.init)
                
                var today = date.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

                today = today[1].characters.split{$0 == " "}.map(String.init)
                
                var tomorrow = NSDate().tomorrow.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                tomorrow = tomorrow[1].characters.split{$0 == " "}.map(String.init)

                var twoDaysLater = NSDate().twoDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                twoDaysLater = twoDaysLater[1].characters.split{$0 == " "}.map(String.init)

                var threeDaysLater = NSDate().threeDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
threeDaysLater = threeDaysLater[1].characters.split{$0 == " "}.map(String.init)
                
               
                arrayOfDays.append(threeDaysBefore[1])
                arrayOfDays.append(twoDaysBefore[1])
                arrayOfDays.append(yesterday[1])
                arrayOfDays.append(today[1])
                arrayOfDays.append(tomorrow[1])
                arrayOfDays.append(twoDaysLater[1])
                arrayOfDays.append(threeDaysLater[1])
                
                let colors = [ UIColor.grayColor() , UIColor.grayColor() , UIColor.grayColor() ,UIColor.grayColor() ,UIColor.blackColor(), UIColor.blackColor() ,UIColor.blackColor()   ]
                let bgcolor = colors[indexPath.row]
                cell1.calendarDateLabel.tintColor = bgcolor
                
                
                
                var userInteraction: [Bool] = [false , false , false , false , true , true , true]
                
                cell1.calendarDateLabel.userInteractionEnabled = userInteraction[indexPath.row]

                
            case (6):
                print("Today is friday")
               // cell1.calendarDateLabel.tag = 5
                var fourDaysBefore = NSDate().fourDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
               fourDaysBefore = fourDaysBefore[1].characters.split{$0 == " "}.map(String.init)
                
              ///////////
                
                var threeDaysBefore = NSDate().threeDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
 
              threeDaysBefore = threeDaysBefore[1].characters.split{$0 == " "}.map(String.init)

                ///////////
                
                
                var twoDaysBefore = NSDate().twoDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                twoDaysBefore = twoDaysBefore[1].characters.split{$0 == " "}.map(String.init)
                
                //////////

                var yesterday = NSDate().yesterday.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                yesterday = yesterday[1].characters.split{$0 == " "}.map(String.init)
                /////////
                

                var today = date.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                today = today[1].characters.split{$0 == " "}.map(String.init)
                
                /////////

                var tomorrow = NSDate().tomorrow.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                tomorrow = tomorrow[1].characters.split{$0 == " "}.map(String.init)
                //////

                var twoDaysLater = NSDate().twoDaysLater.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)

               twoDaysLater = twoDaysLater[1].characters.split{$0 == " "}.map(String.init)
                
                
                
                arrayOfDays.append(fourDaysBefore[1])   //arrayOfDays[0]
                arrayOfDays.append(threeDaysBefore[1])   //arrayOfDays[1]
                arrayOfDays.append(twoDaysBefore[1])   //....
                arrayOfDays.append(yesterday[1])
                arrayOfDays.append(today[1])
                arrayOfDays.append(tomorrow[1])
                arrayOfDays.append(twoDaysLater[1])
                
                let colors = [ UIColor.grayColor() , UIColor.grayColor() , UIColor.grayColor() ,UIColor.grayColor() ,UIColor.grayColor(), UIColor.blackColor() ,UIColor.blackColor()   ]
                let bgcolor = colors[indexPath.row]
                cell1.calendarDateLabel.tintColor = bgcolor
               
                
                var userInteraction: [Bool] = [false , false , false , false , false , true , true]
                
                cell1.calendarDateLabel.userInteractionEnabled = userInteraction[indexPath.row]
                
            case (7):
                print("Today is saturday")
               // cell1.calendarDateLabel.tag = 6
                var fiveDaysBefore = NSDate().fiveDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                fiveDaysBefore = fiveDaysBefore[1].characters.split{$0 == " "}.map(String.init)
                
                var fourDaysBefore = NSDate().fourDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                fourDaysBefore = fourDaysBefore[1].characters.split{$0 == " "}.map(String.init)
                
                var threeDaysBefore = NSDate().threeDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                threeDaysBefore = threeDaysBefore[1].characters.split{$0 == " "}.map(String.init)
                
                
                var twoDaysBefore = NSDate().twoDaysBefore.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                twoDaysBefore = twoDaysBefore[1].characters.split{$0 == " "}.map(String.init)
                
                var yesterday = NSDate().yesterday.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                
                
                yesterday = yesterday[1].characters.split{$0 == " "}.map(String.init)
                
                
                var today = date.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                today = today[1].characters.split{$0 == " "}.map(String.init)
                
                var tomorrow = NSDate().tomorrow.descriptionWithLocale(NSLocale.currentLocale()).characters.split{$0 == ","}.map(String.init)
                tomorrow = tomorrow[1].characters.split{$0 == " "}.map(String.init)
                
                arrayOfDays.append(fiveDaysBefore[1])   //arrayOfDays[0]
                arrayOfDays.append(fourDaysBefore[1])   //arrayOfDays[1]
                arrayOfDays.append(threeDaysBefore[1])   //....
                arrayOfDays.append(twoDaysBefore[1])   //....
                arrayOfDays.append(yesterday[1])
                arrayOfDays.append(today[1])
                arrayOfDays.append(tomorrow[1])
               
                let colors = [ UIColor.grayColor() , UIColor.grayColor() , UIColor.grayColor() ,UIColor.grayColor() ,UIColor.grayColor(), UIColor.grayColor() ,UIColor.blackColor()   ]
                let bgcolor = colors[indexPath.row]
                cell1.calendarDateLabel.tintColor = bgcolor
                
                
                var userInteraction: [Bool] = [false , false , false , false , false , false , true ]
                
                cell1.calendarDateLabel.userInteractionEnabled = userInteraction[indexPath.row]
                
                
                
            default:
                print("This is default")
            }
            
            
           
            
               cell1.calendarDateLabel.setTitle(arrayOfDays[indexPath.row], forState: .Normal)
        
            
             //  cell1.calendarDateLabel.setTitleColor(UIColor.blackColor() , forState: .Normal)
            
           
            
            
            return cell1
        }
        
        
        else{
        
        let cell2 = collectionView.dequeueReusableCellWithReuseIdentifier("DaysOfWeek", forIndexPath: indexPath) as! DateCollectionViewCell
        
        collectionView.backgroundColor = UIColor.clearColor()
        cell2.backgroundColor = UIColor.clearColor()
            
        cell2.dateLabel.text = daysOfMonth[indexPath.row]
            
              
               return cell2
        
        }
    }
    
    
    
    
   
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        
        
        if collectionView == self.Calendar {
        
            return CGSize(width: 30, height: 30) }
        else {
            
            return CGSize(width:  30  , height: 30)
        }
        
        
    }
    
    
    


    var selectedHour : String?
    var selectedBoat : String?
    func numberOfComponentsInPickerView(pickerView: UIPickerView) -> Int {
        
        
        return 1
    }
     var boatArray = [String]()
    func pickerView(pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
       
        
        
                if ( pickerView == picker1)  {
                    
               //  boatArray.append("Boat Type")
          
                   return boatArray[row]
                  
        }

        else if (pickerView == picker2 ){
                    
                    
            //RETURN AVAILABLE HOURS
       
                    
            return hours[row]
            
        }
        else {
            
            return ""
            
        }
        
           }

    
    
    func pickerView(pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        
         if (pickerView == picker1 ){
     
            
         return boatArray.count
            
            
        }
         else if (pickerView == picker2 ){
            
            
            return hours.count
            
        }
       
        
        return 1
    }
    
    
   
    
    
    
    func pickerView(pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        //what user selected will be stored in selected hour
        
          if (pickerView == picker1 ){
                selectedBoat = boatArray[row]
        boatTypeTextField.text = selectedBoat
            if(selectedBoat != nil  && resultDate != nil ) {
                print("Boat is selected and it is : " + selectedBoat! )
                print(resultDate!)
                avaliableHoursTextField.enabled = true
                avaliableHoursTextField.backgroundColor = UIColor.whiteColor()
                
                let parameters = ["reservationDate": resultDate! , "boatType":  selectedBoat! ]
                guard let availableHoursURL = NSURL(string: "http://10.151.103.127:8080/get-available-hours" ) else {return }
                var request = NSMutableURLRequest(URL: availableHoursURL)
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
                        self.hours.append("Hours")
                        do {
                            let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                            
                            
                            self.temphour = json.valueForKey("result") as![String]
                            
                            for obj in self.temphour {
                                
                                self.hours.append(obj)
                                
                            }
                            print(self.hours)
                            
                        }   catch{
                            print(error)
                        }
                        
                    }
                    }.resume()

                
                
                
                
                
            }
            
            
          }
        
        
          else  if ( pickerView == picker2 ){
        selectedHour = hours[row]
            avaliableHoursTextField.text = selectedHour
        }
        
    }
    
    
    
    func pickerView(pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusingView view: UIView?) -> UIView {
        
        if (pickerView == picker1) {
                   var label: UILabel
        if let view = view as? UILabel {
            label = view
        }else {
            
            label = UILabel()
            
            
        }
        label.textColor = UIColor.blackColor()
        label.textAlignment = .Center
        label.font = UIFont(name: "Arial" , size: 20)
        label.text = boatArray[row]
        
        return label
        }
        
        else {
            
            var label: UILabel
            if let view = view as? UILabel {
                label = view
            }else {
                
                label = UILabel()
                
                
            }
            label.textColor = UIColor.blackColor()
            label.textAlignment = .Center
            label.font = UIFont(name: "Arial" , size: 20)
            label.text = hours[row]
            
            return label
            
            
            
        }
    
       
        
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
         //   let logo =  UIImage(named: "rowings")
        // let imageView = UIImageView(image:logo)
        //imageView.frame = CGRect(x: 0 , y: 0 , width: 34 , height: 34)
        //imageView.contentMode = .ScaleAspectFit
        
        //self.navigationItem.titleView = imageView
        //Navigation Bar Title NAME and color of the title
       self.navigationItem.title = " Reservation Information "
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AmericanTypewriter", size: 20)!]
        self.navigationController?.navigationBar.backItem?.title = " "
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
        
        
    }
    
    func displayAlertMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Reservation", message: userMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Ok", style: UIAlertActionStyle.Default , handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true , completion: nil)
    }

    func displayRetryMessage(userMessage:String) {
        let myAlert = UIAlertController(title: "Reservation", message: userMessage, preferredStyle: .Alert)
        let okAction = UIAlertAction(title: "Retry", style: UIAlertActionStyle.Default , handler: nil)
        myAlert.addAction(okAction)
        self.presentViewController(myAlert, animated: true , completion: nil)
        
        
    }
    
    
    @IBAction func reserveTapped(sender: AnyObject) {
        
        //IF there are missing data from user display alert message
        if( selectedBoat==nil  || selectedHour == nil   || selectedDay == nil) {
            
            displayAlertMessage("All fields are required!");
            return;
            
            
        }
      
        
       addBlur()
       animateIn()
        
        
    }
   
   
    @IBAction func cancelTappedonPopUp(sender: AnyObject) {
        
       animateout()
       removeBlur()
        
    }
    
    
    @IBAction func confirmTappedonPopUp(sender: AnyObject) {

        let userEmail = NSUserDefaults.standardUserDefaults().stringForKey("userEmail")!
        let time = selectedHour!
        let boatType = selectedBoat!
        let date = resultDate!
        let parameters = ["email": userEmail , "time": time , "boatType": boatType , "date": date ]
        
        guard let reservationURL = NSURL(string: "http://10.151.103.127:8080/reserve" ) else {return }
        var reservationRequest = NSMutableURLRequest(URL: reservationURL)
        
        reservationRequest.HTTPMethod = "POST"
        reservationRequest.addValue("application/json", forHTTPHeaderField: "Content-Type")
        reservationRequest.addValue("application/json", forHTTPHeaderField: "Accept")
        
        guard let httpBody = try? NSJSONSerialization.dataWithJSONObject(parameters , options: [] ) else {return }
        reservationRequest.HTTPBody = httpBody
        
        let session = NSURLSession.sharedSession()
        session.dataTaskWithRequest(reservationRequest) { (data, response, error) in
        if let response = response {
                print(response)
            }
            if let data = data {
                do {
                    let json = try NSJSONSerialization.JSONObjectWithData(data, options: .AllowFragments)
                    if let result = json["result"] as? String {
                        
                        if(result == "Reservation request has been submitted!") {
                            print(result)
                           self.displayAlertMessage("Your reservation request has been succesfully submitted!")
                            
                        }
                        
                        if(result == "Reservation request failed since only a reservation can be done per day.") {
                            print(result)
                           self.displayRetryMessage("Reservation request could not be submitted!")
                            
                        }

                        
                    }

                    print(json)
                    
                }catch{
                    print(error)
                }
                
            }
            }.resume()
        
       
        
        animateout()
        removeBlur()
        
       
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

