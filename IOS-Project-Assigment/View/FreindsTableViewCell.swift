

import UIKit
import Kingfisher

class FreindsTableViewCell: UITableViewCell {

  
    @IBOutlet weak var FreindImage: UIImageView!
    @IBOutlet weak var Freindname: UILabel!
    @IBOutlet weak var Freindcity: UILabel!
    
    
        func setFriends(friend : Freinds){
        let url = URL(string:friend.profileImageURL)
        FreindImage.kf.indicatorType = .activity
        let processor = RoundCornerImageProcessor(cornerRadius: 20)
        FreindImage.kf.setImage(with: url , options:[.processor(processor)])
        Freindname.text = friend.firstName
        Freindcity.text = friend.city



}
}
