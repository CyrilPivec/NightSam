//
//  TabBarController.swift
//  Niksam
//
//  Created by Cyril PIVEC on 01/06/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let pro : Bool? = UserDefaults.standard.value(forKey: "ispro") as? Bool
        if (pro != true) {
            viewControllers?.remove(at: 1)
            viewControllers?.remove(at: 2)
        }
        if (pro == true) {
            viewControllers?.remove(at: 2)
            viewControllers?.remove(at: 0)
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
