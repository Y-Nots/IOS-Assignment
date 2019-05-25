

import Foundation
class Freinds{
    
    //Declare Variables
    var firstName:String = ""
    var lastName:String = ""
    var profileImageURL:String = ""
    var phoneNumber:[String] = []
    var fbProfileURL:String = ""
    var city:String = ""
    
    
    //Init variables with params
    init(firstName:String,lastName:String,profileImageURL:String,phoneNumber:[String],fbProfileURL:String,city:String) {
        self.firstName = firstName
        self.lastName = lastName
        self.profileImageURL = profileImageURL
        self.phoneNumber = phoneNumber
        self.fbProfileURL = fbProfileURL
        self.city = city
    }
    
}
