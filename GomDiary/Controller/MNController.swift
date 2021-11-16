//
//  MNController.swift
//  GomDiary
//
//  Created by 최준혁 on 03/02/2019.
//  Copyright © 2019 pirates. All rights reserved.
//

import UIKit

class MNController:UIViewController{
    
    @IBOutlet weak var nameInput: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferences = UserDefaults.standard
        nameInput.text = preferences.string(forKey: "name")
        
    }
    
    @IBAction func complete(_ sender: Any) {
        
        if(nameInput.text != nil){
            
            let preferences = UserDefaults.standard
            preferences.set(nameInput.text, forKey: "name")
            preferences.synchronize()
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainController")
            self.present(newViewController, animated: true, completion: nil)
            
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
