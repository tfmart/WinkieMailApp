//
//  EntradaTableViewController.swift
//  WinkieTestApp
//
//  Created by student on 07/06/18.
//  Copyright © 2018 student. All rights reserved.
//

import UIKit

class EntradaTableViewController: UITableViewController {
    
    var assunto:[String] = [String]()
    var corpo:[String] = [String]()
    var de:[String] = [String]()
    var nomede:[String] = [String]()
    var para:[String] = [String]()
    var nomepara:[String] = [String]()
    
    var pullToRefresh = UIRefreshControl()
    
    var test1 = ["entrada mensagem1", "entrada mensagem2", "entrada mensagem3"]

    
    override func viewDidLoad() {
        super.viewDidLoad()
        getMessages("https://jemail.mybluemix.net/Entradaget")
        //get_data_from_url("https://winkiemailapp.mybluemix.net/entrada")
        
        pullToRefresh.addTarget(self, action: #selector(EntradaTableViewController.refresh), for: UIControlEvents.valueChanged)
        self.tableView.addSubview(pullToRefresh)

        

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
    }
    
    @objc func refresh() {
        // Code to refresh table view
        tableView.reloadData()
        for counter in 1..<(assunto.count-1) {
            assunto[counter] = ""
            corpo[counter] = ""
        }
        
        getMessages("https://jemail.mybluemix.net/Entradaget")
        
        self.pullToRefresh.endRefreshing()
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "entrada", for: indexPath)

        //cell.textLabel?.text = assunto[indexPath.row]
        if let inboxCell = cell as? EntradaTableViewCell {
            inboxCell.titleLabel.text = assunto[indexPath.row]
            inboxCell.messageLabel.text = corpo[indexPath.row]
        }
        
        return cell
    }
    
    func getMessages(_ link:String)
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

        guard let dataList = json as? NSArray else {
            return
        }

        if let messages = json as? NSArray {
            for i in 0 ..< dataList.count {
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



        DispatchQueue.main.async(execute: {self.tableRefresh()})

    }

    func tableRefresh() {
        self.tableView.reloadData()
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            tableView.deleteRows(at: [indexPath], with: .fade)
        }
    }

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showEntrada" {
            if let emailPageDetail = segue.destination as? EntradaMailViewController {
                let mailIndex = tableView.indexPathForSelectedRow?.row
                emailPageDetail.assunto = assunto[mailIndex!]
                emailPageDetail.corpo = corpo[mailIndex!]
                emailPageDetail.de = de[mailIndex!]
                emailPageDetail.nomede = nomede[mailIndex!]
                emailPageDetail.para = para[mailIndex!]
                emailPageDetail.nomepara = nomepara[mailIndex!]
                emailPageDetail.nomeFoto = "e\(mailIndex!)"
                
            }
        }
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
