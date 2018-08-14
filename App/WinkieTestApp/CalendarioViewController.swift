//
//  CalendarioViewController.swift
//  Winkie
//
//  Created by Tomas Martins on 11/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit
import JTAppleCalendar
import EventKit

class CalendarioViewController: UIViewController, UITableViewDataSource, UITabBarDelegate{
  
    var eventosCalendario = [Eventos]()

    let formatter = DateFormatter()
    
    let todaysDate = Date()
    
    var eventsFromDatabase: [String:String] = [:]

    @IBOutlet weak var calenarView: JTAppleCalendarView!
    @IBOutlet weak var monthLabel: UILabel!
    @IBOutlet weak var yearLabel: UILabel!
    
    let eventStore = EKEventStore()
    var calendars: [EKCalendar] = [EKCalendar]()
    
    func checkCalendarPermission() {
        eventStore.requestAccess(to: .event, completion: { (isAllowed, error) in
            if let error = error {
                print(error.localizedDescription)
            } else {
                if isAllowed {
                    self.loadData()
                }
            }
        })
        switch EKEventStore.authorizationStatus(for: .event) {
        case .authorized:
            print("Acess to calendar authorizes")
            loadData()
        case .denied, .restricted:
            print("access denied...")
        default:
            print("default")
        }
    }
    
    func loadData() {
        print("Loading data...")
        print(eventStore.calendars(for: .event))
        calendars = eventStore.calendars(for: .event)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        checkCalendarPermission()
        navigationItem.title = "Calendário"
        calenarView.scrollToDate(Date())
        calenarView.selectDates([Date()])
        setupCalendarView()
        self.eventosCalendario = EventosDAO.getEventos()
        
        DispatchQueue.global().asyncAfter(deadline: .now() + 2) {
            let serverObjets = self.getEventsFromDatabase()
            for (date, event) in serverObjets {
                let stringDate = self.formatter.string(from: date)
                self.eventsFromDatabase[stringDate] = event
            }
        }
        
        DispatchQueue.main.async {
            self.calenarView.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return eventosCalendario.count;
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "eventosDia", for: indexPath)
        
        if let eventoCell = cell as? EventosTableViewCell {
            let eventos = self.eventosCalendario[indexPath.row]
            eventoCell.eventTitle.text = eventos.title
            eventoCell.eventLocation.text = eventos.local
            eventoCell.eventStart.text = eventos.comeco
            eventoCell.eventFinish.text = eventos.fim
        }
        
//        let calendar = calendars[indexPath.row]
//        cell.textLabel?.text = calendar.title
        
        return cell
    }
    
    func setupCalendarView() {
        calenarView.minimumLineSpacing = 0
        calenarView.minimumInteritemSpacing = 0
        
        calenarView.visibleDates { (visibleDates) in
            self.setupViewsOfCalendar(from: visibleDates)
        }
    }
    
    func handleCelltextColor(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        
        
        formatter.dateFormat = "yyyy mm dd"
        
        let todayDataString = formatter.string(from: todaysDate)
        let monthDateString = formatter.string(from: cellState.date)
        
        if todayDataString == monthDateString {
            validCell.dateLabel.textColor = UIColor.blue
        } else {
            validCell.dateLabel.textColor = cellState.isSelected ? UIColor.white : UIColor.red
        }
        
        
        if cellState.isSelected {
            validCell.dateLabel.textColor = UIColor.white
            print()
        } else {
            if cellState.dateBelongsTo == .thisMonth {
                validCell.dateLabel.textColor = UIColor.black
            } else {
                validCell.dateLabel.textColor = UIColor(red:0.88, green:0.88, blue:0.88, alpha:1.0)
            }
        }
    }
    
    func handleSelectedCell(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        
        if cellState.isSelected {
            validCell.selectedCell.isHidden = false
        } else {
            validCell.selectedCell.isHidden = true
        }
    }
    
    func handleCellEvents(view: JTAppleCell?, cellState: CellState) {
        guard let validCell = view as? CustomCell else { return }
        validCell.dateLabel.textColor = UIColor.purple
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Funcao para exibir mes e ano
    func setupViewsOfCalendar(from visibleDates: DateSegmentInfo) {
        let date = visibleDates.monthDates.first!.date
        self.formatter.dateFormat = "yyyy"
        self.yearLabel.text = formatter.string(from: date)
        
        self.formatter.dateFormat = "MMMM"
        self.monthLabel.text = formatter.string(from: date)
    }

}

extension CalendarioViewController: JTAppleCalendarViewDataSource {
    
    func configureCalendar(_ calendar: JTAppleCalendarView) -> ConfigurationParameters {
        formatter.dateFormat = "yyyy MM dd"
        formatter.timeZone = Calendar.current.timeZone
        formatter.locale = Calendar.current.locale
        
        let startDate = formatter.date(from: "2017 01 01")!
        let endDate = formatter.date(from: "2019 12 31")!
        
        let parameters = ConfigurationParameters(startDate: startDate, endDate: endDate)
        return parameters
    }
    
    func calendar(_ calendar: JTAppleCalendarView, willDisplay cell: JTAppleCell, forItemAt date: Date, cellState: CellState, indexPath: IndexPath) {
        let cell = cell as! CustomCell
        cell.dateLabel.text = cellState.text
    }
}

extension CalendarioViewController: JTAppleCalendarViewDelegate {
    func calendar(_ calendar: JTAppleCalendarView, cellForItemAt date: Date, cellState: CellState, indexPath: IndexPath) -> JTAppleCell {
        let cell = calendar.dequeueReusableJTAppleCell(withReuseIdentifier: "CustomCell", for: indexPath) as! CustomCell
        cell.dateLabel.text = cellState.text
        handleSelectedCell(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
        return cell
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didSelectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        print("Date \(date)")
        //Date 2018-01-31 02:00:00 +0000
        handleSelectedCell(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didDeselectDate date: Date, cell: JTAppleCell?, cellState: CellState) {
        handleSelectedCell(view: cell, cellState: cellState)
        handleCelltextColor(view: cell, cellState: cellState)
    }
    
    func calendar(_ calendar: JTAppleCalendarView, didScrollToDateSegmentWith visibleDates: DateSegmentInfo) {
        setupViewsOfCalendar(from: visibleDates)
    }
    
}

extension CalendarioViewController {
    func getEventsFromDatabase() -> [Date:String]{
        formatter.dateFormat = "yyyy mm dd"
        
        return [
            formatter.date(from: "2018 06 12")!: "Terminar Calendário do Winkie",
            formatter.date(from: "2018 06 14")!: "Apresentação Winkie",
            formatter.date(from: "2018 06 19")!: "Palestra Amazon Alexa",
        ]
    }
}
