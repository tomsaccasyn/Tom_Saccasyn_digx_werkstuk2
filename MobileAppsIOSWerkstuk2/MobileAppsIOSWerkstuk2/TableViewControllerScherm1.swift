//
//  TableViewControllerScherm1.swift
//  MobileAppsIOSWerkstuk2
//
//  Created by student on 23/05/2018.
//  Copyright © 2018 EHB. All rights reserved.
//

import UIKit
import CoreData

class TableViewControllerScherm1: UITableViewController {
    let myurl = "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale";
    
    let testurl = "http://ip.jsontest.com/"
    var testData = [String]()
    var stationsopgehaald=[StationWerkstuk2]()
    var i = 0
    
    
    
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
         getJson()
        /*do{
            //let testopgehaald = try! managedContext.fetch(fetchRequest) as! StationWerkstuk2
              //  print(testopgehaald)
            //stationsopgehaald = try managedContext.fetch(fetchRequest) as! [StationWerkstuk2]
            
            
        }catch{
            fatalError("There was an error fetching the list of persons!")
        }*/
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    func getJson()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StationWerkstuk2")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try! managedContext.fetch(request)
            if results.count > 0{
                
                
                for result in results as! [StationWerkstuk2]
                {
                    stationsopgehaald.append(result)
                    
                }
            }
            else{
        let urltest = URL(string: myurl)
        let urlRequest = URLRequest(url: urltest!)
        
        let ss = URLSession(configuration: URLSessionConfiguration.default)
        DispatchQueue.main.async {
            
            let task = ss.dataTask(with: urlRequest){ (data,response,error) in
                guard error == nil else {
                    print("error calling GET")
                    print(error!)
                    return
                }
                guard let responseData = data
                    else{
                        print("Error: did not receive data")
                        return
                }
                let json = try! JSONSerialization.jsonObject(with: responseData, options: []) as? NSArray
                //let naam = json!["name"] as? String
                for item in json!
                {
                    self.i = self.i+1
                    if let itemDict = item as? NSDictionary
                    {
                        
                        let item = NSEntityDescription.insertNewObject(forEntityName: "StationWerkstuk2", into: managedContext) as! StationWerkstuk2
                        if itemDict.value(forKey: "name") != nil{
                             let itemname = itemDict.value(forKey: "name") as? String
                                if itemname != nil{
                                item.name = itemname}
                        }
                       
                        if itemDict.value(forKey: "number") != nil {
                         let itemnumber = itemDict.value(forKey: "number")  as! Int64
                                item.number = itemnumber
                        }
        
                        if itemDict.value(forKey: "address") != nil{
                         let itemaddress = itemDict.value(forKey: "address")  as? String
                            if itemaddress != nil{
                                item.address = itemaddress}
                        
                        }
                        let itemposition = itemDict.value(forKey:"position") as! NSDictionary
                        if itemposition.value(forKey: "lat") != nil{
                         let itemlat = itemposition.value(forKey:"lat") as! Double
                                item.lat = itemlat
                        }
                        
                        if itemposition.value(forKey: "lng") != nil{
                         let itemlng = itemposition.value(forKey: "lng")  as! Double
                                item.lng = itemlng
                        }
                        
                        if itemDict.value(forKey: "banking") != nil{
                         let itembanking = itemDict.value(forKey: "banking")  as! Bool
                                item.banking = itembanking
                        }
                     
                        if itemDict.value(forKey: "bonus") != nil{
                         let itembonus = itemDict.value(forKey: "bonus")  as! Bool
                                item.bonus = itembonus
                        }
                       
                        if itemDict.value(forKey: "status") != nil{
                         let itemstatus = itemDict.value(forKey: "status")  as? String
                            if itemstatus != nil{
                                item.status = itemstatus}
                        }
                        
                        if itemDict.value(forKey: "contract_name") != nil{
                         let itemCN = itemDict.value(forKey: "contract_name")  as? String
                            if itemCN != nil{
                                item.contract_name = itemCN}
                        }
                        
                        if itemDict.value(forKey: "bike_stands") != nil{
                         let itemBS = itemDict.value(forKey: "bike_stands")  as! Int64
                                item.bike_stands = itemBS
                        }
                        
                        if itemDict.value(forKey: "available_bike_stands") != nil{
                         let itemABS = itemDict.value(forKey: "available_bike_stands")  as! Int64
                                item.available_bike_stands = itemABS
                        }
                        
                        if itemDict.value(forKey: "available_bikes") != nil {
                         let itemAB = itemDict.value(forKey: "available_bikes")  as! Int64
                                item.available_bikes = itemAB
                        }
                        
                        
                        if itemDict.value(forKey: "last_update") != nil {
                         let itemLU = itemDict.value(forKey: "last_update")  as! Int64
                                item.last_update = itemLU
                        }
                        
                              do {
                                print("test")
                                print(self.i)
                                        try managedContext.save()
                                
                                    }
                                    catch
                                    {
                                        fatalError("Failure to save context: \(error)")
                                    }
                     
                    }
                    
                }
                
            }
            task.resume()
                }
            }
        }
        catch{
                    print("Data not found")
                }
    
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
        return stationsopgehaald.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "myCell", for: indexPath)
        //cell.textLabel?.text = stationsopgehaald[indexPath.row].name
        cell.textLabel?.text = stationsopgehaald[indexPath.row].name
        cell.detailTextLabel?.text = stationsopgehaald[indexPath.row].status
        
        
        
        //cell.textLabel?.text = testdata[indexPath.row]
        // Configure the cell...

        return cell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if let vc = segue.destination as? TweedeSchermController
        {
            var indexPath = self.tableView.indexPathForSelectedRow
            vc.Station = stationsopgehaald[(indexPath?.row)!]
            vc.Stations = stationsopgehaald ;
            
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
}
