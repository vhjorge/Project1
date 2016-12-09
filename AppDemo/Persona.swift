//
//  Persona.swift
//  AppDemo
//
//  Created by AdminUTMVHSA on 09/12/16.
//  Copyright © 2016 AdminUTMVHSA. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension Persona{
 
    
    // Define a la función como estatica
    // Retorna un Objeto NSFetchRequest
    class func fetch() -> NSFetchRequest<Persona>
    {
        return fetchRequest()
    }
    
    class func BorrarPersona(persona: Persona)
    {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        context.delete(persona)
        do{
            try context.save()
        }
        catch{
            print("Error al borrar \(persona.nombre)")
        }
        
    }
    class func BorrarPersona(nombre: String, edad: Int){
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = Persona.fetch()
        var personas = [Persona]()
        
        let predicate = NSPredicate(format: "nombre == %@ AND edad == %@",  argumentArray: [nombre,edad])
        //let predicate2 = NSPredicate(format: "edad == %ld ", edad)
        request.predicate = predicate
        
        do{
            try personas = context.fetch(request) as [Persona]
        }
        catch{
            print ("Error al borrar personas \(error)")
        }
        for d in personas{
            context.delete(d)
        }
        
        
        do{
            try context.save()
        }
        catch{
            print("Error al borrar persona \(nombre)")
        }
    }
    
    class func AgregarPersona (nombre: String, edad: Int) -> Persona?{
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        // crea un nuevo registro en la base de datos
        let individuo = Persona(context: context)
        
        individuo.nombre = nombre
        individuo.edad = Int16(edad)
        individuo.genero = ""
        individuo.foto = ""
        
        //Puede Usarser en guardado de bloque para mejora el rendimiento
        //context.insert(individuo)
        do{
            try context.save()
            return individuo
        }
        catch{
            print("Error al guardar \(nombre)")
            return nil
        }
    }
    class func agregarTodos(Datos : [Dictionary<String,Any?>]) -> Int {
        var agregados = 0
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        for d in Datos{
            let nombre = d["nombre"] as? String ?? ""
            let edad = d["edad"] as? Int ?? -1
            let genero = d["genero"] as? String ?? ""
            let foto = d["foto"] as? String ?? ""
            let id = d["id"] as? Int  ?? 1
            
            print("Agregando datos: \(nombre)")
            
        
            // crea un nuevo registro en la base de datos
            let individuo = Persona(context: context)
            
            individuo.nombre = nombre
            individuo.edad = Int16(edad)
            individuo.genero = genero
            individuo.foto = foto
            individuo.id = Int32(id)
            
            //Puede Usarser en guardado de bloque para mejora el rendimiento
            //context.insert(individuo)
            do{
                try context.save()
                agregados = agregados + 1
            }
            catch{
                print("Error al guardar \(nombre)")
            }
        }
        return agregados
    }
    
    class func ObtenerPersonas() -> [Persona] {
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        
        let request = Persona.fetch()
        
        var personas = [Persona]()
        let sort = NSSortDescriptor(key : "edad", ascending: true)
        request.sortDescriptors = [sort]
        
        do{
            try personas = context.fetch(request) as [Persona]
        }
        catch{
            
            print ("Error al consultar personas \(error)")
        }
        return personas
    }
    
    
    
    class func ObtenerPersonasNombre(nombre: String) -> [Persona]{
        
        let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
        let request = Persona.fetch()
        var personas = [Persona]()
        let sort = NSSortDescriptor(key : "edad", ascending: true)
        request.sortDescriptors = [sort]

        let predicate = NSPredicate(format: "nombre == %@ ", nombre)
        request.predicate = predicate
       
        do{
            try personas = context.fetch(request) as [Persona]
        }
        catch{
            
            print ("Error al consultar personas \(error)")
        }
        return personas
    }
    
}
