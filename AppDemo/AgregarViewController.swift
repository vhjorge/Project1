//
//  AgregarViewController.swift
//  AppDemo
//
//  Created by AdminUTMVHSA on 06/12/16.
//  Copyright © 2016 AdminUTMVHSA. All rights reserved.
//

import UIKit

protocol AgregarViewControllerDelegate{
    func agregarPersona(nombre: String, edad:Int, fila : Int)
}

class AgregarViewController: UIViewController {

    var fila = -1
    var DatoSelecccionado = [("",0)]
    var delegado : AgregarViewControllerDelegate? = nil
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        if (fila > -1)
        {
            txtNombre.text = DatoSelecccionado[0].0
            txtEdad.text = "\(DatoSelecccionado[0].1)"
            btnAgregar.setTitle("Guardar Cambios", for: .normal)
        }
        
       
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBOutlet weak var txtNombre: UITextField!
    @IBOutlet weak var txtEdad: UITextField!
    @IBOutlet weak var lblError: UILabel!
    @IBOutlet weak var btnAgregar: UIButton!

   
    @IBAction func btnAgregar(_ sender: UIButton) {
        if (delegado != nil)
        {
            if (txtNombre.text != nil && (txtNombre.text?.characters.count)! > 0 &&
                txtEdad.text != nil && (txtEdad.text?.characters.count)! > 0)
            {               
                delegado?.agregarPersona(nombre: txtNombre.text!, edad: Int(txtEdad.text!)!, fila: fila)
                self.navigationController!.popViewController(animated: true)
               
            }
            else{
                
                lblError.isHidden = false
                let alert = UIAlertController(title: "Error", message: "Datos no validos", preferredStyle: .actionSheet)
                let defualtAction = UIAlertAction(title: "Ok", style: .default, handler: { (UIAlertAction) in })
                
                alert.addAction(defualtAction);
                let cancelAction = UIAlertAction(title: "Cancel", style: .cancel, handler: { (UIAlertAction) in
                self.navigationController!.popViewController(animated: true)
                })
                
                alert.addAction(cancelAction);
                present(alert, animated: true, completion: {})
            }
        }
        
    }
    
   
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
