//
//  CommentView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 08/01/2018.
//  Copyright © 2018 Cyril PIVEC. All rights reserved.
//

import UIKit

class CommentView: UIViewController {
    var _id = String()
    var _participe = Bool()
    var _controller = CommentTableController()
    var _comments = [Comment]()
    
    @IBOutlet var _table: UITableView!
    @IBOutlet var _button: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self._table.dataSource = self
        self._table.delegate = self
        
        if (_participe == false) {
            self._button.isHidden = true
        } else {
            self._button.isHidden = false
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        _controller.data.removeAll()
        _controller.loadEvent(success: successLoad, _id: _id)
    }

    func successLoad() {
        _comments = _controller.data
       _table.reloadData()
    }
    
    @IBAction func _showCommenter(_ sender: Any) {
        let view: CommenterView = self.storyboard?.instantiateViewController(withIdentifier: "CommenterView") as! CommenterView
        
        self.navigationController?.pushViewController(view, animated: true)
        view._id = _id
    }

}

extension CommentView: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
}

extension CommentView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return _comments.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = Bundle.main.loadNibNamed("CommentCell", owner: self, options: nil)?.first as! CommentCell
        
        cell._comment.text = _comments[indexPath.row].comment
        cell._note.text = String(_comments[indexPath.row].note)
        return cell
    }
    
    
}
