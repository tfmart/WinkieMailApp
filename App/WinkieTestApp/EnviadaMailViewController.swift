//
//  EnivadaMailViewController.swift
//  
//
//  Created by Tomas Martins on 14/06/18.
//

import UIKit

class EnviadaMailViewController: UIViewController {

    var assunto: String?
    var corpo: String?
    var de: String?
    var nomede: String?
    var para: String?
    var nomepara: String?
    var nomeFoto: String!
    
    
    @IBOutlet weak var contactPhoto: UIImageView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var messageSubject: UILabel!
    @IBOutlet weak var messageTextField: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        contactName.text = nomepara
        messageSubject.text = assunto
        messageTextField.text = corpo
        contactPhoto.round()
        contactPhoto.image = UIImage(named: "spam")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
