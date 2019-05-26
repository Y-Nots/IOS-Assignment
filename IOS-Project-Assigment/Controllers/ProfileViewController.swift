
import UIKit
import LocalAuthentication
import Firebase

class ProfileViewController: UIViewController {

    
    @IBOutlet weak var profName: UILabel!
    @IBOutlet weak var Emailaddress: UILabel!
    
    @IBOutlet weak var NICno: UILabel!
    
    @IBOutlet weak var profileview: UILabel!
    
    @IBOutlet weak var phoneno: UILabel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
         profileview.alpha = 1
     
    }
    
    override func viewDidAppear(_ animated: Bool) {
        profileview.alpha = 1
        FingerprintAuthenticate()
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        profileview.alpha = 1
    }
    
    func Profiledata(){
       Database.database().reference().child("MyProfile").observeSingleEvent(of: .value, with: {( snapshot ) in
            
            if let dictionary = snapshot.value as?  NSDictionary{
                let profname = dictionary["Profname"] as! String
              
        
                let PhoneNo = dictionary["PhoneNo"] as! String
                let NIC = dictionary["NIC"] as! Int
                let Emailadress = dictionary["Email"] as! String
               
                self.profName.text = profname
                self.NICno.text = NIC.description
                self.phoneno.text = PhoneNo
                self.Emailaddress.text = Emailadress
            }
        })
    }
    
    
    
    func FingerprintAuthenticate(){
        let authContext = LAContext()
        let authReason = "Please use Touch ID to access Your Account"
        var authError : NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: { (success,error) -> Void in
                if success{
                    print("Authentication Success")
                    DispatchQueue.main.async{
                        self.Profiledata()
                       
                    }
                }
                if error != nil{
                    self.ShowAlert(title: "Touch ID Error", message: (error?.localizedDescription)!)
                }
            })
        }
        else{
            ShowAlert(title: "Touch ID Error", message: (authError?.localizedDescription)!)
            
        }
    }
 
    func ShowAlert(title:String,message:String){
        
        //alert
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title:"Ok", style: .default, handler:nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
}
