//
//  Eventos.swift
//  Winkie
//
//  Created by student on 12/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import Foundation

//var eventosCalendario = ["Date" : "Date 2018-06-19 03:00:00 +0000", "title": "Evento teste", "local": "Hackatruck", "comeco":"14:00", "fim":"18:00"]


class Eventos {
    var date: String
    var title: String
    var local: String
    var comeco: String
    var fim: String
    
    init(date: String, title: String, local: String, comeco: String, fim: String) {
        self.date = date
        self.title = title
        self.local = local
        self.comeco = comeco
        self.fim = fim
    }
}

class EventosDAO {
    static func getEventos() -> [Eventos] {
    return [
        Eventos(date: "Date 2018-06-14 03:00:00 +0000", title: "Corrida", local: "Lagoa do Taquaral", comeco: "09:00", fim: "10:30"),
        Eventos(date: "Date 2018-06-14 03:00:00 +0000", title: "Almoço com o Luis", local: "Nico Paneteria", comeco: "12:30", fim: "13:30"),
        Eventos(date: "Date 2018-06-14 03:00:00 +0000", title: "Comprar frtuas", local: "Oba Hortifruti", comeco: "17:00", fim: "18:30")
    ]
    }
}
