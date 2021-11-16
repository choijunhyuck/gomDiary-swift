//
//  ImageController.swift
//  GomDiary
//
//  Created by 최준혁 on 10/02/2019.
//  Copyright © 2019 pirates. All rights reserved.
//

import UIKit

class ImageController:UIViewController{
    
    @IBOutlet weak var imageView: UIImageView!
    
    var base64:String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let dataDecoded : Data = Data(base64Encoded: base64!, options: .ignoreUnknownCharacters)!
        let decodedimage = UIImage(data: dataDecoded)
        imageView.image = decodedimage
        
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent
    }
    
}
