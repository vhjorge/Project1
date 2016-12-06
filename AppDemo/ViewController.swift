//
//  ViewController.swift
//  AppDemo
//
//  Created by AdminUTMVHSA on 05/12/16.
//  Copyright © 2016 AdminUTMVHSA. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource , UITableViewDelegate{
    
    let datos = [("Juan",45),("Juan1",40),("Juan2",25)]

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int
    {
        return datos.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
    {
        let proto = (indexPath.row % 2 == 0) ? "Proto1" : "Proto2"
        let vista = tableView.dequeueReusableCell(withIdentifier: proto, for: indexPath) as! FilaTableViewCell
        vista.Izquierda.text = datos[indexPath.row].0
        vista.Derecha.text = "\(datos[indexPath.row].1)"
        return vista
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath)
    {
        print("Fila \(indexPath.row)")
    }
    
}

class clase{
    var numero = 1
        
}

