//
//  DerdeSchermController.swift
//  MobileAppsIOSWerkstuk2
//
//  Created by student on 27/05/2018.
//  Copyright © 2018 EHB. All rights reserved.
//

import UIKit
import MapKit

class DerdeSchermController: UIViewController, MKMapViewDelegate{

    @IBOutlet weak var backbutton: UIButton!
    @IBOutlet weak var map1: MKMapView!
    @IBOutlet weak var ShowAllStations: UIButton!
    var locationManager = CLLocationManager()
    var StationsArray2 = [StationWerkstuk2]()
    var Station2:StationWerkstuk2?
    override func viewDidLoad() {
        super.viewDidLoad()
        
        locationManager.requestAlwaysAuthorization()
        
        locationManager.startUpdatingLocation()
        let coordinate:CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: (Station2?.lat)!, longitude: (Station2?.lng)!)
        
        let annotation:MyAnnotationStation = MyAnnotationStation(coordinate: coordinate, name: (Station2?.name)!)
        self.map1.addAnnotation(annotation)
        self.map1.selectAnnotation(annotation, animated: true)
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
        if let vc = segue.destination as? TweedeSchermController
        {
            vc.Station = Station2
            vc.Stations = StationsArray2 ;
            
        }
        if let vc2 = segue.destination as? VierdeSchermController
        {
            vc2.Station3 = Station2
            vc2.StationsArray3 = StationsArray2 ;
            
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
