//
//  SearchView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 11/01/2018.
//  Copyright © 2018 Cyril PIVEC. All rights reserved.
//

import UIKit

class SearchView: UIViewController {

    @IBOutlet var _searchBar: UISearchBar!
    @IBOutlet var _SegmentedControl: UISegmentedControl!
    @IBOutlet var _table: UITableView!
    
    var controller = RechercheController()
    var events = [Event]()
    var _participants = [Participant2]()
    var ValueToPass = String()
    
    var Sgmt = Int()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        Sgmt = 1
        
        self._table.dataSource = self
        self._table.delegate = self
        self._searchBar.delegate = self
        
    }
    
    @IBAction func indexChanged(_ sender: Any) {
        switch _SegmentedControl.selectedSegmentIndex
        {
        case 0:
            Sgmt = 1
        case 1:
            Sgmt = 2
        default:
            break
        }
    }
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    ///////////////
    
}

extension SearchView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let keyword = searchBar.text
        let finalKeywords = keyword?.replacingOccurrences(of: " ", with: "+")
        
        if (Sgmt == 1) {
            controller.data.removeAll()
            controller.loadEvent(success: success, keyword: finalKeywords!)
            
        } else {
            controller.data2.removeAll()
            controller.loadParticipant(success: successLoad, keyword: finalKeywords!)
        }
    }
    
    func success() {
        events = controller.data
        _table.reloadData()
    }
    
    func successLoad() {
        _participants = controller.data2
        _table.reloadData()
    }
}

extension SearchView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if (Sgmt == 1) {
            return 100
        } else {
            return 50
        }
    }
}

extension SearchView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if (Sgmt == 1) {
            return events.count
        } else {
            return _participants.count
        }
    }

    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if (Sgmt == 1) {
            
            let cell = Bundle.main.loadNibNamed("EventCell", owner: self, options: nil)?.first as! EventCell
            
            if let checkedUrl = URL(string: events[indexPath.row].mainPhoto ) {
                cell.imageCell.contentMode = .scaleAspectFit
                downloadImage(url: checkedUrl, image: cell.imageCell )
            }
            cell.labelCell.text = events[indexPath.row].title
            cell.descCell.text = events[indexPath.row].shortDescription
            cell.villeCell.text = events[indexPath.row].city
            return cell
            
        } else {
            let cell = Bundle.main.loadNibNamed("ParticipantCell", owner: self, options: nil)?.first as! ParticipantCell
            if let checkedUrl = URL(string: _participants[indexPath.row].avatar ) {
                cell._avatar.contentMode = .scaleAspectFit
                downloadImage(url: checkedUrl, image: cell._avatar )
            }
            
            cell._username.text = _participants[indexPath.row].username
            
            return cell
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
                image.image = UIImage(data: data)
            }
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        ValueToPass = events[indexPath.row]._id
        performSegue(withIdentifier: "ScuScu", sender: self)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let viewController = segue.destination as! EventView
        viewController._eventid = ValueToPass
    }

}

