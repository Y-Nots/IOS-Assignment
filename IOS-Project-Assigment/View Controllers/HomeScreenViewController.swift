
import UIKit
import Firebase
import FirebaseDatabase


class HomeScreenViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {

 
    @IBOutlet weak var hometableview: UITableView!
    
    var friends: [Freinds] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        hometableview.delegate = self
        hometableview.dataSource = self
        //Check if the list is already filled
        if friends.count > 0
        {
            friends.removeAll()
        }
        else
        {
            loadFriendsData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.friends.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let friend = self.friends[indexPath.row]
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Listfreindscell" ,for: indexPath) as! FreindsTableViewCell
        
        //Set data to cellview attributes
        cell.setFriends(friend: friend)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        //tableView.deselectRow(at: indexPath, animated: true)
        performSegue(withIdentifier: "showFriendDetails", sender: self)
    }
    
//    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
//        if let destination = segue.destination as? FriendDetailViewController{
//            destination.selectedFriend = self.friends[(tableView.indexPathForSelectedRow?.row)!]
//        }
//    }
    @IBAction func Logoutscreen(_ sender: Any) {
        try! Auth.auth().signOut()
        //Open next UI
        let storyboard = UIStoryboard(name: "Main", bundle: nil)
        let controller = storyboard.instantiateViewController(withIdentifier: "Main") as! MenuViewController
        self.present(controller, animated: true, completion: nil)
        //End
    }
    
  
    

    
    
    //Load data from firebase
    func loadFriendsData(){
        //        var tempFriendList: [Friend] = []
        Database.database().reference().child("Friends").observe(.childAdded, with: {(snapshot) in
            
            if let dictionary = snapshot.value as? [String:AnyObject]{
                let firstname = dictionary["firstname"] as! String
                let lastname = dictionary["lastname"] as! String
                let Freindimageurl = dictionary["imageurl"] as! String
                let Freindphonenumber = dictionary["phonenumber"] as! String
                let Freindfaceburl = dictionary["fburl"] as! String
                let Freindcity = dictionary["city"] as! String
                
                let friend = Freinds(firstName: firstname,lastName: lastname,profileImageURL: Freindimageurl,phoneNumber: [Freindphonenumber],fbProfileURL: Freindfaceburl,city: Freindcity)
                
                self.friends.append(friend)
                DispatchQueue.main.async {
                    self.hometableview.reloadData()
                }
            }
        })
    }
    
    
    
}
