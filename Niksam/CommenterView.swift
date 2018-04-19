//
//  CommenterView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 03/07/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class CommenterView: UIViewController {
    var _id = String()
    var _controller = CommenterController()
    
    @IBOutlet var _note: UITextField!
    @IBOutlet var _commentaire: UITextField!

    override func viewDidLoad() {
        super.viewDidLoad()

    }

    @IBAction func slider(_ sender: UISlider) {
        _note.text = String(Int(sender.value))
    }
    
    @IBAction func doCommenter(_ sender: Any) {
        _controller.postComment(_eventid: _id, success: success, note: _note.text!, commentaire: _commentaire.text!)
        
        self.navigationController?.popViewController(animated: true)
    }
    
    func success() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez commenté l'event.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
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
