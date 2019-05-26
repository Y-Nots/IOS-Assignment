

import UIKit
import Kingfisher

class FriendDetailViewController: UIViewController {
    
    var Frienddetails: Freinds?

    override func viewDidLoad() {
        super.viewDidLoad()
      self.loadData()
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var Freindprofileimage: UIImageView!
    @IBOutlet weak var profName: UILabel!
    @IBOutlet weak var frndcity: UILabel!
    @IBOutlet weak var frndphnumber: UILabel!
    @IBOutlet weak var frndfburl: UILabel!
    
    

 
    @IBAction func backtohome(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    //LoadData to controllers
    func loadData(){
        
        print(Frienddetails!.firstName)
        let url = URL(string:(self.Frienddetails?.profileImageURL)!)
        Freindprofileimage.kf.indicatorType = .activity
       let processor = RoundCornerImageProcessor(cornerRadius: 20)
        Freindprofileimage.kf.setImage(with: url, options:[.processor(processor)])

        
        
        profName.text = self.Frienddetails!.firstName
        frndcity.text = self.Frienddetails!.city
        frndphnumber.text = self.Frienddetails!.phoneNumber[0]
        frndfburl.text = self.Frienddetails!.fbProfileURL
    }

}
