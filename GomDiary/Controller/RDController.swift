//
//  RDController.swift
//  GomDiary
//
//  Created by 최준혁 on 10/02/2019.
//  Copyright © 2019 pirates. All rights reserved.
//

import UIKit

class RDController:UIViewController{
   
    @IBOutlet weak var dateView: UILabel!
    
    @IBOutlet weak var titleView: UILabel!
    
    @IBOutlet weak var diaryView: UITextView!
    
    @IBOutlet weak var attatchedPictureView: UIButton!
    
    var cellDate:String?
    var background:Int?
    var image:String?
    
    var titleSend:String?
    var diarySend:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let preferences = UserDefaults.standard
        
        cellDate = preferences.string(forKey: "clickedDate")
        
        retrieveFromJsonFile(fileName: cellDate!)
        
    }
    
    func retrieveFromJsonFile(fileName:String) {
        // Get the url of Persons.json in document directory
        guard let documentsDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentsDirectoryUrl.appendingPathComponent("\(fileName).json")
        
        // Read data from .json file and transform data into an array
        do {
            let data = try Data(contentsOf: fileUrl, options: [])
            guard let Array = try JSONSerialization.jsonObject(with: data, options: []) as? [String:String] else
            { return }
            
            titleSend = Array["title"]
            diarySend = Array["diary"]
            
            dateView.text = fileName
            titleView.text = Array["title"]
            diaryView.text = Array["diary"]
            background = Int(Array["background"]!)
            image = Array["image"]
            
            setPalett(parameter: background!)
            
            if(image != "none"){
                attatchedPictureView.isHidden = false
            }
            
        } catch {
            print(error)
        }
    }
    
    func setPalett(parameter : Int){
        
        switch parameter {
        case 1:
            self.view.backgroundColor = UIColor.rgb(red: 102, green: 153, blue: 204)
            break;
        case 2:
            self.view.backgroundColor = UIColor.rgb(red: 237, green: 180, blue: 98)
            break;
        case 3:
            self.view.backgroundColor = UIColor.rgb(red: 224, green: 229, blue: 174)
            break;
        case 4:
            self.view.backgroundColor = UIColor.rgb(red: 122, green: 234, blue: 143)
            break;
        case 5:
            self.view.backgroundColor = UIColor.rgb(red: 185, green: 92, blue: 224)
            break;
        case 6:
            self.view.backgroundColor = UIColor.rgb(red: 47, green: 199, blue: 211)
            break;
        case 7:
            self.view.backgroundColor = UIColor.rgb(red: 137, green: 33, blue: 44)
            break;
        case 8:
            self.view.backgroundColor = UIColor.rgb(red: 48, green: 48, blue: 48)
            break;
        case 9:
            self.view.backgroundColor = UIColor.rgb(red: 65, green: 106, blue: 239)
            break;
        case 10:
            self.view.backgroundColor = UIColor.rgb(red: 70, green: 70, blue: 140)
            break;
        case 11:
            self.view.backgroundColor = UIColor.rgb(red: 242, green: 171, blue: 244)
            break;
        case 12:
            self.view.backgroundColor = UIColor.rgb(red: 237, green: 93, blue: 93)
            break;
        default:
            break;
        }
        
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if segue.destination is ImageController
        {
            let vc = segue.destination as? ImageController
            vc?.base64 = image
        }
        
        if segue.destination is MDController
        {
            let vc = segue.destination as? MDController
            vc?.dateSended = cellDate
            vc?.titleSended = titleSend
            vc?.diarySended = diarySend
            vc?.imageSended = image
            vc?.BACKGROUND = background
        }
        
    }
    
    @IBAction func back(_ sender: Any) {
        
        let preferences = UserDefaults.standard
        preferences.removeObject(forKey:"clickedDate")
        preferences.synchronize()
        
        let storyBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let newViewController = storyBoard.instantiateViewController(withIdentifier: "MainController")
        self.present(newViewController, animated: true, completion: nil)
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
