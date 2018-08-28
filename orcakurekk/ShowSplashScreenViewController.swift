//
//  ShowSplashScreen.swift
//  orca
//
//  Created by Asel Şeşen on 10.06.2018.
//  Copyright © 2018 Asel Şeşen. All rights reserved.
//

import UIKit

class ShowSplashScreen: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        performSelector(Selector("showNavController"), withObject: nil, afterDelay: 1)
    }
    
    
    func showNavController() {
        
        performSegueWithIdentifier("showSplashScreen", sender: self)
        
    }
    
    
    
    
    
    
    
    
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
}
