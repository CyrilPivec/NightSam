//
//  ProfilUserView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 30/08/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class ProfilUserView: UIViewController {

    var _controller = ProfilController()
    var _profile = Profil()
    
//    @IBOutlet var _background: UIImageView!
    @IBOutlet var _avatar: UIImageView!
   // @IBOutlet var _nom: UILabel!
    @IBOutlet var _username: UILabel!
    @IBOutlet var _age: UILabel!
    @IBOutlet var _sex: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _controller.getUser(success: success)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _controller.getUser(success: success)
    }

    func success() {
        _profile = _controller._profil
        
        if let checkedUrl = URL(string: _profile.avatar ) {
            _avatar.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: _avatar )
        }
        
        _avatar.layer.cornerRadius = _avatar.frame.size.width/2
        _avatar.clipsToBounds = true
        
//        if let checkedUrl2 = URL(string: _profile.background ) {
//            _background.contentMode = .scaleAspectFit
//            downloadImage(url: checkedUrl2, image: _background )
//        }
        _username.text = "@" + _profile.username
//        _nom.text = _profile.firstname + " " + _profile.lastname
        let str = String(_profile.age)
        _age.text = str + " ans"
        _sex.text = "sex: " + _profile.sex
    }
    
    @IBAction func showEdit(_ sender: Any) {
        let view: EditProfilUserView = self.storyboard?.instantiateViewController(withIdentifier: "EditProfilUserView") as! EditProfilUserView
        
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
