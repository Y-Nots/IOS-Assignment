//
//  FreindsTableViewCell.swift
//  IOS-Project-Assigment
//
//  Created by kevin shayn on 5/24/19.
//  Copyright © 2019 Robert Canton. All rights reserved.
//

import UIKit
import Kingfisher

class FreindsTableViewCell: UITableViewCell {

//    @IBOutlet weak var profileImage: UIImageView!
//    @IBOutlet weak var profileName: UILabel!
//    @IBOutlet weak var profileCityName: UILabel!
    
//    @IBOutlet weak var Freindname: UILabel!
//    @IBOutlet weak var FreindCity: UILabel!
  
    
    @IBOutlet weak var FreindImage: UIImageView!
    @IBOutlet weak var Freindname: UILabel!
    @IBOutlet weak var Freindcity: UILabel!
    
    
        func setFriends(friend : Freinds){
        let url = URL(string:friend.profileImageURL)
        FreindImage.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        FreindImage.kf.setImage(with: url , options:[.processor(processor)])
        Freindname.text = "\(friend.firstName) \(friend.lastName)"
        Freindcity.text = friend.city
//    }
//
    func setImage(){
        
    }

}
}
