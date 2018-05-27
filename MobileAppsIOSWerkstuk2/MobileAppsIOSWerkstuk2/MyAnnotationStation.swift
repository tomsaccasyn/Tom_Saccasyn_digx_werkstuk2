//
//  MyAnnotationStation.swift
//  MobileAppsIOSWerkstuk2
//
//  Created by student on 27/05/2018.
//  Copyright © 2018 EHB. All rights reserved.
//

import UIKit
import MapKit

class MyAnnotationStation: NSObject,MKAnnotation {
    var coordinate: CLLocationCoordinate2D
     var address: String?
     var available_bike_stands: Int64
     var available_bikes: Int64
     var banking: Bool
     var bike_stands: Int64
     var bonus: Bool
     var contract_name: String?
     var last_update: Int64
     //var lat: Double
     //var lng: Double
     var name: String?
     var number: Int64
     var status: String?
    
    override init() {
        coordinate = CLLocationCoordinate2D()
        address = ""
        name = ""
        contract_name=""
        available_bike_stands=0
        available_bikes = 0
        banking = false
        bonus = false
        bike_stands = 0
        number = 0
        status = ""
        last_update=0
    }
    init(coordinate:CLLocationCoordinate2D,name:String) {
        self.coordinate = coordinate
        self.name = name
        self.available_bike_stands=0
        self.available_bikes = 0
        self.banking = false
        self.bonus = false
        self.bike_stands = 0
        self.number = 0
        self.status = ""
        self.last_update=0
    }
    
    
    init (coordinate:CLLocationCoordinate2D, name:String,address:String,CN:String,ABS:Int64,AB:Int64,banking:Bool,bonus:Bool,BS:Int64,number:Int64,status:String,LU:Int64)
    {
        self.coordinate = coordinate
        self.name = name
        self.address = address
        self.contract_name = CN
        self.available_bike_stands=ABS
        self.available_bikes = AB
        self.banking = banking
        self.bonus = bonus
        self.bike_stands = BS
        self.number = number
        self.status = status
        self.last_update = LU
    }
    
    
    
    
    
}
