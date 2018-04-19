//
//  EditProfilProView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 31/08/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit
import TextFieldEffects

class EditProfilProView: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var _controller = EditProfilController()
    var _profile = ProfilPro()
    
    @IBOutlet var _email: JiroTextField!
    @IBOutlet var _avatar: UIImageView!
    @IBOutlet var _nom: JiroTextField!
    @IBOutlet var _adresse: JiroTextField!
    @IBOutlet var _ville: JiroTextField!
    @IBOutlet var _zip: JiroTextField!
    @IBOutlet var _country: JiroTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _nom.layer.cornerRadius = 5.0
        self._nom.delegate = self
        _adresse.layer.cornerRadius = 5.0
        self._adresse.delegate = self
        _ville.layer.cornerRadius = 5.0
        self._ville.delegate = self
        _zip.layer.cornerRadius = 5.0
        self._zip.delegate = self
        _country.layer.cornerRadius = 5.0
        self._country.delegate = self
        _email.layer.cornerRadius = 5.0
        self._email.delegate = self
        
        if let checkedUrl = URL(string: _profile.avatar ) {
            _avatar.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: _avatar )
        }
        
        _avatar.isUserInteractionEnabled = true
        let TapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfilProView.pickAvatar))
        self._avatar.addGestureRecognizer(TapGesture)
        
        _avatar.layer.cornerRadius = _avatar.frame.size.width/2
        _avatar.clipsToBounds = true
        
        _nom.text = _profile.name
        _adresse.text = _profile.adresse
        _ville.text = _profile.city
        _zip.text = String(_profile.zip)
        _country.text = _profile.country
        _email.text = _profile.email
    }
    
    @IBAction func doSave(_ sender: Any) {
        if _email.text! == "" {
            let alert = UIAlertController(title: "Erreur", message: "Email empty.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if isValidEmail(testStr: _email.text!) == false {
            let alert = UIAlertController(title: "Erreur", message: "Invalide email.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
        _controller.editPro(email: _email.text!, name: _nom.text!, address: _adresse.text!, zip: _zip.text!, city: _ville.text!, country: _country.text!, success: success)
        }
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
    func success() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez edite votre profil.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func successEditBackground() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez edite votre background.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func _uploadAvatar(_ sender: Any) {
        let str = _controller.encode64image(image: _avatar.image!)
        
        _controller.editAvatarPro(image: str, success: successEditAvatar)
    }
    
    func successEditAvatar() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez edite votre avatar.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //pick background
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        _avatar.contentMode = .scaleAspectFit
        _avatar.image = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func pickBackground(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    //pick Avatar
    func imagePickerControllerDidCancel2(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController2(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        _avatar.contentMode = .scaleAspectFit
        _avatar.image = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    func pickAvatar() {
        let imagePickerController2 = UIImagePickerController()
        imagePickerController2.sourceType = .photoLibrary
        imagePickerController2.delegate = self
        present(imagePickerController2, animated: true, completion: nil)
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
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
}
