//
//  AddnewnoteViewController.swift
//  IOS-Project-Assigment
//
//  Created by kevin shayn on 5/24/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
//

import UIKit

class AddnewnoteViewController: UIViewController {
    
    

    @IBOutlet weak var txtnewnote: UITextView!
    
    var addnoteList:[String] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        txtnewnote.text = "Type..."
        txtnewnote.textColor = UIColor.lightGray
        addnoteList = defaults.object(forKey: "savedNotes") as? [String] ?? [String]()
    }
    
    
    @IBAction func backBtn(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func saveNewNoteBtn(_ sender: UIButton) {
        
        addnoteList.append(txtnewnote.text)
        defaults.set(self.addnoteList, forKey: "savedNotes")
        print(self.addnoteList)
        self.dismiss(animated: true, completion: nil)
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
