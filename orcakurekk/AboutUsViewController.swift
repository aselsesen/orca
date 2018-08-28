//
//  AboutUsViewController.swift
//  orcakurekk
//
//  Created by Asel Şeşen on 15.08.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import UIKit

class AboutUsViewController: UIViewController {

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
        self.navigationItem.title = " About Us "
        self.navigationController?.navigationBar.titleTextAttributes = [NSFontAttributeName: UIFont(name: "AmericanTypewriter", size: 20)!]
        self.navigationController?.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.blackColor()]
    }
}
