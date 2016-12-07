//
//  ViewController.swift
//  AppDemo
//
//  Created by AdminUTMVHSA on 05/12/16.
//  Copyright © 2016 AdminUTMVHSA. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate, DetalleViewControllerDelegate, AgregarViewControllerDelegate{
    
    @IBOutlet weak var imgView: UIImageView!
    @IBOutlet weak var lblImagen: UILabel!
    var datos = [("Juan",45),("Juan1",40),("Juan2",25),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan1",40),("Juan2",25),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan1",40),("Juan2",25),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan1",40),("Juan2",25),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",45),("Juan",49)]
    var indexDato = -1
    
    func numeroCambiado(numero: Int) {
        print("Nùmero Cambiado: \(numero)")
        datos[numero].1 = datos[numero].1 + 1
        tblDatos.reloadData()
    }
    
    func agregarPersona(nombre: String, edad: Int, fila : Int) {
        if (fila == -1)
        {
            datos.append((nombre,edad));
        }
        else
        {
            datos[fila].0 = nombre
            datos[fila].1 = edad
        }
        tblDatos.reloadData()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        imgView.image = UIImage (named: "dog" )
        lblImagen.text = "The dog"
        
        // Do any additional setup after loading the view, typically from a nib.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func btnRefresh(_ sender: UIBarButtonItem) {
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
        
    }
    
    @IBAction func btnAdd(_ sender: UIBarButtonItem) {
        indexDato = -1
        performSegue(withIdentifier: "AgregarSegue", sender: self)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return datos.count
    }
    
    
    @IBOutlet weak var tblDatos: UITableView!
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let proto = (indexPath.row % 2 == 0) ? "Proto1" : "Proto2"
        let vista = tableView.dequeueReusableCell(withIdentifier: proto, for: indexPath) as! FilaTableViewCell
        vista.Izquierda.text = datos[indexPath.row].0
        vista.Derecha.text = "\(datos[indexPath.row].1)"
        vista.imgView.image = UIImage (named: "dog" )
        let idfacebook = FBSDKAccessToken.current().userID
        let url =  "http://graph.facebook.com/\(idfacebook!)/picture?type=large"
        
        vista.imgView.LoadImageUrl(url: url)        
        
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
        datos.remove(at: indexpath.row)
        tblDatos.reloadData()
        
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
            view.DatoSelecccionado[0] = ("\(datos[indexDato].0)" , datos[indexDato].1)
        }
        if (segue.identifier == "AgregarSegue"){
            
            let view = segue.destination as! AgregarViewController
            view.delegado = self
            if (indexDato > -1){
                view.DatoSelecccionado[0] = ("\(datos[indexDato].0)" , datos[indexDato].1)
            }
            view.fila = indexDato
            
        }
    }
    
    
}

class clase{
    var numero = 1
        
}

