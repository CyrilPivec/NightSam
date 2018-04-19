//
//  PutSamView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 26/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class PutSamView: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {
    var _id = String()
    var _controller = PutSamController()
    
    @IBOutlet var _leaveAt: UIDatePicker!
    @IBOutlet var _seat: UIPickerView!
    var seat = String()
    
    @IBOutlet var _radius: UITextField!
    
    
    var nbSeat = ["1", "2", "3", "4", "5", "6", "7", "8"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        _seat.delegate = self
        _seat.dataSource = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return nbSeat.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return nbSeat[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        seat = nbSeat[row]
    }
    
    @IBAction func doPutSam(_ sender: Any) {
        _controller.putSam(_eventid: _id, success: success, leaveAt: _leaveAt.date, seat: seat, radius: _radius.text!, echec: failure)
    }
    
    func failure() {
        let alert = UIAlertController(title: "Echec", message: "Vous n'êtes pas éligible sam.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    func success() {
        let alert = UIAlertController(title: "Succès", message: "Vous êtes sam.", preferredStyle: UIAlertControllerStyle.alert)
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
