//
//  BottomSheetViewController.swift
//  SuitmediaApp
//
//  Created by Gilang Ramdhani Putra on 17/04/22.
//

import UIKit

class BottomSheetViewController: UIViewController {

    @IBOutlet weak var nameUser: UILabel!
    @IBOutlet weak var imagePicture: UIImageView!
    
    var nama : String?
    var email : String?
    var image : String?
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        
        nameUser.text = nama
        
        imagePicture.layer.masksToBounds = false
        imagePicture.layer.cornerRadius = imagePicture.frame.height/2
        imagePicture.clipsToBounds = true
        
        let config = URLSessionConfiguration.default
        let session = URLSession(configuration: config)
        if let url = NSURL(string: image!){

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

    @IBAction func buttonSelectPressed(_ sender: Any) {
        
        let dataUser:[String: String] = ["firstName": "\(nama ?? "" )", "emailUser" : "\(email ?? "" )", "imageProfile" : "\(image ?? "" )"]
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "newDataNotif"), object: nil, userInfo: dataUser)
        
        self.presentingViewController?
            .presentingViewController?.dismiss(animated: true, completion: nil)

    }
}
