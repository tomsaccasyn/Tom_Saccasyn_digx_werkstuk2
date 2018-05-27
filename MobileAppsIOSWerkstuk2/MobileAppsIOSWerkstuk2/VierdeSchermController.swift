//
//  VierdeSchermController.swift
//  MobileAppsIOSWerkstuk2
//
//  Created by student on 27/05/2018.
//  Copyright © 2018 EHB. All rights reserved.
//

import UIKit
import MapKit

class VierdeSchermController: UIViewController,MKMapViewDelegate {

    @IBOutlet weak var map2: MKMapView!
     var locationManager = CLLocationManager()
    var StationsArray3 = [StationWerkstuk2]()
    var Station3:StationWerkstuk2?
    override func viewDidLoad() {
        super.viewDidLoad()

        map2.showsUserLocation = true
        map2.showsBuildings = true
        let locationcenter: CLLocationCoordinate2D = CLLocationCoordinate2DMake(StationsArray3[0].lat, StationsArray3[0].lng);
        let span: MKCoordinateSpan = MKCoordinateSpanMake(0.8,0.8);
        let region:MKCoordinateRegion = MKCoordinateRegionMake(locationcenter, span);
        map2.setRegion(region, animated: true);
        for items in StationsArray3 {
            var naam = items.name;
            var itemlocation: CLLocationCoordinate2D = CLLocationCoordinate2DMake(items.lat, items.lng);
            var itemNaamString:String = items.name!;
            var itemAnnotation = MyAnnotationStation(coordinate:itemlocation,name: itemNaamString);
            
            map2.addAnnotation(itemAnnotation);
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func mapView(_ mapView: MKMapView, didSelect view: MKAnnotationView ) {
        let center = CLLocationCoordinate2D(latitude: (view.annotation?.coordinate.latitude)!, longitude: (view.annotation?.coordinate.longitude)!)
        let region = MKCoordinateRegion(center: center, span: MKCoordinateSpan(latitudeDelta: 0.02, longitudeDelta: 0.02))
        
        mapView.setRegion(region, animated: true)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let vc3 = segue.destination as? DerdeSchermController
        {
            vc3.Station2 = Station3
            vc3.StationsArray2 = StationsArray3 ;
            
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
