//
//  EnviadasTableViewController.swift
//  Winkie
//
//  Created by Tomas Martins on 14/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class EnviadasTableViewController: UITableViewController {

    var assunto:[String] = [String]()
    var corpo:[String] = [String]()
    var de:[String] = [String]()
    var nomede:[String] = [String]()
    var para:[String] = [String]()
    var nomepara:[String] = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get_data_from_url("https://winkiemailapp.mybluemix.net/enviados")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table view data source
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return assunto.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "arquivadas", for: indexPath)
        
        //cell.textLabel?.text = assunto[indexPath.row]
        if let inboxCell = cell as? AgendadasTableViewCell {
            inboxCell.titleLabel.text = assunto[indexPath.row]
            inboxCell.messageLabel.text = corpo[indexPath.row]
        }
        
        return cell
    }
    
    func get_data_from_url(_ link:String)
    {
        let url:URL = URL(string: link)!
        let session = URLSession.shared
        
        let request = NSMutableURLRequest(url: url)
        request.httpMethod = "GET"
        request.cachePolicy = NSURLRequest.CachePolicy.reloadIgnoringCacheData
        
        
        let task = session.dataTask(with: request as URLRequest, completionHandler: {
            (
            data, response, error) in
            
            guard let _:Data = data, let _:URLResponse = response  , error == nil else {
                
                return
            }
            self.extract_json(data!)
        })
        
        task.resume()
        
    }
    
    
    func extract_json(_ data: Data) {
        
        
        let json: Any?
        
        do
        {
            json = try JSONSerialization.jsonObject(with: data, options: [])
        }
        catch {
            return
        }
        
        guard let data_list = json as? NSArray else {
            return
        }
        
        if let messages = json as? NSArray {
            for i in 0 ..< data_list.count {
                if let messageObject = messages[i] as? NSDictionary {
                    if let messageTitle = messageObject["assunto"] as? String {
                        assunto.append(messageTitle)
                    }
                    if let messageBody = messageObject["corpo"] as? String {
                        corpo.append(messageBody)
                    }
                    if let messageFrom = messageObject["de"] as? String {
                        de.append(messageFrom)
                    }
                    if let messageNameFrom = messageObject["nomede"] as? String {
                        nomede.append(messageNameFrom)
                    }
                    if let messageTo = messageObject["para"] as? String {
                        para.append(messageTo)
                    }
                    if let messageToName = messageObject["nomepara"] as? String {
                        nomepara.append(messageToName)
                    }
                }
            }
        }
        
        
        
        DispatchQueue.main.async(execute: {self.do_table_refresh()})
        
    }
    
    func do_table_refresh() {
        self.tableView.reloadData()
    }
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "sent" {
            if let emailPageDetail = segue.destination as? EnviadaMailViewController {
                let mailIndex = tableView.indexPathForSelectedRow?.row
                emailPageDetail.assunto = assunto[mailIndex!]
                emailPageDetail.corpo = corpo[mailIndex!]
                emailPageDetail.de = de[mailIndex!]
                emailPageDetail.nomede = nomede[mailIndex!]
                emailPageDetail.para = para[mailIndex!]
                emailPageDetail.nomepara = nomepara[mailIndex!]
                
            }
        }
    }

}
