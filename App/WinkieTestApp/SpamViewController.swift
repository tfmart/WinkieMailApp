//
//  SpamViewController.swift
//
//
//  Created by Tomas Martins on 13/06/18.
//

import UIKit

class SpamViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var spamTableView: UITableView!
    var assunto:[String] = [String]()
    var corpo:[String] = [String]()
    var de:[String] = [String]()
    var nomede:[String] = [String]()
    var para:[String] = [String]()
    var nomepara:[String] = [String]()
    
    @IBAction func deleteButtonPressed(_ sender: Any) {
        showEmptyMessage.alpha = 1.0
    }
    @IBOutlet weak var showEmptyMessage: UIView!
    
    
    var test3 = ["spam mensagem1", "spam mensagem2", "spam mensagem3"]
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return assunto.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = spamTableView.dequeueReusableCell(withIdentifier: "spam", for: indexPath)
        
        //cell.textLabel?.text = assunto[indexPath.row]
        if let inboxCell = cell as? SpamTableViewCell {
            inboxCell.subjectLabel.text = assunto[indexPath.row]
            inboxCell.messageLabel.text = corpo[indexPath.row]
        }
        
        return cell
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        get_data_from_url("https://jemail.mybluemix.net/Spamget")
        
        // Do any additional setup after loading the view.
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
        spamTableView.reloadData()
    }
    
    //showArquivada
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showSpam" {
            if let emailPageDetail = segue.destination as? SpamMailViewController {
                let mailIndex = spamTableView.indexPathForSelectedRow?.row
                emailPageDetail.assunto = assunto[mailIndex!]
                emailPageDetail.corpo = corpo[mailIndex!]
                emailPageDetail.de = de[mailIndex!]
                emailPageDetail.nomede = nomede[mailIndex!]
                emailPageDetail.para = para[mailIndex!]
                emailPageDetail.nomepara = nomepara[mailIndex!]
                
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
