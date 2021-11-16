//
//  EndDateController.swift
//  GomDiary
//
//  Created by 최준혁 on 03/02/2019.
//  Copyright © 2019 pirates. All rights reserved.
//

import UIKit

class EndDateController:UIViewController{
    
    @IBOutlet weak var textView: UILabel!
    
    @IBOutlet weak var endDatePicker: UITextField!
    
    var daysListArray = [String]()

    var currentDate:String?
    var endDate:String?
    var name:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let datePickerView:UIDatePicker = UIDatePicker()
        datePickerView.datePickerMode = UIDatePicker.Mode.date
        let toolBar = UIToolbar().ToolbarPiker(mySelect: #selector(EndDateController.dismissPicker))
        endDatePicker.inputAccessoryView = toolBar
        endDatePicker.inputView = datePickerView
        datePickerView.addTarget(self, action: #selector(EndDateController.datePickerValueChanged), for: UIControl.Event.valueChanged)
        datePickerView.minimumDate = Date()
        
        currentDate = GetCurrentDate.getCurrentDate()
        
        let preferences = UserDefaults.standard
        if(preferences.string(forKey: "endDate") != nil){
            
            //String EndDate To Date EndDate
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd" //Your date format
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+9:00") //Current time zone
            //according to date format your date string
            guard let convEndDate = dateFormatter.date(from: preferences.string(forKey: "endDate") ?? "0000.00.00") else {
                fatalError()
            }
            //
            
            datePickerView.date = convEndDate
            endDatePicker.text = preferences.string(forKey: "endDate")
            endDate = preferences.string(forKey: "endDate")
            
        }else{
            endDatePicker.text = currentDate
            endDate = currentDate
        }
        
        
        //EDITING TEXT
        name = preferences.string(forKey: "name")
        textView.text = name?.appending("의 전역일은?")
        
    }
    
    // Make a dateFormatter in which format you would like to display the selected date in the textfield.
    @objc func datePickerValueChanged(sender:UIDatePicker) {
        
        let dateFormatter = DateFormatter()
        
        dateFormatter.dateStyle = DateFormatter.Style.medium
        
        dateFormatter.timeStyle = DateFormatter.Style.none
        
        dateFormatter.timeZone = TimeZone(abbreviation: "GMT+9:00")
        
        endDate = dateFormatter.string(from: sender.date)
        
        endDatePicker.text = endDate
        
        let dateFormatter2 = DateFormatter()
        dateFormatter2.dateFormat = "yyyy.MM.dd"
        endDate = dateFormatter2.string(from: sender.date)
        
    }
    
    @objc func dismissPicker() {
        view.endEditing(true)
        
    }
    
    @IBAction func complete(_ sender: Any) {
        
        if(endDate != nil){
            
            //CONVERT STRING TO DATE
            let dateFormatter = DateFormatter()
            dateFormatter.dateFormat = "yyyy.MM.dd" //Your date format
            dateFormatter.timeZone = TimeZone(abbreviation: "GMT+9:00") //Current time zone
            //according to date format your date string
            guard let calStartDate = dateFormatter.date(from: currentDate ?? "0000.00.00") else {
                fatalError()
            }
            guard let calEndDate = dateFormatter.date(from: endDate ?? "0000.00.00") else {
                fatalError()
            }
            //
            
            //SET-INFORMATION
            let preferences = UserDefaults.standard
            
            preferences.set(endDate, forKey: "endDate")
            preferences.set(printCountBtnTwoDates(mStartDate: calStartDate, mEndDate: calEndDate), forKey: "leftDay")
            preferences.synchronize()
            //
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainController")
            self.present(newViewController, animated: true, completion: nil)
            
        }
        
    }
    
    func printCountBtnTwoDates(mStartDate: Date, mEndDate: Date) -> Int {
        let calendar = Calendar.current
        let formatter = DateFormatter()
        var newDate = mStartDate
        daysListArray.removeAll()
        
        while newDate <= mEndDate {
            formatter.dateFormat = "yyyy-MM-dd"
            daysListArray.append(formatter.string(from: newDate))
            newDate = calendar.date(byAdding: .day, value: 1, to: newDate)!
        }
        // print("daysListArray: \(daysListArray)") // if you want to print list between start date and end date
        return daysListArray.count - 1
    }
    
    @IBAction func naver(_ sender: Any) {
        let url = URL(string:"https://bit.ly/2t2O7hV")!
        UIApplication.shared.open(url, options: [:])
        
        if #available(iOS 10.0, *) {
            UIApplication.shared.open(url, options: [:], completionHandler: nil)
        } else {
            UIApplication.shared.openURL(url)
        }
    }
    
    @IBAction func cancel(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
