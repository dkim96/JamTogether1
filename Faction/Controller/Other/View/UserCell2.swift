

import UIKit
import Firebase

class UserCell2: UITableViewCell {
    
    var seconds = Int()
    
    
    var message: Message? {
        didSet {
            setupNameAndProfileImage()
            
            detailTextLabel?.text = message?.text
            
            if let seconds = message?.timestamp?.doubleValue {
                let timestampDate = Date(timeIntervalSince1970: seconds)
                
                let dateFormatter = DateFormatter()
                dateFormatter.dateFormat = "hh:mm:ss a"
                timeLabel.text = dateFormatter.string(from: timestampDate)
            }
            
            
        }
    }
    
    fileprivate func setupNameAndProfileImage() {
        
        if let id = message?.chatPartnerId() {
            let ref = FIRDatabase.database().reference().child("faction").child(id)
            ref.observeSingleEvent(of: .value, with: { (snapshot) in
                
                if let dictionary = snapshot.value as? [String: AnyObject] {
                    self.textLabel?.text = dictionary["groupName"] as? String
                    
                    self.seconds = (dictionary["timestamp"] as? Int)!
                    let timestampDate = Date(timeIntervalSince1970: TimeInterval(self.seconds))
                    
                    let dateFormatter = DateFormatter()
                    dateFormatter.dateFormat = "hh:mm:ss a"
                    self.timeLabel.text = dateFormatter.string(from: timestampDate)
                    print(self.timeLabel.text)
                    
                    if let profileImageUrl = dictionary["profileImageUrl"] as? String {
                        self.profileImageView.loadImageUsingCacheWithUrlString(profileImageUrl)
                    }
                }
                
            }, withCancel: nil)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        textLabel?.frame = CGRect(x: 64, y: textLabel!.frame.origin.y - 2, width: textLabel!.frame.width, height: textLabel!.frame.height)
        
        detailTextLabel?.frame = CGRect(x: 64, y: detailTextLabel!.frame.origin.y + 2, width: detailTextLabel!.frame.width, height: detailTextLabel!.frame.height)
    }
    
    let profileImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "avat")
        imageView.layer.cornerRadius = 40
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    let timeLabel: UILabel = {
        let label = UILabel()
        label.text = "HH:MM:SS"
        label.font = UIFont(name: "Raleway-Medium", size: 13)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let distanceLabel: UILabel = {
        let label = UILabel()
        label.text = "-1"
        label.font = UIFont(name: "Raleway-Medium", size: 13)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let mainLabel: UILabel = {
        let label = UILabel()
        label.text = "Guitar: Kanye"
        label.font = UIFont.boldSystemFont(ofSize: 20)
        label.font = UIFont(name: "Raleway-ExtraBold", size: 18)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    let typeLabel: UILabel = {
        let label = UILabel()
        label.text = "Skill Level: 5"
        label.font = UIFont(name: "Raleway-Medium", size: 13)
        label.textColor = UIColor.black
        label.translatesAutoresizingMaskIntoConstraints = false
        return label
    }()
    
    
    let photoImageView: UIImageView = {
        let imageView = UIImageView()
        imageView.translatesAutoresizingMaskIntoConstraints = false
        imageView.image = UIImage(named: "bluebg")
        imageView.layer.cornerRadius = 24
        imageView.layer.masksToBounds = true
        imageView.contentMode = .scaleAspectFill
        return imageView
    }()
    
    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
            super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
            // editing for jamtogether
            addSubview(photoImageView) // blue background overlay
            addSubview(profileImageView) // creator profile img on top right
            //addSubview(timeLabel) // showing the time
            //addSubview(distanceLabel) // X
            addSubview(mainLabel) // instrument + name
            addSubview(typeLabel) // skill level

            photoImageView.layer.zPosition = 0
            
            //ios 9 constraint anchors
            //need x,y,width,height anchors
            
        photoImageView.centerXAnchor.constraint(equalTo: self.centerXAnchor).isActive = true
            photoImageView.topAnchor.constraint(equalTo: self.topAnchor, constant: 0).isActive = true
            //photoImageView.widthAnchor.constraint(equalToConstant: 505).isActive = true
            //photoImageView.heightAnchor.constraint(equalToConstant: 125).isActive = true
        
        mainLabel.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 55).isActive = true
        mainLabel.topAnchor.constraint(equalTo: self.topAnchor, constant: 20).isActive = true
        
            profileImageView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 50).isActive = true
            profileImageView.topAnchor.constraint(equalTo: mainLabel.bottomAnchor, constant: 5).isActive = true
            profileImageView.widthAnchor.constraint(equalToConstant: 80).isActive = true
            profileImageView.heightAnchor.constraint(equalToConstant: 80).isActive = true
        
            //mainLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
            //mainLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
            
        typeLabel.leftAnchor.constraint(equalTo: profileImageView.rightAnchor, constant: 15).isActive = true
            typeLabel.topAnchor.constraint(equalTo: profileImageView.topAnchor, constant: 10).isActive = true
            //typeLabel.widthAnchor.constraint(equalToConstant: 200).isActive = true
            //typeLabel.heightAnchor.constraint(equalTo: (textLabel?.heightAnchor)!).isActive = true
            

            
        }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

