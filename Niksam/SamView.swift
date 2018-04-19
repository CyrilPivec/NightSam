//
//  SamView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 24/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class SamView: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    @IBOutlet var _image: UIImageView!
    var _controller = SamController()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        _image.image = #imageLiteral(resourceName: "no-image")
    }
    
    @IBAction func chargeImage(_ sender: UITapGestureRecognizer) {
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
        _image.contentMode = .scaleAspectFit
        _image.image = selectedPhoto
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func uploadImage(_ sender: Any) {
        let str = _controller.encode64image(image: _image.image!)
        
        _controller.beSam(image: str, success: successEditPicture)
    }
    
    func successEditPicture() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez edité votre permis.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }

}
