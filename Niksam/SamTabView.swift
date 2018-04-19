//
//  SamTabView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 08/01/2018.
//  Copyright © 2018 Cyril PIVEC. All rights reserved.
//

import UIKit

class SamTabView: UIViewController {
    var _id = String()
    var _participe = Bool()
    var _sams = [Participant]()
    var _controller = SamEventController()
    var ValueToPass = String()

    @IBOutlet var _table: UITableView!
    @IBOutlet var _button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._table.dataSource = self
        self._table.delegate = self
        
        if (_participe == false) {
            self._button.isHidden = true
        } else {
            self._button.isHidden = false
        }
        
        _controller.loadSam(_id: _id, success: successLoad)
    }
    
    func successLoad() {
        _sams = _controller.data
        _table.reloadData()
    }

    @IBAction func _showDevenirSam(_ sender: Any) {
        let pro : Bool? = UserDefaults.standard.value(forKey: "ispro") as? Bool
        if (pro != true) {
            let view: PutSamView = self.storyboard?.instantiateViewController(withIdentifier: "PutSamView") as! PutSamView
            view._id = _id
            self.navigationController?.pushViewController(view, animated: true)
            
        }
        else {
            let alert = UIAlertController(title: "Alert", message: "Vous ne pouvez pas être sam.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
}

extension SamTabView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
}

extension SamTabView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _sams.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SamEventCell", owner: self, options: nil)?.first as! SamEventCell
        if let checkedUrl = URL(string: _sams[indexPath.row].avatar ) {
            cell._image.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: cell._image )
        }
        
        cell._username.text = _sams[indexPath.row].username
        cell._seat.text = String(_sams[indexPath.row].seat) + " place(s) restante(s)"
        
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy HH:mm"
        
        cell._depart.text = format.string(from: _sams[indexPath.row].leaveAt.dateFromISO8601!)
        cell._radius.text = String(_sams[indexPath.row].radius) + " km"
        
        if (_sams[indexPath.row].seat == 0) {
            cell._seat.textColor = UIColor.red
        }
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ValueToPass = _sams[indexPath.row]._id
        performSegue(withIdentifier: "SegueSam1", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! showSamView
        print(ValueToPass)
        viewController._id = ValueToPass
        viewController._idEvent = _id
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
    
}
