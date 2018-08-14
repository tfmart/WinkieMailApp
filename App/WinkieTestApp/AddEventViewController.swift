//
//  AddEventViewController.swift
//  Winkie
//
//  Created by Tomas Martins on 12/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import EventKit


class AddEventViewController: UIViewController{

    
    
    @IBOutlet weak var eventTitleField: UITextField!
    
    @IBOutlet weak var eventLocationField: UITextField!

    @IBOutlet weak var startDatePicker: UIDatePicker!
    
    @IBOutlet weak var endDatePicker: UIDatePicker!
    
    @IBAction func addEventButtonPressed(_ sender: Any) {
            
        //Registra o evento no Calendário do celular
        let eventStore: EKEventStore = EKEventStore()
            eventStore.requestAccess(to: .event) {(granted, error) in
                if (granted) && (error == nil){
                    print("granted \(granted)")
                    print("error \(String(describing: error))")
    
                    let event:EKEvent = EKEvent(eventStore: eventStore)
                    event.title = self.eventTitleField.text!
                    event.location = self.eventLocationField.text!
                    event.startDate = self.startDatePicker.date
                    event.endDate = self.endDatePicker.date
                    event.notes = "Event added via Winkie app (alpha build)"
                    event.calendar = eventStore.defaultCalendarForNewEvents
                    do {
                        try eventStore.save(event, span: .thisEvent)
                    } catch let error as NSError {
                        print("error: \(error)")
                    }
                    print("Event created!")
    
                } else {
                    print("error: \(String(describing: error))")
                }
            }
        
        //Adiciona o evento registrado ao EventosDAO
        var eventosDB = [Eventos]()
        eventosDB.append(Eventos(date: "\(startDatePicker.date)", title: eventTitleField.text!, local: eventLocationField.text!, comeco: "\(startDatePicker.date)", fim: "\(endDatePicker.date)"))
        
        
        //Alerta mostrando que o evento foi criado
        let alert = UIAlertController(title: "Evento Adicionado", message: "O evento foi adicionado com sucesso!", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            eventTitleField.text = ""
            eventLocationField.text = ""
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(AddEventViewController.dismissKeyboard))
        view.addGestureRecognizer(tap)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Calls this function when the tap is recognized.
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
