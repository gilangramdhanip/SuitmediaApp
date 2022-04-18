//
//  UsersTableViewCell.swift
//  SuitmediaApp
//
//  Created by Gilang Ramdhani Putra on 17/04/22.
//

import UIKit

class UsersTableViewCell: UITableViewCell {
    
    static let identifier = "usersCell"
    private var isCompleted : Bool = false
    
    static func nib()-> UINib {
        return UINib(nibName: "UsersTableViewCell", bundle: nil)
    }
    
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var imagePicture: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func configure(dataUsers : Data){
        nameLabel.text = "\(dataUsers.firstName) \(dataUsers.lastName)"
        emailLabel.text = dataUsers.email
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let url = NSURL(string: dataUsers.avatar){

            let task = session.dataTask(with: url as URL, completionHandler: {data, response, error in

                if let err = error {
                    print("Error: \(err)")
                    return
                }

                if let http = response as? HTTPURLResponse {
                    if http.statusCode == 200 {
                        let downloadedImage = UIImage(data: data!)
                            DispatchQueue.main.async {
                                self.imagePicture.image = downloadedImage
                            }
                    }
                }
           })
           task.resume()
        }
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
