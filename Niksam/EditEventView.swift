//
//  EditEventView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 29/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class EditEventView: UIViewController {
    var _eventid = String()
    var _controller = EditEventController()
    var _event = SingleEvent()
    
    @IBOutlet var _image: UIImageView!
    @IBOutlet var _title: UITextField!
    @IBOutlet var _description: UITextField!
    @IBOutlet var _date: UIDatePicker!
    @IBOutlet var _dateEnd: UIDatePicker!
    @IBOutlet var _prix: UITextField!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let checkedUrl = URL(string: _event.mainPhoto ) {
            _image.contentMode = .scaleAspectFit
            downloadImage(url: checkedUrl, image: _image )
        }
        _title.text = _event.title
        _description.text = _event.description
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

    @IBAction func doEdit(_ sender: Any) {
        let str = _controller.encode64image(image: _image.image!)
        
        print("test")
        
        _controller.editEvent(_id: _eventid, title: _title.text!, description: _description.text!, mainPhoto: str, dateStart: _date.date, dateEnd: _dateEnd.date, cost: _prix.text!, success: successEdit)
    }
    
    func successEdit() {
        let alert = UIAlertController(title: "Success", message: "Vous avez edite votre event.", preferredStyle: UIAlertControllerStyle.alert)
        alert.addAction(UIAlertAction(title: "Ok", style: UIAlertActionStyle.default, handler: nil))
        self.present(alert, animated: true, completion: nil)
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
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
