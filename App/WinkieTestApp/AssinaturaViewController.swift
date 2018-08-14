//
//  AssinaturaViewController.swift
//  Winkie
//
//  Created by Tomas Martins on 13/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class AssinaturaViewController: UIViewController {
    
    @IBOutlet weak var signatureField: UITextView!
    var signature: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Assinatura"
        signatureField.text  = "\(signature ?? "Enviado via Winkie")"
        
        // Do any additional setup after loading the view.
    }

    @IBAction func updateSignatureButtonPressed(_ sender: Any) {
        let sendMessage = EnviarMensagemViewController()
        sendMessage.signature = signatureField.text
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
