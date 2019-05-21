//
//  HomeScreenViewController.swift
//  IOS-Project-Assigment
//
//  Created by kevin shayn on 5/21/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
//

import UIKit
import  Firebase

class HomeScreenViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    
    @IBAction func SignOut(_ sender: UIButton) {
        try! Auth.auth().signOut()
        self.dismiss(animated: false
            , completion: nil)
        
    }
    

    
    
    
}
