//
//  UIImageViewExtension.swift
//  AppDemo
//
//  Created by AdminUTMVHSA on 07/12/16.
//  Copyright © 2016 AdminUTMVHSA. All rights reserved.
//

import Foundation
import UIKit

extension UIImageView{
    func LoadImageUrl(url: String){
        if url.characters.count < 7{
            return
        }
        
        do{
            let dato = try Data(contentsOf: URL(string : url)!)
            self.image = UIImage(data: dato)
        }
        catch{
            print("Error\(error)")
        }
    }
}
