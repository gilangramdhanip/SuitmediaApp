//
//  ViewController.swift
//  SuitmediaApp
//
//  Created by Gilang Ramdhani Putra on 17/04/22.
//

import UIKit

class ViewController: UIViewController {

    @IBOutlet weak var name: UITextField!
    @IBOutlet weak var palindromTextField: UITextField!
    
    @IBOutlet weak var btnCheck: UIButton!
    @IBOutlet weak var btnNext: UIButton!
    
    var palindromText : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
    }
    
    @IBAction func checkisPalindrome(_ sender: Any) {
        palindromText = palindromTextField.text
        
        if palindromTextField.text == "" {
            showAlert(title: "Alert", message: "Ups, Palindrome Field can't empty")
        }else {
            isPalindrome(myString: palindromText!)

        }
    }
    
    @IBAction func goToHomePage(_ sender: Any) {
        if name.text == "" {
            showAlert(title: "Alert", message: "Ups, Name Field can't empty")
        }
        else if palindromTextField.text == "" {
            showAlert(title: "Alert", message: "Ups, Palindrome Field can't empty")
        }else {
            let storyboard: UIStoryboard = UIStoryboard(name: "Home", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "homePage") as! HomeScreenViewController
            vc.modalPresentationStyle = .fullScreen
            vc.name = name.text
            self.present(vc, animated: true, completion: nil)
        }
    }
    
    
    
    func isPalindrome(myString:String){
        let reverseString = String(myString.lowercased().reversed())
        if(myString != "" && myString.lowercased() == reverseString) {
            showAlert(title: "Check", message: "is Palindrome")
        } else {
            showAlert(title: "Check", message: "Not Palindrome")
        }
    }
    
    func showAlert(title : String, message : String){
        var alert = UIAlertController()

        alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        self.present(alert, animated: true, completion: nil)
        
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertAction.Style.default, handler: nil))
    }

    
}

