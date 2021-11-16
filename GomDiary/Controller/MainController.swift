//
//  View3Controller.swift
//  GomDiary
//
//  Created by 최준혁 on 03/02/2019.
//  Copyright © 2019 pirates. All rights reserved.
//

import UIKit

extension MainController:  UIImagePickerControllerDelegate, UINavigationControllerDelegate{
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let selectedImage = info[.editedImage] as? UIImage else {
            print("Error: \(info)")
            return
        }
        
        // do your thing...
        self.ppView.image = selectedImage
        
        //Now use image to create into NSData format
        let imageData:NSData = selectedImage.pngData()! as NSData
        /*back
         let image = UIImage(data:imageData)
         */
        
        let base64 = imageData.base64EncodedString(options: NSData.Base64EncodingOptions(rawValue: 0))
        
        let preferences = UserDefaults.standard
        preferences.set(base64, forKey: "pp")
        preferences.synchronize()
        
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.isNavigationBarHidden = false
        self.dismiss(animated: true, completion: nil)
    }
}

class MainController:UIViewController, UICollectionViewDataSource,
UICollectionViewDelegate, UICollectionViewDelegateFlowLayout {
    
    var list:[MyStruct] = [MyStruct]()
    
    struct MyStruct
    {
        
        var cellDate = ""
        var background = ""
        
        init(_ data1:String, _ data2:String)
        {
            
            self.cellDate = data1
            self.background = data2
            
        }
    }
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    @IBOutlet weak var companyView: UILabel!
    
    @IBOutlet weak var nameView: UIButton!
    
    @IBOutlet weak var ppView: UIImageView!
    
    @IBOutlet weak var dayView: UIButton!
    
    @IBOutlet weak var foldButton: UIButton!
    
    @IBOutlet weak var foldView: UIView!
    
    var LEFT_DAY_EXIST = 0
    
    var startDate:String?
    var endDate:String?
    
    var IS_FOLDED = 0
    
    var imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //SET WIDGET
        let preferences = UserDefaults.standard
        
        switch preferences.integer(forKey: "company") {
        case 0:
            companyView.text = "육군"
        case 1:
            companyView.text = "의무경찰"
        case 2:
            companyView.text = "해병"
        case 3:
            companyView.text = "해군"
        case 4:
            companyView.text = "해양의무경찰"
        case 5:
            companyView.text = "공군"
        case 6:
            companyView.text = "사회복무요원"
        case 7:
            companyView.text = "의무소방"
        default:
            print("오류가 발생했습니다!")
        }
        
        nameView.setTitle(preferences.string(forKey: "name"), for: .normal)
        
        /*PP SETTING*/
        let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(imageTapped(tapGestureRecognizer:)))
        ppView.isUserInteractionEnabled = true
        ppView.addGestureRecognizer(tapGestureRecognizer)
        
        ppView.layer.cornerRadius = 8.0
        ppView.clipsToBounds = true
        
        if(preferences.string(forKey: "pp") != nil){
            let dataDecoded : Data = Data(base64Encoded: preferences.string(forKey: "pp")!, options: .ignoreUnknownCharacters)!
            let decodedimage = UIImage(data: dataDecoded)
            ppView.image = decodedimage
        }
        
        /*isEND-DATEexist?*/
        if(preferences.string(forKey: "leftDay") != nil){
            LEFT_DAY_EXIST = 1
            dayView.setTitle(preferences.string(forKey: "leftDay"), for: .normal)
        }
        
        //COLLECTIONVIEW SETTINGS
        self.collectionView.dataSource = self
        self.collectionView.delegate = self
        
        let layout = UICollectionViewFlowLayout()
        layout.sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
        layout.minimumLineSpacing = 10
        layout.minimumInteritemSpacing = 10
        
        collectionView.collectionViewLayout = layout
        
        //DAY CHANGED CHECK
        alarmClock()
        
        //GET DATA (COLLECTIONVIEW)
        guard let documentDirectoryUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first else { return }
        extractDate(atPath: documentDirectoryUrl)
        
    }
    
    func extractDate(atPath: URL){
        
        let keys = [URLResourceKey.contentModificationDateKey]
        
        guard let fullPaths = try? FileManager.default.contentsOfDirectory(at: atPath, includingPropertiesForKeys:keys, options: FileManager.DirectoryEnumerationOptions.skipsHiddenFiles) else {
            fatalError("error : 1")
        }
        
        let orderedFullPaths = fullPaths.sorted(by: { (url1: URL, url2: URL) -> Bool in
            do {
                let values1 = try url1.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                let values2 = try url2.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                
                if let date1 = values1.creationDate, let date2 = values2.creationDate {
                    //if let date1 = values1.contentModificationDate, let date2 = values2.contentModificationDate {
                    return date1.compare(date2) == ComparisonResult.orderedAscending
                }
            } catch _{
                fatalError("error : 2")
            }
            return true
        })
        
        //GET ALL FILELIST
        for fileName in orderedFullPaths {
            do {
                let values = try fileName.resourceValues(forKeys: [.creationDateKey, .contentModificationDateKey])
                if let _ = values.creationDate{
                    let theFileName = fileName.lastPathComponent
                    let cellDate = String(theFileName.characters.dropLast(5))
                    //NEXT STEP
                    retrieveFromJsonFile(fileName:cellDate)
                    print("......")
                    print(cellDate)
                }
            }
            catch _{
                fatalError("error : 3")
            }
        }
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
            list.append(MyStruct(fileName, Array["background"] ?? "1"))
            
        } catch {
            print(error)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int
    {
        return list.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath)
        -> UICollectionViewCell
    {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "CustomCell", for: indexPath)
            as! CustomCell
        cell.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(tap(_:))))
        
        //feed screen corner radius
        cell.layer.cornerRadius = 3
        
        /*list[indexPath.row].other_data*/
        print("...........")
        print(list[indexPath.row].cellDate)
        print(list[indexPath.row].background)
        /*cell.nameText.text = list[indexPath.row].name*/
        
        // background
        switch Int(list[indexPath.row].background) {
        case 1:
            cell.background.image = UIImage(named: "palett_1_hd")
            break;
        case 2:
            cell.background.image = UIImage(named: "palett_2_hd")
            break;
        case 3:
            cell.background.image = UIImage(named: "palett_3_hd")
            break;
        case 4:
            cell.background.image = UIImage(named: "palett_4_hd")
            break;
        case 5:
            cell.background.image = UIImage(named: "palett_5_hd")
            break;
        case 6:
            cell.background.image = UIImage(named: "palett_6_hd")
            break;
        case 7:
            cell.background.image = UIImage(named: "palett_7_hd")
            break;
        case 8:
            cell.background.image = UIImage(named: "palett_8_hd")
            break;
        case 9:
            cell.background.image = UIImage(named: "palett_9_hd")
            break;
        case 10:
            cell.background.image = UIImage(named: "palett_10_hd")
            break;
        case 11:
            cell.background.image = UIImage(named: "palett_11_hd")
            break;
        case 12:
            cell.background.image = UIImage(named: "palett_12_hd")
            break;
        default:
            print("have no value - background")
            break;
        }
        
        //dateBackground
        if(indexPath.row != 0){
            let compare1 = String(list[indexPath.row-1].cellDate).characters.dropLast(3)
            let compare2 = String(list[indexPath.row].cellDate).characters.dropLast(3)
            
            if(String(compare1) != String(compare2)){
                
                cell.dateBackground.isHidden = false
                //dateView
                cell.dateView.text = String(String(list[indexPath.row].cellDate).characters.dropLast(3))
                
            }
        }else{
            cell.dateBackground.isHidden = false
            //dateView
            cell.dateView.text = String(String(list[indexPath.row].cellDate).characters.dropLast(3))
        }
        
        //dayView
        cell.dayView.text = String(String(list[indexPath.row].cellDate).characters.dropFirst(8))
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout:
        UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize
    {
        return itemSize
    }
    
    /*CALCULATE SPACE FUNC START*/
    private let numberOfItemPerRow = 6
    
    private let screenWidth = UIScreen.main.bounds.width
    private let sectionInset = UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    private let minimumInteritemSpacing = CGFloat(10)
    private let minimumLineSpacing = CGFloat(10)
    
    // Calculate the item size based on the configuration above
    private var itemSize: CGSize {
        let interitemSpacesCount = numberOfItemPerRow - 1
        let interitemSpacingPerRow = minimumInteritemSpacing * CGFloat(interitemSpacesCount)
        let rowContentWidth = screenWidth - sectionInset.right - sectionInset.left - interitemSpacingPerRow
        
        let width = rowContentWidth / CGFloat(numberOfItemPerRow)
        let height = width // feel free to change the height to whatever you want
        
        return CGSize(width: width, height: height)
    }
    /*CALCULATE SPACE FUNC END*/
    
    
    /*COLLECTIONVIEW CELL CLICK LISTENER*/
    @objc func tap(_ sender: UITapGestureRecognizer) {
        
        let location = sender.location(in: self.collectionView)
        let indexPath = self.collectionView.indexPathForItem(at: location)
        
        if let index = indexPath {
            print("Got clicked on index: \(list[index.row].cellDate)!")
            
            let preferences = UserDefaults.standard
            preferences.set(list[index.row].cellDate, forKey: "clickedDate")
            preferences.synchronize()
            
            let storyBoard: UIStoryboard = UIStoryboard(name: "Rdiary", bundle: nil)
            let newViewController = storyBoard.instantiateViewController(withIdentifier: "RDController")
            self.present(newViewController, animated: true, completion: nil)
            
        }
    }
    /*COLLECTIONVIEW CELL CLICK LISTENER END*/
    
    func alarmClock(){
        
        let preferences = UserDefaults.standard
        
        if(GetCurrentDate.getCurrentDate() != preferences.string(forKey: "currentDate")){
            
            //REFRESH STANDARD DATE
            preferences.set(GetCurrentDate.getCurrentDate(), forKey: "currentDate")
            preferences.synchronize()
            
            switch(LEFT_DAY_EXIST){
                
            case 0:
                print("have no left day")
                if(preferences.string(forKey: "titleCache") != nil){
                    //delete cache
                    preferences.removeObject(forKey: "titleCache")
                    preferences.removeObject(forKey: "diaryCache")
                    preferences.removeObject(forKey: "imageCache")
                    preferences.removeObject(forKey: "backgroundCache")
                    preferences.synchronize()
                }
                break;
                
            case 1:
                
                let leftDay = preferences.integer(forKey: "leftDay")
                preferences.set(leftDay - 1, forKey: "leftDay")
                preferences.synchronize()
                
                dayView.setTitle(preferences.string(forKey: "leftDay"), for: .normal)
                
                if(preferences.string(forKey: "titleCache") != nil){
                    //delete cache
                    preferences.removeObject(forKey: "titleCache")
                    preferences.removeObject(forKey: "diaryCache")
                    preferences.removeObject(forKey: "imageCache")
                    preferences.removeObject(forKey: "backgroundCache")
                    preferences.synchronize()
                }
                
                break;
                
            default:
                break;
                
            }
            
        }
        
    }
    
    @objc func imageTapped(tapGestureRecognizer: UITapGestureRecognizer)
    {
        let tappedImage = tapGestureRecognizer.view as! UIImageView
        
        let alert = UIAlertController(title: "사진 선택", message: nil, preferredStyle: .actionSheet)
        alert.addAction(UIAlertAction(title: "카메라", style: .default, handler: { _ in
            self.openCamera()
        }))
        
        alert.addAction(UIAlertAction(title: "갤러리", style: .default, handler: { _ in
            self.openGallary()
        }))
        
        alert.addAction(UIAlertAction.init(title: "취소", style: .cancel, handler: { _ in
            
        }))
        
        self.present(alert, animated: true, completion: nil)
        
    }
    
    func openCamera()
    {
        if(UIImagePickerController .isSourceTypeAvailable(UIImagePickerController.SourceType.camera))
        {
            imagePicker.delegate = self
            imagePicker.sourceType = UIImagePickerController.SourceType.camera
            imagePicker.allowsEditing = true
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
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    @IBAction func foldOption(_ sender: Any) {
        
        if(IS_FOLDED == 0){
            
            IS_FOLDED = 1
            foldButton.setImage(UIImage(named: "main_asset_unfolded.png"), for: .normal)
            foldView.isHidden = false
            
        }else{
            
            IS_FOLDED = 0
            foldButton.setImage(UIImage(named: "main_asset_folded.png"), for: .normal)
            foldView.isHidden = true
            
        }
        
    }
    
    func refresh_now()
    {
        DispatchQueue.main.async (
            execute:
            {
                self.collectionView.reloadData()
        }
        )
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        if(IS_FOLDED == 1){
            IS_FOLDED = 0
            foldButton.setImage(UIImage(named: "main_asset_folded.png"), for: .normal)
            foldView.isHidden = true
        }

    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
