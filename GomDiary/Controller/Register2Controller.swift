//
//  View2Controller.swift
//  GomDiary
//
//  Created by 최준혁 on 01/02/2019.
//  Copyright © 2019 pirates. All rights reserved.
//

import UIKit

extension UIToolbar {
    
    func ToolbarPiker(mySelect : Selector) -> UIToolbar {
        
        let toolBar = UIToolbar()
        
        toolBar.barStyle = UIBarStyle.default
        toolBar.isTranslucent = true
        toolBar.tintColor = UIColor.black
        toolBar.sizeToFit()
        
        let doneButton = UIBarButtonItem(title: "Done", style: UIBarButtonItem.Style.plain, target: self, action: mySelect)
        let spaceButton = UIBarButtonItem(barButtonSystemItem: UIBarButtonItem.SystemItem.flexibleSpace, target: nil, action: nil)
        
        toolBar.setItems([ spaceButton, doneButton], animated: false)
        toolBar.isUserInteractionEnabled = true
        
        return toolBar
    }
    
}

class Register2Controller:UIViewController{
    
    @IBOutlet weak var startDatePicker: UITextField!
    
    @IBOutlet weak var nameInput: UITextField!
    
    var startDate:String?
    var currentDate:String?
    
    var company = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(Register2Controller.dismissPicker))
        startDatePicker.inputAccessoryView = toolBar
        startDatePicker.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(Register2Controller.datePickerValueChanged), for: UIControl.Event.valueChanged)
        datePickerView.maximumDate = Date()
        
        currentDate = GetCurrentDate.getCurrentDate()
        startDatePicker.text = currentDate
        
        startDate = currentDate
        
    }
    
    // Make a dateFormatter in which format you would like to display the selected date in the textfield.
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+9:00")
        
        startDate = dateFormatter.string(from: sender.date)
        
        startDatePicker.text = startDate
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy.MM.dd"
        startDate = dateFormatter2.string(from: sender.date)
        
    }
    
    @objc func dismissPicker() {
        
        view.endEditing(true)
        
    }
    
    
    @IBAction func complete(_ sender: Any) {
        
        if(startDate != nil && nameInput.text != nil){
            
            let preferences = UserDefaults.standard
            preferences.set(company, forKey: "company")
            preferences.set(startDate, forKey: "startDate")
            preferences.set(currentDate, forKey: "currentDate")
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
