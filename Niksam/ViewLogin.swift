//
//  ViewController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 06/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON
import TextFieldEffects

class ViewLogin: UIViewController, UITextFieldDelegate {
    
    
    @IBOutlet var _email: JiroTextField!
    @IBOutlet var _password: JiroTextField!
    @IBOutlet var _login_button: UIButton!
    @IBOutlet var _create_button: UIButton!
    var _loginController = LoginController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _email.layer.cornerRadius = 5.0
        self._email.delegate = self
        _password.layer.cornerRadius = 5.0
        self._password.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    @IBAction func LoginButton(_ sender: Any) {
        let email = _email.text
        let password = _password.text
        
        if (email == "" || password == "") {
            return
        }
        
        _loginController.DoLogin(_email: email!, _psw: password!, success: successLogin, failure: failureLogin, failureEmail: failureEmail, failurePswd: failurePswd)
    }
    
    func successLogin() {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "TabBarView")
        SocketIOManager.sharedInstance.establishConnection()
        self.present(vc, animated: true, completion: nil)
    }
    
    func failureLogin() {
        let alert = UIAlertController(title: "Erreur", message: "Failed to login.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func failureEmail() {
        let alert = UIAlertController(title: "Erreur", message: "Bad Email.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func failurePswd() {
        let alert = UIAlertController(title: "Erreur", message: "Bad Password.", preferredStyle: UIAlertControllerStyle.alert)
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
