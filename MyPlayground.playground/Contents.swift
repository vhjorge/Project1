//: Playground - noun: a place where people can play

import UIKit
import AFNetworking
import FBSDKLoginKit

var str = "Hello, playground"


extension String
{
    func reversa()-> String{
        print("reversando")
        return ("Hola")
    }
    
    func IntValue () -> Int{
        return Int(self)!
    }
    
    func Validar() -> Bool{
        return self.characters.first == "A"
    }
}

extension Int{
    
    func Cuadrado() -> Int{
        return self * self
    }
}

let x = nil ?? 6


5.Cuadrado()
9.Cuadrado()
"Jorge".Validar()


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

/*
let dato : Data?
do{
    let idfacebook = FBSDKAccessToken.current().userID
    let url = URL(string: "http://graph.facebook.com/\(idfacebook!)/picture?type=large")
    dato = try Data(contentsOf: url!)
    //vista.imgView.image = UIImage(data: dato!)
}
catch{
    print("error cargando imagen")
    dato = nil
    //vista.imgView.image = UIImage (named: "dog" )
    
}
*/
