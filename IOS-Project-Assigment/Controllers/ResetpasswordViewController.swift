

import Foundation
import UIKit
import Firebase

class ResetpasswordViewController: UIViewController {

    
   
    @IBOutlet weak var txtemail: UITextField!
    @IBOutlet weak var DismissButton: UIButton!
    
    var continueButton:RoundedWhiteButton!
    var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        continueButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Reset Password", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton.center = CGPoint(x: view.center.x, y: view.frame.height - continueButton.frame.height - 24)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = UIColor.white
        continueButton.addTarget(self, action: #selector(handleresetpassword), for: .touchUpInside)
        continueButton.alpha = 0.5
        view.addSubview(continueButton)
        setContinueButton(enabled: false)
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = continueButton.center
        
        view.addSubview(activityView)
        
        txtemail.delegate = self as? UITextFieldDelegate

        
        txtemail.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)

    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        txtemail.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        txtemail.resignFirstResponder()
      
        NotificationCenter.default.removeObserver(self)
    }
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        continueButton.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2)
        activityView.center = continueButton.center
    }
    
    
    @objc func textFieldChanged(_ target:UITextField) {
        let email = txtemail.text
       
        let formFilled = email != nil && email != ""
        setContinueButton(enabled: formFilled)
    }

    @IBAction func Backtologin(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    @objc func handleresetpassword() {
        
        guard let email = txtemail.text else { return }
        
        
        setContinueButton(enabled: false)
        continueButton.setTitle("", for: .normal)
        activityView.startAnimating()
        self.Resetpassword()
    }
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        } else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
        }
    }
   
    private func Resetpassword(){
    
            //reset password
            let resetEmail = self.txtemail.text!
            Auth.auth().sendPasswordReset(withEmail: resetEmail, completion: { (error) in
                //Make sure you execute the following code on the main queue
                DispatchQueue.main.async {
                    //Use "if let" to access the error, if it is non-nil
                    if let error = error {
                       self.resetForm(title: "Password Reset Error", message: error.localizedDescription)
                        return
                    }
                    else {
                        self.populateSuccessAlertBox(title: "Reset Email Sent Successfully", message: "Check your email")
                    }
                }
            })
        
        
    }
    
    //Validation
    private func validateForm() -> Bool {
        
        var title  = ""
        var message = ""
        
         if (txtemail.text?.isEmpty)!{
            print("Please enter a Email")
            title = "Empty Fields"
            message = "Please enter a Email"
            self.resetForm(title: title,message: message)
            return false
        }
        else if  Tools.isValidEmail(testStr: txtemail.text ?? "") {
            print("Please enter a Valid Email")
            title = "Email Validation"
            message = "Please enter a Valid Email"
            self.resetForm(title: title,message: message)
            return false
            
        }

        return true
    }
    
    func Resetsuccuess(){
        self.navigationController?.popViewController(animated: true)
    }
    
    
    //Alert box Error
    func resetForm(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        
        setContinueButton(enabled: true)
        continueButton.setTitle("Reset Password", for: .normal)
        activityView.stopAnimating()
    }
    
     func populateSuccessAlertBox(title:String,message:String){
        
        //Popup alert
        let alert = UIAlertController(title: title, message:message, preferredStyle: .alert)
        let action = UIAlertAction(title: "Ok", style: .cancel, handler: {action in self.Resetsuccuess()})
        alert.addAction(action)
        self.present(alert, animated: true)
    }
    
}
