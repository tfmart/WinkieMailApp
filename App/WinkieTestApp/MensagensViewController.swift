//
//  MensagensViewController.swift
//  Winkie
//
//  Created by student on 08/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class MensagensViewController: UIViewController {

    @IBOutlet weak var entradaContainer: UIView!
    @IBOutlet weak var arquivadaContainer: UIView!
    @IBOutlet weak var spamContainer: UIView!
    @IBAction func secoesControl(_ sender: UISegmentedControl) {
        switch sender.selectedSegmentIndex {
        case 0:
            self.entradaContainer.alpha = 1
            self.arquivadaContainer.alpha = 0
            self.spamContainer.alpha = 0
        case 1:
            self.entradaContainer.alpha = 0
            self.arquivadaContainer.alpha = 1
            self.spamContainer.alpha = 0
        case 2:
            self.entradaContainer.alpha = 0
            self.arquivadaContainer.alpha = 0
            self.spamContainer.alpha = 1
        default:
            break
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
