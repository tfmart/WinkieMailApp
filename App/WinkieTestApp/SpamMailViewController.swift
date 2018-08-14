//
//  SpamMailViewController.swift
//  
//
//  Created by Tomas Martins on 13/06/18.
//

import UIKit

class SpamMailViewController: UIViewController {

    var assunto: String?
    var corpo: String?
    var de: String?
    var nomede: String?
    var para: String?
    var nomepara: String?
    
    @IBOutlet weak var messageBody: UITextView!
    @IBOutlet weak var contactName: UILabel!
    @IBOutlet weak var subject: UILabel!
    @IBOutlet weak var contactImage: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()

        contactName.text = nomede
        subject.text = assunto
        messageBody.text = corpo
        // Do any additional setup after loading the view.
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
