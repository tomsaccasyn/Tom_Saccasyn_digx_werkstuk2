//
//  TweedeSchermController.swift
//  MobileAppsIOSWerkstuk2
//
//  Created by student on 27/05/2018.
//  Copyright © 2018 EHB. All rights reserved.
//

import UIKit
import CoreData

class TweedeSchermController: UIViewController {

    @IBOutlet weak var txtName: UILabel!
    @IBOutlet weak var txtAddress: UILabel!
    @IBOutlet weak var txtStatus: UILabel!
    @IBOutlet weak var txtBanking: UILabel!
    @IBOutlet weak var txtBonus: UILabel!
    @IBOutlet weak var txtCN: UILabel!
    @IBOutlet weak var txtBS: UILabel!
    @IBOutlet weak var txtABS: UILabel!
    @IBOutlet weak var txtAB: UILabel!
    @IBOutlet weak var txtLU: UILabel!
    let myurl = "https://api.jcdecaux.com/vls/v1/stations?apiKey=6d5071ed0d0b3b68462ad73df43fd9e5479b03d6&contract=Bruxelles-Capitale";
     var j = 0
    var Stations = [StationWerkstuk2]()
    var Station:StationWerkstuk2?
    override func viewDidLoad() {
        super.viewDidLoad()

        txtName.text = Station?.name
        txtAddress.text = Station?.address
        txtStatus.text = Station?.status
        txtBanking.text = "\(String(describing: Station?.banking as! Bool))"
        txtBonus.text = "\(String(describing: Station?.bonus as! Bool))"
        txtCN.text = Station?.contract_name
        txtBS.text = "\(String(describing: Station?.bike_stands as! Int64))"
        txtABS.text = "\(String(describing: Station?.available_bike_stands as! Int64))"
        txtAB.text = "\(String(describing: Station?.available_bikes as! Int64))"
        txtLU.text = "\(String(describing: Station?.last_update as! Int64))"
        
        // Do any additional setup after loading the view.
    }
   // @IBAction func UpdateFunc() {
        //Stations.removeAll()
        
        //getJson()
    //}
    
   /* func getJson()
    {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        let managedContext = appDelegate.persistentContainer.viewContext
        
        let request = NSFetchRequest<NSFetchRequestResult>(entityName: "StationWerkstuk2")
        
        request.returnsObjectsAsFaults = false
        
        do {
            let results = try! managedContext.fetch(request)
            if results.count > 0{
                
                print("Er is iets misgegaan er zit nog iets in de fetch request")
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
                            self.j = self.j+1
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
                                    print(self.j)
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
        let resultsUpdate = try! managedContext.fetch(request)
        if resultsUpdate.count > 0{
            for resultUpdate in resultsUpdate as! [StationWerkstuk2]
            {
                Stations.append(resultUpdate)
                
            }
        
        }
    }
 
 */
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc = segue.destination as? DerdeSchermController
        {
            vc.Station2 = Station
            vc.StationsArray2 = Stations ;
            
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
