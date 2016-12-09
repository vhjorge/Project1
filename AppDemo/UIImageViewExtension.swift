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
    
    
    func DownLoadData(url: String){
        if (url.characters.count > 0){
            var request = URLRequest(url: URL(string: url)!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 5000)
            
            request.httpMethod = "GET"
            
            let session = URLSession.shared
            let task = session.dataTask(with: request, completionHandler: {data, response, error -> Void in
                guard(error == nil) else{
                    print ("Ocurrio un error con la peticion: \(error)")
                    return
                }
                
                guard let statusCode = (response as? HTTPURLResponse)?.statusCode else {
                    print ("Ocurrio un error en la respuesta: \(error)")
                    return
                }
                
                if !(statusCode >= 200 && statusCode <= 299){
                    print ("Respuesta no valida")
                    return
                }
                
                print ("Responde :\(response?.description)")
                print ("error :\(error)")
                
                self.image = UIImage.init(data: data!)
            })
            task.resume()
        }
    }
}
