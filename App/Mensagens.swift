//
//  Mensagens.swift
//  WinkieTestApp
//
//  Created by student on 08/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import Foundation


class Mensagens {
    var corpoMensagen: String
    var assunto: String
    var de: String
    var nomeDe: String
    var para: String
    var nomePara: String
    
    init(json: [String: AnyObject]) {
        self.corpoMensagen = json["corpo"] as? String ?? ""
        self.assunto = json["assunto"] as? String ?? ""
        self.de = json["de"] as? String ?? ""
        self.nomeDe = json["nomede"] as? String ?? ""
        self.para = json["para"] as? String ?? ""
        self.nomePara = json["nomepara"] as? String ?? ""
    }
}

class MensagensDAO {
    
}

