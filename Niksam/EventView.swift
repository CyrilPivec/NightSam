//
//  EventView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 04/09/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit
import SwiftyJSON

class EventView: UIViewController {

    var _eventid = String()
    var _controller = EventController()
    var _event = SingleEvent()
    var ValueToPass = String()
    var _participerController = ParticipantTableController()
    var data = [String]()
    var participe = Bool()
    
    @IBOutlet var _image: UIImageView!
    @IBOutlet var _titre: UILabel!
    @IBOutlet var _description: UILabel!
    @IBOutlet var _prix: UILabel!
    @IBOutlet var _date: UILabel!
    @IBOutlet var _adresse: UILabel!
    @IBOutlet var _buttonParticipe: UIButton!
    @IBOutlet var _buttonParticipant: UIButton!
    @IBOutlet var _buttonSam: UIButton!
    @IBOutlet var _viewPrice: UIView!
    @IBOutlet var _buttonReserve: UIButton!
    @IBOutlet var _buttonCommentaire: UIButton!
    @IBOutlet var _buttonChat: UIButton!
    @IBOutlet var _buttonGalerie: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _buttonParticipe.layer.cornerRadius = 15
        _buttonParticipant.layer.cornerRadius = 5
        _buttonSam.layer.cornerRadius = 5
        _description.layer.borderWidth = 1
        _description.layer.cornerRadius = 5
        _description.layer.borderColor = UIColor.lightGray.cgColor
        _viewPrice.layer.cornerRadius = 5
        _buttonReserve.layer.cornerRadius = 15
        
        _buttonCommentaire.layer.cornerRadius = 5
        _buttonChat.layer.cornerRadius = 5
        
        _buttonGalerie.layer.borderWidth = 1
        _buttonGalerie.layer.cornerRadius = 5
        _buttonGalerie.layer.borderColor = UIColor(hex: "3399FF").cgColor
        
        _controller.getEvent(_id: _eventid, success: successLoad)
        
//        _buttonParticipe.setTitle("Participer", for: .normal)
//        _buttonParticipe.backgroundColor = UIColor.blue
        
        
    }
    
    func successLoad() {
        _event = _controller._event
        
        if let checkedUrl = URL(string: _event.mainPhoto ) {
            _image.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: _image )
        }
        _titre.text = _event.title
        
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy HH:mm"

        _date.text = format.string(from: _event.dateStart.dateFromISO8601!)
        
        _description.text = _event.description
        _prix.text = String(_event.price) + " €"
        _adresse.text = _event.adresse + ", " + String(_event.zip) + " " + _event.city
        
        parseJson()
       
        guard let username = UserDefaults.standard.value(forKey: "username") as? String else {
            print("erreur 401")
            return
        }
        
        for dat in data {
            if (dat == username) {
                _buttonParticipe.setTitle("Ne plus participer", for: .normal)
                _buttonParticipe.backgroundColor = UIColor.red
                participe = true
            } else {
                participe = false
            }
        }
    }
    
    func parseJson () {
        
        for (_, subJson):(String, JSON) in _event.participants {
            data.append(subJson["username"].string!)
        }
    }
    
    @IBAction func showParticipant(_ sender: Any) {
        let view: ParticipantTableView = self.storyboard?.instantiateViewController(withIdentifier: "ParticipantTableView") as! ParticipantTableView
        
        self.navigationController?.pushViewController(view, animated: true)
        view._id = _eventid
    }
    
    @IBAction func doParticiper(_ sender: Any) {
        let pro : Bool? = UserDefaults.standard.value(forKey: "ispro") as? Bool
        if (pro != true) {
            _controller.putParticipation(_eventid: _eventid, success: successParticipation)
        }
        else {
            let alert = UIAlertController(title: "Succès", message: "Vous ne pouvez pas rejoindre l'event.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    func successParticipation() {
        
        if (participe == true) {
            participe = false
            _buttonParticipe.setTitle("participer", for: .normal)
            _buttonParticipe.backgroundColor = UIColor(hex: "0066FF")
            let alert = UIAlertController(title: "Succès", message: "Vous avez quitté l'event.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            participe = true
            _buttonParticipe.setTitle("Ne plus participer", for: .normal)
            _buttonParticipe.backgroundColor = UIColor.red
            let alert = UIAlertController(title: "Succès", message: "Vous avez rejoins l'event.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func showCommentaire(_ sender: Any) {
        let view: CommentView = self.storyboard?.instantiateViewController(withIdentifier: "CommentView") as! CommentView
        
        self.navigationController?.pushViewController(view, animated: true)
        view._id = _eventid
        view._participe = participe
    }
    
    @IBAction func showSam(_ sender: Any) {
        let view: SamTabView = self.storyboard?.instantiateViewController(withIdentifier: "SamTabView") as! SamTabView
        
        self.navigationController?.pushViewController(view, animated: true)
        view._id = _eventid
        view._participe = participe
    }
    
    @IBAction func showGalerie(_ sender: Any) {
        let view: GalerieView = self.storyboard?.instantiateViewController(withIdentifier: "GalerieView") as! GalerieView
        
        self.navigationController?.pushViewController(view, animated: true)
        view._id = _eventid
        view.photos = _event.photos
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (segue.identifier == "idChatView") {
            let vc = segue.destination as! ChatView
            vc._id = sender as! String
        }
    }
    
    @IBAction func showChat(_ sender: Any) {
        performSegue(withIdentifier: "idChatView", sender: _eventid)
    }
    
    
    //dl image
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

extension UIColor {
    convenience init(hex: String) {
        let scanner = Scanner(string: hex)
        scanner.scanLocation = 0
        
        var rgbValue: UInt64 = 0
        
        scanner.scanHexInt64(&rgbValue)
        
        let r = (rgbValue & 0xff0000) >> 16
        let g = (rgbValue & 0xff00) >> 8
        let b = rgbValue & 0xff
        
        self.init(
            red: CGFloat(r) / 0xff,
            green: CGFloat(g) / 0xff,
            blue: CGFloat(b) / 0xff, alpha: 1
        )
    }
}
