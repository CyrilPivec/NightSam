//
//  CreateAccountViewController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 08/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit
import TwicketSegmentedControl
import TextFieldEffects

class CreateView: UIViewController, UITextFieldDelegate {
    
    var controller = CreateController()

    @IBOutlet var segmentedControl: TwicketSegmentedControl!
    let titles = ["Utilisateur", "Professionel"]
    
    @IBOutlet var userView: UIView!
    @IBOutlet var proView: UIView!
    
    @IBOutlet var userEmail: JiroTextField!
    @IBOutlet var userName: JiroTextField!
    @IBOutlet var userPassword: JiroTextField!
    @IBOutlet var userSex: UISegmentedControl!
    @IBOutlet var userBirthday: UIDatePicker!
    
    @IBOutlet var proEmail: JiroTextField!
    @IBOutlet var proPassword: JiroTextField!
    @IBOutlet var proName: JiroTextField!
    @IBOutlet var proAdresse: JiroTextField!
    @IBOutlet var proVille: JiroTextField!
    @IBOutlet var proZip: JiroTextField!
    @IBOutlet var proPays: JiroTextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        segmentedControl.setSegmentItems(titles)
        segmentedControl.delegate = self
        segmentedControl.move(to: 0)
        self.userView.isHidden = false
        self.proView.isHidden = true

        userEmail.layer.cornerRadius = 5.0
        self.userEmail.delegate = self
        userName.layer.cornerRadius = 5.0
        self.userName.delegate = self
        userPassword.layer.cornerRadius = 5.0
        self.userPassword.delegate = self
        proEmail.layer.cornerRadius = 5.0
        self.proEmail.delegate = self
        proName.layer.cornerRadius = 5.0
        self.proName.delegate = self
        proPassword.layer.cornerRadius = 5.0
        self.proPassword.delegate = self
        proAdresse.layer.cornerRadius = 5.0
        self.proAdresse.delegate = self
        proVille.layer.cornerRadius = 5.0
        self.proVille.delegate = self
        proZip.layer.cornerRadius = 5.0
        self.proZip.delegate = self
        proPays.layer.cornerRadius = 5.0
        self.proPays.delegate = self
        
    }
    
    //hide keyboard
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }

    //userview
    @IBAction func userCreate(_ sender: Any) {
        
        if checkUser() == 1 {
            return
        }
        
        //get sex
        var sex = String()
        if userSex.selectedSegmentIndex == 0 {
            sex = "M"
        } else {
            sex = "F"
        }
        
        //get date
        var date = String()
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd"
        date = formatter.string(from: userBirthday.date)
        
        controller.createUser(_email: userEmail.text!, _password: userPassword.text!, _username: userName.text!, _sex: sex, _birthday: date, success: successRegister, failure: failureRegister, failureEmail: failureRegisterEmail)
    }
    
    func successRegister() {
        let alert = UIAlertController(title: "Succès", message: "Votre compte à bien été crée.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "ViewLogin")
        self.present(vc, animated: true, completion: nil)
    }
    
    func failureRegister() {
        let alert = UIAlertController(title: "Erreur", message: "Echec dans la création du compte.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func failureRegisterEmail() {
        let alert = UIAlertController(title: "Erreur", message: "Email ou Username déjà utilisé.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkUser() -> Int {
        
        // check empty
        if userEmail.text! == "" || userName.text! == "" || userPassword.text! == "" {
            let alert = UIAlertController(title: "Erreur", message: "Champ obligatoire manquant.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 1
        }
        
        // check password 6
        let str = userPassword.text
        if (str?.characters.count)! < 6 {
            let alert = UIAlertController(title: "Erreur", message: "Password minimum 6 characters.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 1
        }
        
        // check addresse mail
        if isValidEmail(testStr: userEmail.text!) == false {
            let alert = UIAlertController(title: "Erreur", message: "Invalide email.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 1
        }
        
        // check age
        let gregorian = Calendar(identifier: .gregorian)
        let ageComponents = gregorian.dateComponents([.year], from: userBirthday.date, to: Date())
        let age = ageComponents.year!
        if age < 18 {
            let alert = UIAlertController(title: "Erreur", message: "Vous devez avoir 18 ans.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 1
        }
        
        
        return 0
    }
    
    //proview
    @IBAction func proCreate(_ sender: Any) {
        
        if checkPro() == 1 {
            return
        }
        
        print("test")
        
        controller.checkAdresse(_country: proPays.text!, _ville: proVille.text!, _adresse: proAdresse.text!, success: successAdresse, failure: failureAdresse)
        
        controller.createPro(_email: proEmail.text!, _password: proPassword.text!, _username: proName.text!, _adresse: proAdresse.text!, _zip: proZip.text!, _city: proVille.text!, _country: proPays.text!, success: success, failure: failure, failureEmail: failureEmail)
    }
    
    func successAdresse() {
        controller.createPro(_email: proEmail.text!, _password: proPassword.text!, _username: proName.text!, _adresse: proAdresse.text!, _zip: proZip.text!, _city: proVille.text!, _country: proPays.text!, success: successRegister, failure: failureRegister, failureEmail: failureRegisterEmail)
    }
    
    func failureEmail() {
        let alert = UIAlertController(title: "Erreur", message: "Mauvaise adresse mail deja utiliser.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func failure() {
        let alert = UIAlertController(title: "Erreur", message: "Erreur introuvable.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func success() {
        let alert = UIAlertController(title: "Succès", message: "Creation réussi.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func failureAdresse() {
        let alert = UIAlertController(title: "Erreur", message: "Mauvaise adresse ou adresse introuvable.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func checkPro() -> Int {
        
        // check pro empty
        if proEmail.text! == "" || proName.text! == "" || proPassword.text! == "" || proAdresse.text! == "" || proVille.text! == "" || proZip.text! == "" || proPays.text! == "" {
            let alert = UIAlertController(title: "Erreur", message: "Champ obligatoire manquant.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 1
        }
        
        // check password 6
        let str = proPassword.text
        if (str?.characters.count)! < 6 {
            let alert = UIAlertController(title: "Erreur", message: "Password minimum 6 characters.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 1
        }
        
        // check pro email
        if isValidEmail(testStr: proEmail.text!) == false {
            let alert = UIAlertController(title: "Erreur", message: "Invalide email.", preferredStyle: UIAlertControllerStyle.alert)
            alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
            self.present(alert, animated: true, completion: nil)
            return 1
        }
        
        return 0
    }
    
    func isValidEmail(testStr:String) -> Bool {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,}"
        
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluate(with: testStr)
    }
    
}

extension CreateView: TwicketSegmentedControlDelegate {
    func didSelect(_ segmentIndex: Int) {
        
        switch segmentIndex {
        case 0:
            self.userView.isHidden = false
            self.proView.isHidden = true
        case 1:
            self.userView.isHidden = true
            self.proView.isHidden = false
        default:
            self.userView.isHidden = true
            self.proView.isHidden = true
        }
        
    }
}

/* @IBOutlet var _username: UITextField!
 @IBOutlet var _email: UITextField!
 @IBOutlet var _password: UITextField!
 @IBOutlet var _creat_but: UIButton!
 @IBOutlet var _isPro: UISwitch!
 var _createController = CreateController()*/

/*  @IBAction func isPro(_ sender: UISwitch) {
 }
 
 override func didReceiveMemoryWarning() {
 super.didReceiveMemoryWarning()
 // Dispose of any resources that can be recreated.
 }
 
 @IBAction func CreateBut(_ sender: Any) {
 let username = _username.text
 let email = _email.text
 let password = _password.text
 let pro = _isPro.isOn
 
 if (username == "" || email == "" || password == "") {
 return
 }
 _createController.DoCreate(_username: username!, _email: email!, _password: password!, _pro: pro,success: successRegister, failure: failureRegister, failureEmail: failureRegisterEmail, failurePassword: failureRegisterPassword)
 }
 
 func successRegister() {
 let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
 let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "ViewLogin")
 self.present(vc, animated: true, completion: nil)
 }
 
 func failureRegisterEmail() {
 let alert = UIAlertController(title: "Erreur", message: "Email ou Username déjà utilisé.", preferredStyle: UIAlertControllerStyle.alert)
 alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
 self.present(alert, animated: true, completion: nil)
 }
 
 func failureRegisterPassword() {
 let alert = UIAlertController(title: "Erreur", message: "Email ou Password mauvais format 6 charactere minimum.", preferredStyle: UIAlertControllerStyle.alert)
 alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
 self.present(alert, animated: true, completion: nil)
 }
 
 func failureRegister() {
 let alert = UIAlertController(title: "Erreur", message: "Failed to register.", preferredStyle: UIAlertControllerStyle.alert)
 alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
 self.present(alert, animated: true, completion: nil)
 }*/
