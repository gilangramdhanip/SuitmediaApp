//
//  HomeScreenViewController.swift
//  SuitmediaApp
//
//  Created by Gilang Ramdhani Putra on 17/04/22.
//

import UIKit

class HomeScreenViewController: UIViewController {
    
    @IBOutlet weak var imageProfile: UIImageView!
    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var emailUser: UILabel!
    var nameUserSelected : String?
    let viewModel = UsersViewModel()
    var emailuserSelected : String?
    @IBOutlet weak var titleSelectUser: UILabel!
    var name : String?
    @IBOutlet weak var websiteBtn: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        nameLabel.text = name
        NotificationCenter.default.addObserver(self, selector: #selector(self.updateLabel), name: NSNotification.Name(rawValue: "newDataNotif"), object: nil)
    }
    
    @objc func updateLabel(notification: NSNotification) {
                            nameUser.isHidden = false
                            emailUser.isHidden = false
                            websiteBtn.isHidden = false
                            titleSelectUser.isHidden = true
        
        nameUser.text = "\(notification.userInfo?["firstName"] as? String ?? "") \(notification.userInfo?["lastName"] as? String ?? "")"
                            emailUser.text = notification.userInfo?["emailUser"] as? String
        
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let url = NSURL(string: (notification.userInfo?["imageProfile"] as? String) ?? ""){

            let task = session.dataTask(with: url as URL, completionHandler: {data, response, error in

                if let err = error {
                    print("Error: \(err)")
                    return
                }

                if let http = response as? HTTPURLResponse {
                    if http.statusCode == 200 {
                        let downloadedImage = UIImage(data: data!)
                            DispatchQueue.main.async {
                                self.imageProfile.image = downloadedImage
                            }
                    }
                }
           })
           task.resume()
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)

    }
    @IBAction func chooseUser(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Users", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "userList") as! UserListViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
    
    @IBAction func websitePressed(_ sender: Any) {
        
        let storyboard: UIStoryboard = UIStoryboard(name: "WebView", bundle: nil)
        let vc = storyboard.instantiateViewController(withIdentifier: "webViewPage") as! WebVIewViewController
        vc.modalPresentationStyle = .fullScreen
        self.present(vc, animated: true, completion: nil)
    }
}
