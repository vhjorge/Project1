//
//  DetalleViewController.swift
//  AppDemo
//
//  Created by AdminUTMVHSA on 06/12/16.
//  Copyright © 2016 AdminUTMVHSA. All rights reserved.
//

import UIKit

protocol DetalleViewControllerDelegate{
    func numeroCambiado(numero: Int)
}

class DetalleViewController: UIViewController {
    
    // MARK: Propiedades
    var numerofila = -1
    var DatoSelecccionado = [("",0)]
    var delegado : DetalleViewControllerDelegate? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        lblDetalle.text = "\(numerofila)" + "," + DatoSelecccionado[0].0 + " Edad " + "\(DatoSelecccionado[0].1)"
        
        if (delegado != nil)
        {
            delegado?.numeroCambiado(numero: numerofila)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBOutlet weak var lblDetalle: UILabel!
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
