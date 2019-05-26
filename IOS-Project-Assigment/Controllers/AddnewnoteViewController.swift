

import UIKit

class AddnewnoteViewController: UIViewController {
    
    
  
    
   

   
    
    
    
    @IBOutlet weak var Cancelbtn: UIBarButtonItem!
    
    @IBOutlet weak var Placeholder: UILabel!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var txtnewnote: UITextView!
    
    var addnoteList:[String] = []
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        Cancelbtn.tintColor = secondaryColor
        
        doneButton.backgroundColor = secondaryColor
        doneButton.layer.cornerRadius = doneButton.bounds.height / 2
        doneButton.clipsToBounds = true
        
        txtnewnote.delegate = self as? UITextViewDelegate
        
    
        
        addnoteList = defaults.object(forKey: "savedNotes") as? [String] ?? [String]()
    }
    
    
    @IBAction func backtohomework(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    
    @IBAction func saveNewNoteBtn(_ sender: UIButton) {
        
        addnoteList.append(txtnewnote.text)
        defaults.set(self.addnoteList, forKey: "savedNotes")
        print(self.addnoteList)
        self.dismiss(animated: true, completion: nil)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtnewnote.becomeFirstResponder()
        
        // Remove the nav shadow underline
        navigationController?.navigationBar.shadowImage = UIImage()
    }
    
    func textViewDidChange(_ textView: UITextView) {
        Placeholder.isHidden = !textView.text.isEmpty
    }
    
    override func dismiss(animated flag: Bool, completion: (() -> Void)? = nil) {
        txtnewnote.resignFirstResponder()
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.25, execute: {
            super.dismiss(animated: flag, completion: completion)
        })
    }
}
