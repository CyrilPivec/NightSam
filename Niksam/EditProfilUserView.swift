//
//  EditProfilUserView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 01/09/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit
import TextFieldEffects

class EditProfilUserView: UIViewController, UITextFieldDelegate, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var _controller = EditProfilController()
    var _profile = Profil()
    
   // @IBOutlet var _background: UIImageView!
    @IBOutlet var _avatar: UIImageView!
    @IBOutlet var _email: JiroTextField!
    @IBOutlet var _username: JiroTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _email.layer.cornerRadius = 5.0
        self._email.delegate = self
        _username.layer.cornerRadius = 5.0
        self._username.delegate = self
        
        _avatar.isUserInteractionEnabled = true
        let TapGesture = UITapGestureRecognizer(target: self, action: #selector(EditProfilUserView.pickAvatar))
        self._avatar.addGestureRecognizer(TapGesture)
        
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
        _email.text = _profile.email
        _username.text = _profile.username

    }
    
    @IBAction func doEdit(_ sender: Any) {
        if _email.text! == "" {
            let alert = UIAlertController(title: "Erreur", message: "Email empty.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else if isValidEmail(testStr: _email.text!) == false {
            let alert = UIAlertController(title: "Erreur", message: "Invalide email.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        } else {
            _controller.editUser(email: _email.text!, username: _username.text!, success: success)
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

    @IBAction func editBackground(_ sender: Any) {
        
    }
    
    @IBAction func editAvatar(_ sender: Any) {
        let str = _controller.encode64image(image: _avatar.image!)
        
        _controller.editAvatarUser(image: str, success: successEditAvatar)
    }
    
    func successEditAvatar() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez edite votre avatar.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    //pick Avatar
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
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
