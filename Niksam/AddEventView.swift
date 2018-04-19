//
//  AddEventView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 29/08/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit
import TextFieldEffects

class AddEventView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextFieldDelegate {
    
    var _controller = AddEventController()

    @IBOutlet var _image: UIImageView!
    @IBOutlet var _titre: JiroTextField!
    @IBOutlet var _description: JiroTextField!
    @IBOutlet var _date: UIDatePicker!
    @IBOutlet var _prix: UITextField!
    @IBOutlet var _dateEnd: UIDatePicker!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _image.image = #imageLiteral(resourceName: "no-image")
        
        _titre.layer.cornerRadius = 5.0
        self._titre.delegate = self
        _description.layer.cornerRadius = 5.0
        self._description.delegate = self
        self._prix.delegate = self
    }

    //imagePicker
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        _image.contentMode = .scaleAspectFit
        _image.image = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func selectedImage(_ sender: UITapGestureRecognizer) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    @IBAction func doCreate(_ sender: Any) {
        let str = _controller.encode64image(image: _image.image!)
        
        _controller.addEvent(title: _titre.text!, description: _description.text!, dateStart: _date.date, dateEnd: _dateEnd.date, image: str, cost: _prix.text!, success: success)
        
         self.navigationController?.popToRootViewController(animated: true)
    }
    
    func success() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez add un event.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
