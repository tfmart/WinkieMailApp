//
//  EnviarMensagemViewController.swift
//  Winkie
//
//  Created by Tomas Martins on 10/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import Alamofire

class EnviarMensagemViewController: UIViewController {

    @IBOutlet weak var fromTextField: UITextField!
    @IBOutlet weak var toTextField: UITextField!
    @IBOutlet weak var subjectTextField: UITextField!
    @IBOutlet weak var messageTextView: UITextView!
    var signature: String?
    override func viewDidLoad() {
        
        super.viewDidLoad()
        messageTextView.text = "\n\n\(signature ?? "Enviado via Winkie")"
        fromTextField.text = "sofia.nogueira@outlook.com"
        
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(EnviarMensagemViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
    }
    @IBAction func sendButtonPressed(_ sender: Any) {
        //pegar dados do text field
        let emailJSON: [String:Any] = ["de": fromTextField.text!,
                                       "nomede": fromTextField.text!,
                                       "para": toTextField.text!,
                                       "nomepara": toTextField.text!,
                                       "assunto": subjectTextField.text!,
                                       "corpo": messageTextView.text]
        Alamofire.request("https://jemail.mybluemix.net/Entradapost", method: .post, parameters: emailJSON, encoding: URLEncoding.httpBody)
        
        self.dismiss(animated: true, completion: nil)
    }
    @IBAction func cancelNewMessagePressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func dismissKeyboard() {
        //Causes the view (or one of its embedded text fields) to resign the first responder status.
        view.endEditing(true)
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
