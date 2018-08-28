//
//  HistoryViewController.swift
//  orcakurekk
//
//  Created by Asel Şeşen on 15.08.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import UIKit

class HistoryViewController: UIViewController  ,  UITableViewDelegate , UITableViewDataSource {

    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
              // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    
    override func viewWillAppear(animated: Bool) {
        self.navigationController?.navigationBar.barTintColor = UIColor.whiteColor()
        self.navigationItem.title = " History "
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AmericanTypewriter", size: 20)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 30
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("cell", forIndexPath: indexPath) as! HistoryControllerTableViewCell
        cell.reservationDate.text = "11-01-2018"
        cell.reservationTime.text = "12:00"
        
        //cell.cellImage.image = UIImage(named: "")
        return cell

        
        
        
    }
    

}
