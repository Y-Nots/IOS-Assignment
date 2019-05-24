//
//  NoteTableViewCell.swift
//  IOS-Project-Assigment
//
//  Created by kevin shayn on 5/24/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
//

import UIKit

class NoteTableViewCell: UITableViewCell {
    

    @IBOutlet weak var lblnote: UILabel!
    
    func setNotes(getnote:String){
      
        self.lblnote.text = getnote
    }

}
