//
//  ContaViewController.swift
//  Winkie
//
//  Created by student on 13/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class ContaViewController: UIViewController {

    @IBOutlet weak var userPhoto: UIImageView!
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.title = "Conta"
        userPhoto.image = UIImage(named: "sofia")
        userPhoto.round()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    @IBAction func changeAccountButtonPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
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
