//
//  EntradaMailViewController.swift
//  Winkie
//
//  Created by Tomas Martins on 13/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Alamofire

class EntradaMailViewController: UIViewController {

    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var subjectLabel: UILabel!
    @IBOutlet weak var messageLabel: UITextView!
    @IBOutlet weak var contactImage: UIImageView!
    @IBOutlet weak var quickReplyField: UITextView!
    
    @IBAction func agendarButton(_ sender: Any) {
        let alertController = UIAlertController(title: "Agendar", message: "Para quando você quer agendar este email?", preferredStyle: .alert)
        
        let oneHour = UIAlertAction(title: "1 hora", style: .default, handler: { (action) -> Void in
            print("one hour pressed")
        })
        
        let  later = UIAlertAction(title: "Hoje à noite", style: .default, handler: { (action) -> Void in
            print("later button pressed")
        })
        
        let tomorrow = UIAlertAction(title: "Amanhã de manhã", style: .default, handler: { (action) -> Void in
            print("tomorrow button tapped")
        })
        let cancelButton = UIAlertAction(title: "Cancel", style: .cancel, handler: { (action) -> Void in
            print("Cancel button tapped")
        })
        
        
        alertController.addAction(oneHour)
        alertController.addAction(later)
        alertController.addAction(tomorrow)
        alertController.addAction(cancelButton)
        
        self.navigationController!.present(alertController, animated: true, completion: nil)
        
        let emailJSON: [String:Any] = ["de": de!,
                                       "nomede": nomede!,
                                       "para": para!,
                                       "nomepara": nomepara!,
                                       "assunto": assunto!,
                                       "corpo": corpo!
        ]
        Alamofire.request("https://winkiemailapp.mybluemix.net/postagendada", method: .post, parameters: emailJSON, encoding: URLEncoding.httpBody)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    
    @IBAction func sendButtonPressed(_ sender: Any) {
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
    
    var assunto: String?
    var corpo: String?
    var de: String?
    var nomede: String?
    var para: String?
    var nomepara: String?
    var nomeFoto: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        contactName.text = nomede
        subjectLabel.text = assunto
        messageLabel.text = corpo
        //print(nomeFoto!)
        contactImage.image = UIImage(named: nomeFoto!)
        
        quickReplyField!.layer.borderWidth = 1
        quickReplyField!.layer.borderColor = UIColor.black.cgColor
        
        contactImage.round()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "entradaDetail" {
            if let viewControllerB = segue.destination as? EntradaDetailViewController {
                viewControllerB.de = de
                viewControllerB.para = para
                viewControllerB.nomepara = nomepara
                viewControllerB.nomede = nomede
                viewControllerB.nomeFoto = (nomeFoto!)
                viewControllerB.assunto = assunto
                
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

extension UIImageView {
    func round() {
        self.layer.cornerRadius = (self.frame.width / 2)
        self.layer.masksToBounds = true
        self.clipsToBounds = true
    }
}
