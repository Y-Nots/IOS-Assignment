

import UIKit

class NoteTableViewCell: UITableViewCell {
    

    @IBOutlet weak var lblnote: UILabel!
    
    func setNotes(getnote:String){
      
        self.lblnote.text = getnote
    }

}
