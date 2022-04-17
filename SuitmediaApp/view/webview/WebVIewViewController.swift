//
//  WebVIewViewController.swift
//  SuitmediaApp
//
//  Created by Gilang Ramdhani Putra on 17/04/22.
//

import UIKit
import WebKit

class WebVIewViewController: UIViewController {
    
    @IBOutlet weak var webView: WKWebView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let url = URL (string: "https://suitmedia.com/")
        let requestObj = URLRequest(url: url!)
        webView.scrollView.showsHorizontalScrollIndicator = false
        webView.load(requestObj)
        
    }

    @IBAction func backButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
}
