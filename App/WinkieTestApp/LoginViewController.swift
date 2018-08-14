//
//  LoginViewController.swift
//  WinkieTestApp
//
//  Created by student on 06/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {

    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var emailField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    @IBAction func loginButtonPressed(_ sender: Any) {
        if (nameField.text == "" || emailField.text == "" || passwordField.text == "") {
            nameField.text = "Pessoal"
            emailField.text = "sofia.nogueira@outlook.com"
            passwordField.text = "password123"
        } else {
            //segue for inbox
            let caixaDeEntrada = MensagensViewController()
            self.navigationController?.pushViewController(caixaDeEntrada, animated: true)
        }
    
    }
    override func viewDidLoad() {
        super.viewDidLoad()

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
