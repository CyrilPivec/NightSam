//
//  EventTabView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 10/08/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit
import TwicketSegmentedControl
import GoogleMaps
import CoreLocation

class EventTabView: UIViewController {
    @IBOutlet var segmentedControl: TwicketSegmentedControl!

    let titles = ["Liste", "Carte"]
    
    
    @IBOutlet var mapView: GMSMapView!
    @IBOutlet var tableView: UITableView!
    
    var events = [Event]()
    var controller = EventTableController()
    var ValueToPass = String()
    
    var locationManager = CLLocationManager()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        segmentedControl.setSegmentItems(titles)
        segmentedControl.delegate = self
        
        segmentedControl.move(to: 0)
        self.tableView.isHidden = false
        self.mapView.isHidden = true
        
        self.tableView.dataSource = self
        self.tableView.delegate = self
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
    }
    
    override func viewWillAppear(_ animated: Bool) {
        controller.data.removeAll()
        controller.loadEvent(success: successLoad)
    }
    
    func successLoad() {
        events = controller.data
        tableView.reloadData()
        mapMarker()
    }
    
    func mapMarker() {
        for event in events {
            let marker = GMSMarker()
            marker.position = CLLocationCoordinate2D(latitude: event.lat, longitude: event.lng)
            marker.title = event.title
            marker.map = mapView
        }
    }
    
    func getDataFromUrl(url: URL, completion: @escaping (_ data: Data?, _  response: URLResponse?, _ error: Error?) -> Void) {
        URLSession.shared.dataTask(with: url) {
            (data, response, error) in
            completion(data, response, error)
            }.resume()
    }
    
    func downloadImage(url: URL, image: UIImageView) {
        getDataFromUrl(url: url) { (data, response, error)  in
            guard let data = data, error == nil else { return }
            DispatchQueue.main.async() { () -> Void in
                let _image = UIImage(data: data)
                image.image = _image
            }
        }
    }

}



extension EventTabView: CLLocationManagerDelegate {
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        if status == .authorizedWhenInUse {
            locationManager.startUpdatingLocation()
            mapView.isMyLocationEnabled = true
            mapView.settings.myLocationButton = true
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        let km : Int? = UserDefaults.standard.value(forKey: "kmaffichage") as? Int
        
        if let location = locations.first {
            mapView.camera = GMSCameraPosition(target: location.coordinate, zoom: Float(km!), bearing: 0, viewingAngle: 0)
            locationManager.stopUpdatingLocation()
        }
    }
}

extension EventTabView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}

extension EventTabView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("EventCell", owner: self, options: nil)?.first as! EventCell
        
        if let checkedUrl = URL(string: events[indexPath.row].mainPhoto ) {
            cell.imageCell.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: cell.imageCell )
        }
        cell.labelCell.text = events[indexPath.row].title
        cell.descCell.text = events[indexPath.row].shortDescription
        cell.villeCell.text = events[indexPath.row].city
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ValueToPass = events[indexPath.row]._id
        performSegue(withIdentifier: "SegueEvent", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! EventView
        viewController._eventid = ValueToPass
    }
    
}

extension EventTabView: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        
        let viewWidth = view.frame.width
        let centerX = self.mapView.center.x
       
        switch segmentIndex {
        case 0:
            self.tableView.center.x = centerX + viewWidth
            UIView.animate(withDuration: 0.3, animations: {
                self.tableView.center.x = centerX
                self.tableView.isHidden = false
                self.mapView.isHidden = true
            })
        case 1:
            self.mapView.center.x = centerX + viewWidth
            UIView.animate(withDuration: 0.3, animations: {
                self.mapView.center.x = centerX
                self.tableView.isHidden = true
                self.mapView.isHidden = false
            })
        default:
            self.tableView.isHidden = true
            self.mapView.isHidden = true
        }
    }
}
