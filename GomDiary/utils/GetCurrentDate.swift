//
//  GetCurrentDate.swift
//  GomDiary
//
//  Created by 최준혁 on 05/02/2019.
//  Copyright © 2019 pirates. All rights reserved.
//

import Foundation

class GetCurrentDate{
    
    public static func getCurrentDate() -> String{
        
        var currentDate:String?
        
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy.MM.dd"
        formatter.timeZone = TimeZone(abbreviation: "GMT+9:00")
        currentDate = formatter.string(from: date)
        
        return currentDate!
        
    }
    
}
