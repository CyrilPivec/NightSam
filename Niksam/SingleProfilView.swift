//
//  SingleProfilView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 25/05/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class SingleProfilView: UIViewController {
    
    var _profilId = String()
    var _controller = SingleProfilController()
    
    @IBOutlet var _image: UIImageView!
    @IBOutlet var _nom: UILabel!
    @IBOutlet var _age: UILabel!
    @IBOutlet var _sexe: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        print("///////////")
        print(_profilId)
        print("///////////")
        
        _controller.getProfil(success: succesload, _id: _profilId)
    }
    
    func succesload() {
        if let checkedUrl = URL(string: _controller._profil.avatar ) {
            _image.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: _image )
        }
        _image.layer.cornerRadius = _image.frame.size.width/2
        _image.clipsToBounds = true

        _nom.text = "@" + _controller._profil.username
        let str = String(_controller._profil.age)
        _age.text = str + " ans"
        _sexe.text = _controller._profil.sex
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
            // print(response?.suggestedFilename ?? url.lastPathComponent)
            DispatchQueue.main.async() { () -> Void in
                image.image = UIImage(data: data)
            }
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

}
