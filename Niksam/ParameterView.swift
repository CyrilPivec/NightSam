//
//  ParameterView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 09/04/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class ParameterView: UIViewController {
    @IBOutlet var _km: UILabel!

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func slider(_ sender: UISlider) {
        _km.text = String(Int(sender.value)) + " km"
        let defaults = UserDefaults.standard
        defaults.set(Int(sender.value), forKey:"kmaffichage")
    }
    
    @IBAction func doLogout(_ sender: Any) {
        let storyboard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
        let vc: UIViewController = storyboard.instantiateViewController(withIdentifier: "ViewLogin")
        SocketIOManager.sharedInstance.closeConnection()
        self.present(vc, animated: true, completion: nil)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
}
