//
//  HomeworkViewController.swift
//  IOS-Project-Assigment
//
//  Created by kevin shayn on 5/24/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
//

import UIKit

class HomeworkViewController: UIViewController, UITableViewDelegate, UITableViewDataSource  {
    
    
    
    var getNotelist:[String] = []
    
    @IBOutlet weak var notetableview: UITableView!
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.notetableview.delegate = self
        self.notetableview.rowHeight = 75
        getNotelist = defaults.object(forKey: "savedNotes") as? [String] ?? [String]()
        DispatchQueue.main.async {
            self.notetableview.reloadData()
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        getNotelist = defaults.object(forKey: "savedNotes") as? [String] ?? [String]()
        print(getNotelist.count)
        DispatchQueue.main.async {
            self.notetableview.reloadData()
        }
        DispatchQueue.main.async {
            self.notetableview.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
      
        return self.getNotelist.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var note:String = ""
        note = self.getNotelist[indexPath.row]
    
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Notecell" ,for: indexPath) as! NoteTableViewCell
        
        //Set data to cellview attributes
        cell.setNotes(getnote: note)
        return cell
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
