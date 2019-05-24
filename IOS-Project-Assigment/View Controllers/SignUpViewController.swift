
import Foundation
import UIKit
import Firebase

class SignUpViewController:UIViewController, UITextFieldDelegate {
    
    @IBOutlet weak var usernameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var dismissButton: UIButton!
     @IBOutlet weak var ConfpasswordField: UITextField!
    
    
    var continueButton:RoundedWhiteButton!
    var activityView:UIActivityIndicatorView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.addVerticalGradientLayer(topColor: primaryColor, bottomColor: secondaryColor)
        
        continueButton = RoundedWhiteButton(frame: CGRect(x: 0, y: 0, width: 200, height: 50))
        continueButton.setTitleColor(secondaryColor, for: .normal)
        continueButton.setTitle("Continue", for: .normal)
        continueButton.titleLabel?.font = UIFont.systemFont(ofSize: 18.0, weight: UIFont.Weight.bold)
        continueButton.center = CGPoint(x: view.center.x, y: view.frame.height - continueButton.frame.height - 24)
        continueButton.highlightedColor = UIColor(white: 1.0, alpha: 1.0)
        continueButton.defaultColor = UIColor.white
        continueButton.addTarget(self, action: #selector(handleSignUp), for: .touchUpInside)
        
        view.addSubview(continueButton)
        setContinueButton(enabled: false)
        
        activityView = UIActivityIndicatorView(activityIndicatorStyle: .gray)
        activityView.color = secondaryColor
        activityView.frame = CGRect(x: 0, y: 0, width: 50.0, height: 50.0)
        activityView.center = continueButton.center
        view.addSubview(activityView)
        
        usernameField.delegate = self
        emailField.delegate = self
        passwordField.delegate = self
        ConfpasswordField.delegate = self
        
        usernameField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        emailField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        passwordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
        ConfpasswordField.addTarget(self, action: #selector(textFieldChanged), for: .editingChanged)
    }
    
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        usernameField.becomeFirstResponder()
        NotificationCenter.default.addObserver(self, selector:#selector(keyboardWillAppear), name: NSNotification.Name.UIKeyboardWillShow, object: nil)
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        usernameField.resignFirstResponder()
        emailField.resignFirstResponder()
        passwordField.resignFirstResponder()
        ConfpasswordField.resignFirstResponder()
        
        NotificationCenter.default.removeObserver(self)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        get {
            return .lightContent
        }
    }
    
    @IBAction func handleDismissButton(_ sender: Any) {
        self.dismiss(animated: false, completion: nil)
    }
    
    /**
     Adjusts the center of the **continueButton** above the keyboard.
     - Parameter notification: Contains the keyboardFrame info.
     */
    
    @objc func keyboardWillAppear(notification: NSNotification){
        
        let info = notification.userInfo!
        let keyboardFrame: CGRect = (info[UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
        
        continueButton.center = CGPoint(x: view.center.x,
                                        y: view.frame.height - keyboardFrame.height - 16.0 - continueButton.frame.height / 2)
        activityView.center = continueButton.center
    }
    
    
    @objc func textFieldChanged(_ target:UITextField) {
        let username = usernameField.text
        let email = emailField.text
        let password = passwordField.text
        let confopassword = ConfpasswordField.text
        
        let formFilled = username != nil && username != "" && email != nil && email != "" && password != nil && password != "" && confopassword != nil && confopassword != ""
        setContinueButton(enabled: formFilled)
    }
    
    
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        
         // Resigns the target textField and assigns the next textField in the form.

        switch textField {
        case usernameField:
            usernameField.resignFirstResponder()
            emailField.becomeFirstResponder()
            break
        case emailField:
            emailField.resignFirstResponder()
            passwordField.becomeFirstResponder()
            break
        case passwordField:
            passwordField.resignFirstResponder()
            ConfpasswordField.becomeFirstResponder()
            //handleSignUp()
            break
        case ConfpasswordField:
           
            handleSignUp()
            break
        default:
            break
        }
        return true
    }
    
    /**
     Enables or Disables the **continueButton**.
     */
    
    func setContinueButton(enabled:Bool) {
        if enabled {
            continueButton.alpha = 1.0
            continueButton.isEnabled = true
        } else {
            continueButton.alpha = 0.5
            continueButton.isEnabled = false
        }
    }
    
    
    private func signUp() {
        
        print("Succuess signup")
        guard let username = usernameField.text else { return }
        guard let email = emailField.text else { return }
        guard let password = passwordField.text else { return }
        guard let ConfirmpasswordField = ConfpasswordField.text else { return }
        
        
        setContinueButton(enabled: false)
        continueButton.setTitle("", for: .normal)
        activityView.startAnimating()
        
        
        Auth.auth().createUser(withEmail: email, password: password){user, Error in
            if Error == nil && user != nil{
                
                print("User Created ")
                
                
                let regesttochange = Auth.auth().currentUser?.createProfileChangeRequest()
                regesttochange?.displayName = username
                regesttochange?.commitChanges{error in
                    if error == nil{
                        
                        print("User Change successfuly")
                        self.dismiss(animated: false, completion: nil)
                        
                    }
                    
                    
                }
                
            }
            else{
                print("Error:\(Error!.localizedDescription )")
                return 
            }
        }
        
    }
    
    @objc func handleSignUp() {
       
        if (validateForm()){
            signUp()
        }
        
    }

    private func validateForm() -> Bool {
//
        
        var title  = ""
        var message = ""
//        if usernameField.text == "" {
//            //lblError.text = "Please enter a username"
//
//             print("Please enter a username")
//            self.resetForm()
//            return false
//
//
//
//        }
//        if usernameField.text?.count ?? 0 < 6 {
//            //lblError.text = "Username should be at least 6 characters long"
//
//            print("Username should be at least 6 characters long")
//            self.resetForm()
//            return false
//        }
//        if emailField.text == "" || Tools.isValidEmail(testStr: emailField.text ?? "") {
//            //lblError.text = "Please enter a valid email"
//            print("Paaword should be at least 6 characters long")
//            self.resetForm()
//            return false
//        }
//        if passwordField.text == "" || passwordField.text?.count ?? 0 < 6 {
//           // lblError.text = "Paaword should be at least 6 characters long"
//
//            print("Paaword should be at least 6 characters long")
//            self.resetForm()
//            return false
//        }
//        if passwordField.text != ConfpasswordField.text {
//            print("Passwords doesnot match")
//            //lblError.text = "Passwords doesnot match"
//            self.resetForm()
//            return false
//        }
        
        
        
        if (usernameField.text?.isEmpty)!{
            print("Please enter a username")
             title = "Empty Fields"
            message = "Please enter a username"
            self.resetForm(title: title,message: message)
            return false
        }
        else if (emailField.text?.isEmpty)!{
             print("Please enter a Email")
            title = "Empty Fields"
            message = "Please enter a Email"
            self.resetForm(title: title,message: message)
            return false
        }
        
        else if (passwordField.text?.isEmpty)!{
            print("Please enter a Password")
            title = "Empty Fields"
            message = "Please enter a Password"
            self.resetForm(title: title,message: message)
            return false
        }
        else if (ConfpasswordField.text?.isEmpty)!{
            print("Please enter a Confrm password")
            title = "Empty Fields"
            message = "Please enter a Confrm password"
            self.resetForm(title: title,message: message)
            return false
        }
           else if passwordField.text != ConfpasswordField.text {
            
            print("Passwords doesnot match")
            //lblError.text = "Passwords doesnot match"
            title = "Missmatch !"
            message = "Passwords does not match"
            self.resetForm(title: title,message: message)
            return false
            }
        
        
        return true
    }
    
    
    func resetForm(title:String,message:String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Okay", style: .default, handler: nil))
        self.present(alert, animated: true, completion: nil)

        setContinueButton(enabled: true)
        continueButton.setTitle("Continue", for: .normal)
        activityView.stopAnimating()
    }

}
