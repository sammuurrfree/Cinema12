//
//  UImageExtension.swift
//  Cinema_12
//
//  Created by Преподаватель on 22.10.2021.
//

import UIKit


extension UIImage{
    
    static func imageForString(url: String, startHttp: Bool = true) -> UIImage{
        
        if startHttp{
            let image = try? Data(contentsOf: URL(string: "http://cinema.areas.su/up/images/"+url)!)
            if image == nil{
                return UIImage()
            }
            return UIImage(data: image!)!
        }
        
        
        let data = try? Data(contentsOf: URL(string: url)!)
        
        if data == nil{
            return UIImage()
        }
        return UIImage(data: data!)!
        
    }
    
    
}
