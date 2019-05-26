

import UIKit
import LocalAuthentication

class TabbarViewController: UITabBarController, UITabBarControllerDelegate {
    
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tabBarController?.delegate = self
    }

    
    //Authentication fingerprint
    func authenticationFingerPrint(){
        let authContext = LAContext()
        let authReason = "Please use Touch ID to access Your Account"
        var authError : NSError?
        
        if authContext.canEvaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, error: &authError){
            
            authContext.evaluatePolicy(LAPolicy.deviceOwnerAuthenticationWithBiometrics, localizedReason: authReason, reply: { (success,error) -> Void in
                if success{
                    //Go to My Account Page
                    print("Authentication Success")
                    self.defaults.set(true, forKey: "isAuthorized")
                    self.selectedIndex = 2
                }
                
                if error != nil{
                    self.defaults.set(false, forKey: "isAuthorized")
                    self.ShowAlert(title: "Touch ID Error", message: (error?.localizedDescription)!)
                }
                
            })
            
        }
        else{
            self.defaults.set(false, forKey: "isAuthorized")
            ShowAlert(title: "Touch ID Error", message: (authError?.localizedDescription)!)
        
        }
    }
    //alert
    func ShowAlert(title:String,message:String){
        
    
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title:"Ok", style: .default, handler:nil)
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
    
}
