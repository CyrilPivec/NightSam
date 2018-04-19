//
//  showSamView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 05/09/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class showSamView: UIViewController {
    var _id = String()
    var _idEvent = String()
    var _controller = showSamController()
    var _sams = [Participant]()
    var _samController = SamEventController()
    
    @IBOutlet var _rate: UITextField!
    @IBOutlet var _labelNote: UILabel!
    @IBOutlet var _commentaire: UITextField!
    @IBOutlet var _postCommente: UIButton!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print(_id)
        
//        _rate.isHidden = true
//        _labelNote.isHidden = true
//        _commentaire.isHidden = true
//        _postCommente.isHidden = true
        
    //    _samController.loadSam(_id: _idEvent, success: succes)
    }
    
//    func succes() {
//        
//        guard let username = UserDefaults.standard.value(forKey: "username") as? String else {
//            print("erreur 401")
//            return
//        }
//        
//        _sams = _samController.data
//        
//        for sam in _sams {
//            if (sam.username == username) {
//                _rate.isHidden = false
//                _labelNote.isHidden = false
//                _commentaire.isHidden = false
//                _postCommente.isHidden = false
//            }
//        }
//    }
    
    @IBAction func doSam(_ sender: Any) {
        _controller.getSeatSam(_id: _id, success: success)
    }
    
    func success() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez votre place.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func doCommenter(_ sender: Any) {
        _controller.postComment(_id: _id, success: successComment, note: _rate.text!, commentaire: _commentaire.text!)
    }
    
    func successComment() {
        let alert = UIAlertController(title: "Succès", message: "Vous avez commenté.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    @IBAction func showCommentSam(_ sender: Any) {
        let view: SamCommentView = self.storyboard?.instantiateViewController(withIdentifier: "SamCommentView") as! SamCommentView
        
        self.navigationController?.pushViewController(view, animated: true)
        view._id = _id
    }
    

}
