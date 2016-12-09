//
//  ViewController.swift
//  AppDemo
//
//  Created by AdminUTMVHSA on 05/12/16.
//  Copyright © 2016 AdminUTMVHSA. All rights reserved.
//

import UIKit
import FBSDKLoginKit
import Firebase


class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, DetalleViewControllerDelegate, AgregarViewControllerDelegate{
    
    var context : FIRDatabaseReference?
    
    @IBOutlet weak var txtBuscar: UIBarButtonItem!
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblImagen: UILabel!
    var datos = [("Juan",45),("Juan1",40),("Juan2",25),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan1",40),("Juan2",25),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan1",40),("Juan2",25),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan1",40),("Juan2",25),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",49)]
    var indexDato = -1
    
    
    var arreglo: [Persona] = []
    
    func numeroCambiado(numero: Int) {
        print("Nùmero Cambiado: \(numero)")
        datos[numero].1 = datos[numero].1 + 1
        tblDatos.reloadData()
    }
    
    func agregarPersona(nombre: String, edad: Int, fila : Int) {
        if (fila == -1)
        {
            arreglo.append(Persona.AgregarPersona(nombre: nombre, edad: edad)!)
        }
        else
        {
            arreglo[fila].nombre = nombre
            arreglo[fila].edad = Int16(edad)
            
        }
        (UIApplication.shared.delegate as! AppDelegate).saveContext()
        tblDatos.reloadData()
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        context = FIRDatabase.database().reference()
        
        imgView.image = UIImage (named: "dog" )
        lblImagen.text = "The dog"
        
        if (arreglo.count == 0){
            arreglo = Persona.ObtenerPersonas()
            tblDatos.reloadData()
            if (arreglo.count == 0){
                Sincronizar()
            }
        }
        //
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRefresh(_ sender: Any?) {
        
        // Dia 5
        if (arreglo.count == 0){
            arreglo = Persona.ObtenerPersonas()
            tblDatos.reloadData()
        }
        else{
            arreglo = Persona.ObtenerPersonasNombre(nombre: "Alan")
            tblDatos.reloadData()
        }
        return
        // Dia 3
        let idfacebook = FBSDKAccessToken.current().userID
        let url = URL(string: "http://graph.facebook.com/\(idfacebook!)/picture?type=large")
        let dato : Data?
        
        do{
            dato = try Data(contentsOf: url!)
            imgView.image = UIImage(data: dato!)
        }
        catch{
            print("error cargando imagen")
            dato = nil
            imgView.image = UIImage (named: "dog" )
            
        }
        
        
        //dia 4
        //var id: Int = 1
        for d in arreglo{
            let newchild = context?.child("contactos").childByAutoId()
            newchild?.child("nombre").setValue(d.nombre)
            newchild?.child("edad").setValue(d.edad)
            newchild?.child("genero").setValue(d.genero)
            newchild?.child("foto").setValue(d.foto)
//            context?.child("contactos").child("contacto \(id)").child("nombre").setValue(d.nombre)
//            context?.child("contactos").child("contacto \(id)").child("edad").setValue(d.edad)
//            context?.child("contactos").child("contacto \(id)").child("genero").setValue(d.genero)
//            context?.child("contactos").child("contacto \(id)").child("foto").setValue(d.foto)
//            id = id + 1
        }
        
    }
    
    
    @IBAction func btnAdd(_ sender: UIBarButtonItem) {
        indexDato = -1
        performSegue(withIdentifier: "AgregarSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return arreglo.count
    }
    
    
    @IBOutlet weak var tblDatos: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let proto = (indexPath.row % 2 == 0) ? "Proto1" : "Proto2"
        let vista = tableView.dequeueReusableCell(withIdentifier: proto, for: indexPath) as! FilaTableViewCell
        vista.Izquierda.text = arreglo[indexPath.row].nombre!
        vista.Derecha.text = "\(arreglo[indexPath.row].edad)"
        //vista.imgView.image = UIImage (named: "dog" )
        // let idfacebook = FBSDKAccessToken.current().userID
        //let url =  "http://graph.facebook.com/\(idfacebook!)/picture?type=large"
        
        if (arreglo[indexPath.row].genero == "m")
        {
            vista.imgView.image = UIImage (named: "female" )
        }
        else
        {
            vista.imgView.image = UIImage (named: "male" )
        }
        vista.imgView.DownLoadData(url: arreglo[indexPath.row].foto!)
        
        //        let dato : Data?
        //
        //        do{
        //            dato = try Data(contentsOf: URL(string: url)!)
        //            vista.imgView.image = UIImage(data: dato!)
        //        }
        //        catch{
        //            print("error cargando imagen")
        //            dato = nil
        //            vista.imgView.image = UIImage (named: "dog" )
        //
        //        }
        
        
        return vista
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        //print("Fila \(indexPath.row)")
        indexDato = indexPath.row
        performSegue(withIdentifier: "DetalleSegue", sender: self)
        
    }
    
    func editarFila(sender : UITableViewRowAction, indexpath : IndexPath){
        indexDato = indexpath.row
        performSegue(withIdentifier: "AgregarSegue", sender: self)
        
    }
    
    func borrarFila(sender : UITableViewRowAction, indexpath : IndexPath){
        Persona.BorrarPersona(persona: arreglo[indexpath.row])
        arreglo.remove(at: indexpath.row)
        tblDatos.deleteRows(at: [indexpath], with: .fade)
        
//        Persona.BorrarPersona(nombre: arreglo[indexpath.row].nombre!, edad : Int(arreglo[indexpath.row].edad))
//        arreglo = Persona.ObtenerPersonas()
//        tblDatos.reloadData()
    }
    
    func tableView(_ tableView: UITableView, editActionsForRowAt indexPath: IndexPath) -> [UITableViewRowAction]? {
        let eliminar = UITableViewRowAction(style: .destructive, title: "Borrar", handler: borrarFila)
        let editar = UITableViewRowAction(style: .normal, title: "Editar", handler: editarFila)
        return [editar, eliminar]
    }
    
    
    // MARK: UIViewDelagates
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "DetalleSegue"){
            
            let view = segue.destination as! DetalleViewController
            view.numerofila = indexDato
            view.delegado = self
            view.DatoSelecccionado[0].0 = arreglo[indexDato].nombre!
            view.DatoSelecccionado[0].1 = Int(arreglo[indexDato].edad)
        }
        if (segue.identifier == "AgregarSegue"){
            
            let view = segue.destination as! AgregarViewController
            view.delegado = self
            if (indexDato > -1){
                view.DatoSelecccionado[0].0 = arreglo[indexDato].nombre!
                view.DatoSelecccionado[0].1 = Int(arreglo[indexDato].edad)
            }
            view.fila = indexDato
            
        }
    }
    
    
    // Día 4 Sincronizar
    
    func Sincronizar(){
        
        let url = URL(string: "http://kke.mx/demo/contactos2.php")
        
        //        var request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 1000)
        //
        //        request.httpMethod = "GET"
        
        var request = URLRequest(url: url!, cachePolicy: URLRequest.CachePolicy.returnCacheDataElseLoad, timeoutInterval: 1000)
        
        request.httpMethod = "POST"
        request.httpBody = Data(base64Encoded: "dato1=23&dato2=34")
        //data?.base64EncodedString()
        
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
            
            
            let cad = String(data: data!, encoding: .utf8)
            print ("Responde :\(response?.description)")
            print ("error :\(error)")
            print ("cad : \(cad!)")
            
            var parserResult: Any!
            do {
                parserResult = try JSONSerialization.jsonObject(with: data!, options: .allowFragments)
            }
            catch{
                parserResult = nil;
                print("Error :\(error)");
                return
            }
            
            guard let jsondatos = (parserResult as? Dictionary<String,Any?>)?["datos"] as! [Dictionary<String, Any>]! else {
                print("Error :\(error)");
                return
            }
            
            print ("Agregados \(Persona.agregarTodos(Datos: jsondatos))")
            
            self.arreglo.removeAll()
//            
//            for d in jsondatos {
//                let nombre = d["nombre"] as! String
//                let edad = d["edad"] as! Int
//                let genero = d["genero"] as! String
//                let foto = d["foto"] as! String
//                self.arreglo.append((nombre: nombre, edad: edad, genero: genero, foto: foto))
//                
//            }
            self.arreglo = Persona.ObtenerPersonas()
            self.tblDatos.reloadData()
            
        })
        task.resume()
    }
    
    
    
    override func viewDidAppear(_ animated: Bool) {
        self.context?.child("contactos").child("contacto 1").child("nombre").observe(.value, with: {
            (snap: FIRDataSnapshot) in
            print("Dato: \(snap)")
            let nombre = snap.value!
            self.lblImagen.text = "\(nombre)"
        })
//        self.context?.child("contactos").observe(.childChanged, with: {
//            ( snap: FIRDataSnapshot) in
//            print("Dato: \(snap)")
//            let nombre = snap.children.value(forKey: "nombre")
//            self.lblImagen.text = "\(nombre)"
//        })
    }
    
}

class clase{
    var numero = 1
    
}

