//
//  NewsTableViewController.swift
//  NewenApp
//
//  Created by apple on 11.07.17.
//  Copyright © 2017 Korona. All rights reserved.
//

import UIKit

class NewsTableViewController: UITableViewController {
    
    let techCrunchNewsURL = "https://newsapi.org/v1/articles?source=techcrunch&sortBy=latest&apiKey=6b7c247d75914da0b7a53c8bb951c279"
    
    var techCrunchNewsArray = [NewsList]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        loadNews()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
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
        return techCrunchNewsArray.count
    }

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellFirst", for: indexPath)
        cell.textLabel?.text = techCrunchNewsArray[indexPath.row].title
        
        return cell
    }
    
    func loadNews() {
        let newsRequest = URLRequest(url: NSURL(string: techCrunchNewsURL)! as URL)
        let newsSession = URLSession.shared
        let newsTask = newsSession.dataTask(with: newsRequest) { (data, response, error) in
            if let error = error {
                print(error)
                return
            }
            
            if let data = data {
                self.techCrunchNewsArray = self.parseJSON(data: data as NSData)
                
                OperationQueue.main.addOperation({ 
                    self.tableView.reloadData()
                })
            }
        }
        
        newsTask.resume()
    }
        func parseJSON(data: NSData) -> [NewsList] {
            do {
                let jsonResult = try! JSONSerialization.jsonObject(with: data as Data, options: JSONSerialization.ReadingOptions.mutableContainers) as? NSDictionary
                
                let jsonNews = jsonResult?["articles"] as! [AnyObject]
                
                for jsonNew in jsonNews {
                    let uniqNew = NewsList()
                    uniqNew.title = jsonNew["title"] as! String
                
                    techCrunchNewsArray.append(uniqNew)
                    
                }
                
            } catch {
                print(error)
            }
            
            return techCrunchNewsArray
        }
    


    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

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

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
