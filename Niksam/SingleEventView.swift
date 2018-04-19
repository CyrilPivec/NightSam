//
//  SingleEventView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 06/09/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class SingleEventView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    var _eventid = String()
    var _controller = SingleEventController()
    var _event = SingleEvent()
    
    @IBOutlet var _image: UIImageView!
    @IBOutlet var _title: UILabel!
    @IBOutlet var _date: UILabel!
    @IBOutlet var _description: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        _controller.getEvent(_id: _eventid, success: successLoad)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _controller.getEvent(_id: _eventid, success: successLoad)
    }
    
    func successLoad() {
        _event = _controller._event
        
        if let checkedUrl = URL(string: _event.mainPhoto ) {
            _image.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: _image )
        }
        _title.text = _event.title
        
        let format = DateFormatter()
        format.dateFormat = "dd/MM/yyyy HH:mm"
        
        _date.text = format.string(from: _event.dateStart.dateFromISO8601!)
        _description.text = _event.description
    }

    @IBAction func ajouterPhoto(_ sender: Any) {
        let imagePickerController = UIImagePickerController()
        imagePickerController.sourceType = .photoLibrary
        imagePickerController.delegate = self
        present(imagePickerController, animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
        let selectedPhoto = info[UIImagePickerControllerOriginalImage] as! UIImage
        //image.contentMode = .scaleAspectFit
        _image.image = selectedPhoto
        dismiss(animated: true, completion: nil)
        
        let str = _controller.encode64image(image: _image.image!)
        
        _controller.addImage(_id: _eventid, _image: str, success: successAddPicture)
    }
    
    func successAddPicture() {
        let alert = UIAlertController(title: "Success", message: "Vous avez ajouté une photo.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func doModifier(_ sender: Any) {
        let view: EditEventView = self.storyboard?.instantiateViewController(withIdentifier: "EditEventView") as! EditEventView
        
        self.navigationController?.pushViewController(view, animated: true)
        view._eventid = _eventid
        view._event = _event
    }
    
    @IBAction func doSupprimer(_ sender: Any) {
        _controller.deleteEvent(_id: _eventid, success: successDelete)
        self.navigationController?.popToRootViewController(animated: true)
    }
    
    func successDelete() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez supprimer votre event.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
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
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
}
