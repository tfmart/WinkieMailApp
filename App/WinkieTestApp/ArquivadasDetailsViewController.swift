//
//  ArquivadasDetailsViewController.swift
//  Winkie
//
//  Created by Tomas Martins on 14/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class ArquivadasDetailsViewController: UIViewController {

    @IBOutlet weak var subjectLabel: UILabel!
    
    var assunto: String?
    var corpo: String?
    var de: String?
    var nomede: String?
    var para: String?
    var nomepara: String?
    var nomeFoto: String!
    
    @IBOutlet weak var imageFrom: UIImageView!
    @IBOutlet weak var nameFrom: UILabel!
    @IBOutlet weak var emailFrom: UILabel!
    
    
    @IBOutlet weak var imageTo: UIImageView!
    @IBOutlet weak var nameTo: UILabel!
    @IBOutlet weak var emailTo: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subjectLabel.text = assunto
        emailFrom.text = de
        emailTo.text = para
        nameTo.text = nomepara
        nameFrom.text = nomede
        imageFrom.image = UIImage(named: nomeFoto!)
        imageTo.image = UIImage(named: "sofia")
        imageTo.round()
        imageTo.round()
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
