//
//  ViewController.swift
//  BoredApp
//
//  Created by Afir Thes on 11.09.2021.
//

import UIKit
import Alamofire
import SwiftyJSON

class ViewController: UIViewController {

    @IBOutlet weak var wikiLink: UILabel!
    @IBOutlet weak var activityTextView: UITextView!
    @IBOutlet weak var typeTextField: UITextField!
    @IBOutlet weak var participantsTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var accesibilityTextField: UITextField!
    
    @IBOutlet weak var findButton: UIButton!
    
    let urlString = "https://www.boredapi.com/api/activity"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        findButton.layer.cornerRadius = findButton.frame.height / 4
    

    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        
        activityTextView.layer.borderWidth = 0.5
        activityTextView.layer.cornerRadius = 5
        activityTextView.layer.borderColor = CGColor(gray: 0.25, alpha: 0.25)
        
    }

    @IBAction func doFind(_ sender: Any) {
        AF.request(urlString).responseJSON{ (response) in
            if let jsonData = response.value as? [String:Any] {
                
                self.activityTextView.text = jsonData["activity"] as? String
                self.typeTextField.text = jsonData["type"] as? String
                self.participantsTextField.text = "\(String(describing: jsonData["participants"] ?? "--"))"
                self.priceTextField.text = "\(String(describing: jsonData["price"] ?? "--"))"
                self.accesibilityTextField.text = "\(String(describing: jsonData["accessibility"] ?? "--"))"
                
                if let link = jsonData["link"] as? String {
                    if(link != "") {
                        
                        
                        let attributedString = NSMutableAttributedString(string: link)
                        attributedString.addAttribute(.link, value: link, range: NSRange(location: 0, length: link.count ))

                        self.wikiLink.attributedText = attributedString
                        
                    } else {
                        self.wikiLink.attributedText = NSMutableAttributedString(string: "[no link]")
                    }
                }
            }
        }
    }
    
}

