//
//  MailAgendadasViewController.swift
//  Winkie
//
//  Created by student on 13/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Alamofire

class MailAgendadasViewController: UIViewController{

    var assunto: String?
    var corpo: String?
    var de: String?
    var nomede: String?
    var para: String?
    var nomepara: String?
    var nomeFoto: String!
    
    
    @IBOutlet weak var quickReplyField: UITextView!
    
    @IBAction func sendMessageButtonPressed(_ sender: Any) {
        //pegar dados do text field
        let emailJSON: [String:Any] = ["de": para!,
                                       "nomede": nomepara!,
                                       "para": de!,
                                       "nomepara": nomede!,
                                       "assunto": "RE: \(assunto!)",
                                       "corpo": quickReplyField.text
            ]
        Alamofire.request("https://winkiemailapp.mybluemix.net/enviar", method: .post, parameters: emailJSON, encoding: URLEncoding.httpBody)
        
        quickReplyField.text = ""
        
        let alert = UIAlertController(title: "Enviado", message: "Mensagem enviada com sucesso!", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "agDetails" {
            if let viewControllerB = segue.destination as? AgendadaDetailsViewController {
                viewControllerB.de = de
                viewControllerB.para = para
                viewControllerB.nomepara = nomepara
                viewControllerB.nomede = nomede
                viewControllerB.nomeFoto = (nomeFoto!)
                viewControllerB.assunto = assunto

            }
        }
    }

    
    @IBOutlet weak var contactPhoto: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var messageSubject: UILabel!
    @IBOutlet weak var messageTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactName.text = nomede
        messageSubject.text = assunto
        messageTextField.text = corpo
        contactPhoto.round()
        contactPhoto.image = UIImage(named: nomeFoto!)
        quickReplyField!.layer.borderWidth = 1
        quickReplyField!.layer.borderColor = UIColor.black.cgColor
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
