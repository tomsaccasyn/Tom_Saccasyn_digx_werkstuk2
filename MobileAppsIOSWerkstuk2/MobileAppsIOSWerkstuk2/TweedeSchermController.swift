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
