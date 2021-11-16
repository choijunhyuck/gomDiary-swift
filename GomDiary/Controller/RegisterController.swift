//
//  ViewController.swift
//  GomDiary
//
//  Created by 최준혁 on 31/01/2019.
//  Copyright © 2019 pirates. All rights reserved.
//

import UIKit

class RegisterController: UIViewController {
    
    @IBOutlet weak var nextBtn: UIBarButtonItem!
    
    @IBOutlet weak var cl_0: UIButton!
    @IBOutlet weak var cl_1: UIButton!
    @IBOutlet weak var cl_2: UIButton!
    @IBOutlet weak var cl_3: UIButton!
    @IBOutlet weak var cl_4: UIButton!
    @IBOutlet weak var cl_5: UIButton!
    @IBOutlet weak var cl_6: UIButton!
    @IBOutlet weak var cl_7: UIButton!
    
    var company = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        let preferences = UserDefaults.standard
        if(preferences.string(forKey: "name") != nil){
            
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let controller = storyboard.instantiateViewController(withIdentifier: "MainController")
            self.present(controller, animated: true, completion: nil)
        }
        
    }

    @IBAction func btn1Tapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "main_asset_radio_unchecked"){
            
            sender.setImage(UIImage(named: "main_asset_radio_checked"), for: .normal)
            
            company = 0
            
            cl_1.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_2.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_3.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_4.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_5.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_6.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_7.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            nextBtn.isEnabled = true
            
        }else{
            
            sender.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            company = -1
            nextBtn.isEnabled = false
            
        }
    }
    
    @IBAction func btn2Tapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "main_asset_radio_unchecked"){
            
            sender.setImage(UIImage(named: "main_asset_radio_checked"), for: .normal)
       
            company = 1
            
            cl_0.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_2.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_3.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_4.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_5.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_6.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_7.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            nextBtn.isEnabled = true
            
        }else{
            
            sender.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            company = -1
            nextBtn.isEnabled = false
            
        }
    }
    
    @IBAction func btn3Tapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "main_asset_radio_unchecked"){
            
            sender.setImage(UIImage(named: "main_asset_radio_checked"), for: .normal)
            
            company = 2
            
            cl_0.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_1.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_3.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_4.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_5.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_6.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_7.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            nextBtn.isEnabled = true
            
        }else{
            
            sender.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            company = -1
            nextBtn.isEnabled = false
            
        }
    }
    
    @IBAction func btn4Tapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "main_asset_radio_unchecked"){
            
            sender.setImage(UIImage(named: "main_asset_radio_checked"), for: .normal)
            
            company = 3
            
            cl_0.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_1.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_2.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_4.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_5.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_6.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_7.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            nextBtn.isEnabled = true
            
        }else{
            
            sender.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            company = -1
            nextBtn.isEnabled = false
            
        }
    }
    
    @IBAction func btn5Tapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "main_asset_radio_unchecked"){
            
            sender.setImage(UIImage(named: "main_asset_radio_checked"), for: .normal)
            
            company = 4
            
            cl_0.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_1.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_2.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_3.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_5.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_6.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_7.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            nextBtn.isEnabled = true
            
        }else{
            
            sender.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            company = -1
            nextBtn.isEnabled = false
            
        }
    }
    
    @IBAction func btn6Tapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "main_asset_radio_unchecked"){
            
            sender.setImage(UIImage(named: "main_asset_radio_checked"), for: .normal)
            
            company = 5
            
            cl_0.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_1.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_2.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_3.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_4.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_6.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_7.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            nextBtn.isEnabled = true
            
        }else{
            
            sender.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            company = -1
            nextBtn.isEnabled = false
            
        }
    }
    
    @IBAction func btn7Tapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "main_asset_radio_unchecked"){
            
            sender.setImage(UIImage(named: "main_asset_radio_checked"), for: .normal)
            
            company = 6
            
            cl_0.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_1.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_2.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_3.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_4.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_5.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_7.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            nextBtn.isEnabled = true
            
        }else{
            
            sender.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            company = -1
            nextBtn.isEnabled = false
            
        }
    }
    
    @IBAction func btn8Tapped(_ sender: UIButton) {
        
        if sender.currentImage == UIImage(named: "main_asset_radio_unchecked"){
            
            sender.setImage(UIImage(named: "main_asset_radio_checked"), for: .normal)
            
            company = 7
            
            cl_0.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_1.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_2.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_3.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_4.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_5.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            cl_6.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            nextBtn.isEnabled = true
            
        }else{
            
            sender.setImage(UIImage(named: "main_asset_radio_unchecked"), for: .normal)
            
            company = -1
            nextBtn.isEnabled = false
            
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is Register2Controller
        {
            let vc = segue.destination as? Register2Controller
            vc?.company = company
        }
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}

