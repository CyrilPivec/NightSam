//
//  SamCommentView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 07/09/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class SamCommentView: UITableViewController {

    var _id = String()
    var _controller = SamCommentController()
    var _comments = [Comment]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

    }
    
    override func viewWillAppear(_ animated: Bool) {
        _controller.data.removeAll()
        _controller.loadEvent(success: successLoad, _id: _id)
    }
    
    func successLoad() {
        _comments = _controller.data
        tableView.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _comments.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("SamCommentViewCell", owner: self, options: nil)?.first as! SamCommentViewCell
        
        cell._commentaire.text = _comments[indexPath.row].comment
        cell._rate.text = String(_comments[indexPath.row].note)
        return cell
    }
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }

}
