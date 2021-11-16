//
//  MDController.swift
//  GomDiary
//
//  Created by 최준혁 on 10/02/2019.
//  Copyright © 2019 pirates. All rights reserved.
//

import UIKit

extension MDController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.originalImage] as? UIImage else {
            print("Error: \(info)")
            return
        }
        
        // do your thing...
        attachPictureImage.setImage(UIImage(named: "wd_asset_picture_attached"), for: .normal)
        
        //Now use image to create into NSData format
        let imageData:NSData = selectedImage.pngData()! as NSData
        /*back
         let image = UIImage(data:imageData)
         */
        
        let base64 = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let preferences = UserDefaults.standard
        preferences.set(base64, forKey: "imageCache")
        preferences.synchronize()
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}

class MDController:UIViewController, UITextViewDelegate{
    
    @IBOutlet weak var dateView: UILabel!
    
    @IBOutlet weak var titleInput: UITextField!
    
    @IBOutlet weak var diaryInput: UITextView!
    
    @IBOutlet weak var textWatcher: UILabel!
    
    @IBOutlet weak var attachPictureImage: UIButton!
    
    @IBOutlet weak var palett: UIView!
    
    @IBOutlet weak var foldBtn: UIButton!
    
    var imagePicker = UIImagePickerController()
    
    var IS_FOLDED = 0
    
    var dateSended:String?
    var titleSended:String?
    var diarySended:String?
    var imageSended:String?
    var BACKGROUND:Int?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        diaryInput.delegate = self
        
        dateView.text = dateSended
        titleInput.text = titleSended
        diaryInput.text = diarySended
        textWatcher.text = "\(String(diarySended!.count)) / 480"
        
        if(imageSended != "none"){
            attachPictureImage.setImage(UIImage(named: "wd_asset_picture_attached"), for: .normal)
            
            let preferences = UserDefaults.standard
            preferences.set(imageSended, forKey: "imageCache")
            preferences.synchronize()
        }
        
        setBackground(background:BACKGROUND!)
    }
    
    func setBackground(background:Int){
            
            switch background {
            case 1:
                self.view.backgroundColor = UIColor.rgb(red: 102, green: 153, blue: 204)
                dateView.textColor = UIColor.rgb(red: 102, green: 153, blue: 204)
                titleInput.textColor = UIColor.rgb(red: 102, green: 153, blue: 204)
                textWatcher.textColor = UIColor.rgb(red: 102, green: 153, blue: 204)
                BACKGROUND = 1
                break;
            case 2:
                self.view.backgroundColor = UIColor.rgb(red: 237, green: 180, blue: 98)
                dateView.textColor = UIColor.rgb(red: 237, green: 180, blue: 98)
                titleInput.textColor = UIColor.rgb(red: 237, green: 180, blue: 98)
                textWatcher.textColor = UIColor.rgb(red: 237, green: 180, blue: 98)
                BACKGROUND = 2
                break;
            case 3:
                self.view.backgroundColor = UIColor.rgb(red: 224, green: 229, blue: 174)
                dateView.textColor = UIColor.rgb(red: 224, green: 229, blue: 174)
                titleInput.textColor = UIColor.rgb(red: 224, green: 229, blue: 174)
                textWatcher.textColor = UIColor.rgb(red: 224, green: 229, blue: 174)
                BACKGROUND = 3
                break;
            case 4:
                self.view.backgroundColor = UIColor.rgb(red: 122, green: 234, blue: 143)
                dateView.textColor = UIColor.rgb(red: 122, green: 234, blue: 143)
                titleInput.textColor = UIColor.rgb(red: 122, green: 234, blue: 143)
                textWatcher.textColor = UIColor.rgb(red: 122, green: 234, blue: 143)
                BACKGROUND = 4
                break;
            case 5:
                self.view.backgroundColor = UIColor.rgb(red: 185, green: 92, blue: 224)
                dateView.textColor = UIColor.rgb(red: 185, green: 92, blue: 224)
                titleInput.textColor = UIColor.rgb(red: 185, green: 92, blue: 224)
                textWatcher.textColor = UIColor.rgb(red: 185, green: 92, blue: 224)
                BACKGROUND = 5
                break;
            case 6:
                self.view.backgroundColor = UIColor.rgb(red: 47, green: 199, blue: 211)
                dateView.textColor = UIColor.rgb(red: 47, green: 199, blue: 211)
                titleInput.textColor = UIColor.rgb(red: 47, green: 199, blue: 211)
                textWatcher.textColor = UIColor.rgb(red: 47, green: 199, blue: 211)
                BACKGROUND = 6
                break;
            case 7:
                self.view.backgroundColor = UIColor.rgb(red: 137, green: 33, blue: 44)
                dateView.textColor = UIColor.rgb(red: 137, green: 33, blue: 44)
                titleInput.textColor = UIColor.rgb(red: 137, green: 33, blue: 44)
                textWatcher.textColor = UIColor.rgb(red: 137, green: 33, blue: 44)
                BACKGROUND = 7
                break;
            case 8:
                self.view.backgroundColor = UIColor.rgb(red: 48, green: 48, blue: 48)
                dateView.textColor = UIColor.rgb(red: 48, green: 48, blue: 48)
                titleInput.textColor = UIColor.rgb(red: 48, green: 48, blue: 48)
                textWatcher.textColor = UIColor.rgb(red: 48, green: 48, blue: 48)
                BACKGROUND = 8
                break;
            case 9:
                self.view.backgroundColor = UIColor.rgb(red: 65, green: 106, blue: 239)
                dateView.textColor = UIColor.rgb(red: 65, green: 106, blue: 239)
                titleInput.textColor = UIColor.rgb(red: 65, green: 106, blue: 239)
                textWatcher.textColor = UIColor.rgb(red: 65, green: 106, blue: 239)
                BACKGROUND = 9
                break;
            case 10:
                self.view.backgroundColor = UIColor.rgb(red: 70, green: 70, blue: 140)
                dateView.textColor = UIColor.rgb(red: 70, green: 70, blue: 140)
                titleInput.textColor = UIColor.rgb(red: 70, green: 70, blue: 140)
                textWatcher.textColor = UIColor.rgb(red: 70, green: 70, blue: 140)
                BACKGROUND = 10
                break;
            case 11:
                self.view.backgroundColor = UIColor.rgb(red: 242, green: 171, blue: 244)
                dateView.textColor = UIColor.rgb(red: 242, green: 171, blue: 244)
                titleInput.textColor = UIColor.rgb(red: 242, green: 171, blue: 244)
                textWatcher.textColor = UIColor.rgb(red: 242, green: 171, blue: 244)
                BACKGROUND = 11
                break;
            case 12:
                self.view.backgroundColor = UIColor.rgb(red: 237, green: 93, blue: 93)
                dateView.textColor = UIColor.rgb(red: 237, green: 93, blue: 93)
                titleInput.textColor = UIColor.rgb(red: 237, green: 93, blue: 93)
                textWatcher.textColor = UIColor.rgb(red: 237, green: 93, blue: 93)
                BACKGROUND = 12
                break;
            default:
                break;
            }
        
    }

    @IBAction func foldPalett(_ sender: Any) {
        
        if(IS_FOLDED == 0){
            
            IS_FOLDED = 1
            foldBtn.setImage(UIImage(named: "wd_asset_unfolded"), for: .normal)
            palett.isHidden = false
            
        }else{
            
            IS_FOLDED = 0
            foldBtn.setImage(UIImage(named: "wd_asset_folded"), for: .normal)
            palett.isHidden = true
            
        }
        
    }
    
    
    @IBAction func attachPicture(_ sender: Any) {
        
        let alert = UIAlertController(title: "사진 선택", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "갤러리", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "취소", style: .cancel, handler: { _ in
            let preferences = UserDefaults.standard
            preferences.removeObject(forKey: "imageCache")
            preferences.synchronize()
            
            self.attachPictureImage.setImage(UIImage(named: "wd_asset_picture_detached"), for: .normal)
        }))
        
        /*If you want work actionsheet on ipad
         then you have to use popoverPresentationController to present the actionsheet,
         otherwise app will crash on iPad */
        switch UIDevice.current.userInterfaceIdiom {
        case .pad:
            alert.popoverPresentationController?.sourceView = sender as? UIView
            alert.popoverPresentationController?.sourceRect = (sender as AnyObject).bounds
            alert.popoverPresentationController?.permittedArrowDirections = .up
        default:
            break
        }
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    @IBAction func complete(_ sender: Any) {
        
        if(diaryInput.text.count > 0){
            
            let preferences = UserDefaults.standard
            
            if(dateSended == preferences.string(forKey: "currentDate")){
            
            var title:String
            if(titleInput.text!.count < 1){
                preferences.set("무제", forKey: "titleCache")
                title = "무제"
            } else {
                preferences.set(titleInput.text, forKey: "titleCache")
                title = titleInput.text!
            }
            
            preferences.set(diaryInput.text, forKey: "diaryCache")
            preferences.set(BACKGROUND, forKey: "backgroundCache")
            preferences.synchronize()
            
            startDiaryAction(title:title)
            } else {
                
                var title:String
                if(titleInput.text!.count < 1){
                    preferences.set("무제", forKey: "titleCache")
                    title = "무제"
                }else{
                    title = titleInput.text!
                }
                startDiaryAction(title: title)
                
            }
            
        }
        
    }
    
    func startDiaryAction(title:String){
        
        let preferences = UserDefaults.standard
        
        //make file
        let dictionary : [String : Any] = ["title":titleInput.text,
                                           "diary":diaryInput.text,
                                           "image":preferences.string(forKey:"imageCache") ?? "none",
                                           "background":String(BACKGROUND!)
        ]
        
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        let fileUrl = documentDirectoryUrl.appendingPathComponent("\(dateSended!).json")
        
        // Transform array into data and save it into file
        do {
            let data = try JSONSerialization.data(withJSONObject: dictionary, options: [])
            try data.write(to: fileUrl, options: [])
            print("success..........(diary)")
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Rdiary", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RDController")
            self.present(newViewController, animated: true, completion: nil)
            
        } catch {
            print(error)
        }
        
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = false
            self.present(imagePicker, animated: true, completion: nil)
        }
        else
        {
            let alert  = UIAlertController(title: "Warning", message: "You don't have camera", preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func openGallary()
    {
        imagePicker.delegate = self
        imagePicker.sourceType = UIImagePickerController.SourceType.photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        
        if(text == "\n") {
            textView.resignFirstResponder()
            return false
        }
        
        let newText = (textView.text as NSString).replacingCharacters(in: range, with: text)
        let numberOfChars = newText.count // for Swift use count(newText)
        textWatcher.text = String(numberOfChars) + "/ 480"
        return numberOfChars < 480;
    }
    
    @IBAction func palett_1(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 102, green: 153, blue: 204)
        dateView.textColor = UIColor.rgb(red: 102, green: 153, blue: 204)
        titleInput.textColor = UIColor.rgb(red: 102, green: 153, blue: 204)
        textWatcher.textColor = UIColor.rgb(red: 102, green: 153, blue: 204)
        BACKGROUND = 1
    }
    
    @IBAction func palett_2(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 237, green: 180, blue: 98)
        dateView.textColor = UIColor.rgb(red: 237, green: 180, blue: 98)
        titleInput.textColor = UIColor.rgb(red: 237, green: 180, blue: 98)
        textWatcher.textColor = UIColor.rgb(red: 237, green: 180, blue: 98)
        BACKGROUND = 2
    }
    
    @IBAction func palett_3(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 224, green: 229, blue: 174)
        dateView.textColor = UIColor.rgb(red: 224, green: 229, blue: 174)
        titleInput.textColor = UIColor.rgb(red: 224, green: 229, blue: 174)
        textWatcher.textColor = UIColor.rgb(red: 224, green: 229, blue: 174)
        BACKGROUND = 3
    }
    
    @IBAction func palett_4(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 122, green: 234, blue: 143)
        dateView.textColor = UIColor.rgb(red: 122, green: 234, blue: 143)
        titleInput.textColor = UIColor.rgb(red: 122, green: 234, blue: 143)
        textWatcher.textColor = UIColor.rgb(red: 122, green: 234, blue: 143)
        BACKGROUND = 4
    }
    
    @IBAction func palett_5(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 185, green: 92, blue: 224)
        dateView.textColor = UIColor.rgb(red: 185, green: 92, blue: 224)
        titleInput.textColor = UIColor.rgb(red: 185, green: 92, blue: 224)
        textWatcher.textColor = UIColor.rgb(red: 185, green: 92, blue: 224)
        BACKGROUND = 5
    }
    
    @IBAction func palett_6(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 47, green: 199, blue: 211)
        dateView.textColor = UIColor.rgb(red: 47, green: 199, blue: 211)
        titleInput.textColor = UIColor.rgb(red: 47, green: 199, blue: 211)
        textWatcher.textColor = UIColor.rgb(red: 47, green: 199, blue: 211)
        BACKGROUND = 6
    }
    
    @IBAction func palett_7(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 137, green: 33, blue: 44)
        dateView.textColor = UIColor.rgb(red: 137, green: 33, blue: 44)
        titleInput.textColor = UIColor.rgb(red: 137, green: 33, blue: 44)
        textWatcher.textColor = UIColor.rgb(red: 137, green: 33, blue: 44)
        BACKGROUND = 7
    }
    
    @IBAction func palett_8(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 48, green: 48, blue: 48)
        dateView.textColor = UIColor.rgb(red: 48, green: 48, blue: 48)
        titleInput.textColor = UIColor.rgb(red: 48, green: 48, blue: 48)
        textWatcher.textColor = UIColor.rgb(red: 48, green: 48, blue: 48)
        BACKGROUND = 8
    }
    
    @IBAction func palett_9(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 65, green: 106, blue: 239)
        dateView.textColor = UIColor.rgb(red: 65, green: 106, blue: 239)
        titleInput.textColor = UIColor.rgb(red: 65, green: 106, blue: 239)
        textWatcher.textColor = UIColor.rgb(red: 65, green: 106, blue: 239)
        BACKGROUND = 9
    }
    
    @IBAction func palett_10(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 70, green: 70, blue: 140)
        dateView.textColor = UIColor.rgb(red: 70, green: 70, blue: 140)
        titleInput.textColor = UIColor.rgb(red: 70, green: 70, blue: 140)
        textWatcher.textColor = UIColor.rgb(red: 70, green: 70, blue: 140)
        BACKGROUND = 10
    }
    
    @IBAction func palett_11(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 242, green: 171, blue: 244)
        dateView.textColor = UIColor.rgb(red: 242, green: 171, blue: 244)
        titleInput.textColor = UIColor.rgb(red: 242, green: 171, blue: 244)
        textWatcher.textColor = UIColor.rgb(red: 242, green: 171, blue: 244)
        BACKGROUND = 11
    }
    
    @IBAction func palett_12(_ sender: Any) {
        self.view.backgroundColor = UIColor.rgb(red: 237, green: 93, blue: 93)
        dateView.textColor = UIColor.rgb(red: 237, green: 93, blue: 93)
        titleInput.textColor = UIColor.rgb(red: 237, green: 93, blue: 93)
        textWatcher.textColor = UIColor.rgb(red: 237, green: 93, blue: 93)
        BACKGROUND = 12
    }
    
}
