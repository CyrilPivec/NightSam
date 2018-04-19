//
//  EventProTableView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 23/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class EventProTableView: UIViewController {

    @IBOutlet var _table: UITableView!
    
    var _events = [Event]()
    var _eventController = EventProTableController()
    var ValueToPass = String()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._table.dataSource = self
        self._table.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _eventController.data.removeAll()
        _eventController.loadEvent(success: successLoad)
    }
    
    func successLoad() {
        _events = _eventController.data
       _table.reloadData()
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
                image.image = UIImage(data: data)
            }
        }
    }
    
    @IBAction func show_add(_ sender: Any) {
        let view: AddEventView = self.storyboard?.instantiateViewController(withIdentifier: "AddEventView") as! AddEventView
        
        self.navigationController?.pushViewController(view, animated: true)
    }
    
    

}

extension EventProTableView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 101
    }
}

extension EventProTableView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _events.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("EventProViewCell", owner: self, options: nil)?.first as! EventProViewCell
        if let checkedUrl = URL(string: _events[indexPath.row].mainPhoto ) {
            cell._image.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: cell._image )
        }
        cell._title.text = _events[indexPath.row].title
        
        print("//////////////")
        print(_events[indexPath.row].participants)
        print("//////////////")
        
//        for (_, subJson):(String, [String]) in _events[indexPath.row].participants {
//            data.append(subJson["username"].string!)
//        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ValueToPass = _events[indexPath.row]._id
        performSegue(withIdentifier: "Segue4", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! SingleEventView
        viewController._eventid = ValueToPass
    }
}
