//
//  ProfilProView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 31/08/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class ProfilProView: UIViewController {

    var _controller = ProfilController()
    var _profile = ProfilPro()
    
    @IBOutlet var _avatar: UIImageView!
    @IBOutlet var _nom: UILabel!
    @IBOutlet var _username: UILabel!
    @IBOutlet var _adresse: UILabel!
    @IBOutlet var _telephone: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _controller.getPro(success: success)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _controller.getPro(success: success)
    }
    
    func success() {
        _profile = _controller._profilPro
        
        if let checkedUrl = URL(string: _profile.avatar ) {
            _avatar.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: _avatar )
        }
        
        _avatar.layer.cornerRadius = _avatar.frame.size.width/2
        _avatar.clipsToBounds = true
        
        _username.text = "@" + _profile.username
        _nom.text = _profile.name
         _adresse.text = _profile.adresse + ", " + String(_profile.zip) + " " + _profile.city
        _telephone.text = _profile.telephone
    }
    
    @IBAction func showEdit(_ sender: Any) {
        let view: EditProfilProView = self.storyboard?.instantiateViewController(withIdentifier: "EditProfilProView") as! EditProfilProView
        
        self.navigationController?.pushViewController(view, animated: true)
        view._profile = _profile
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
