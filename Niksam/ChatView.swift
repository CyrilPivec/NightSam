//
//  ChatView.swift
//  Niksam
//
//  Created by Cyril PIVEC on 11/10/2017.
//  Copyright © 2017 Cyril PIVEC. All rights reserved.
//

import UIKit

class ChatView: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextViewDelegate, UIGestureRecognizerDelegate {
    
    @IBOutlet weak var tvChat: UITableView!
    @IBOutlet weak var txtMessageEditor: UITextView!
    @IBOutlet weak var conBottomEditor: NSLayoutConstraint!
    
    var _id = String()
    let chatCtrl = ChatController()
    let username = UserDefaults.standard.value(forKey: "username") as? String
    var originY: CGFloat = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        chatCtrl.getPreviousMessage(_id: _id, success: successGetMessage)
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillShow), name: .UIKeyboardWillShow, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardWillHide), name: .UIKeyboardWillHide, object: nil)
        
        configureTableView()
        
//        txtMessageEditor.delegate = self
//        let swipeGestureRecognizer = UISwipeGestureRecognizer(target: self, action: #selector(dismissKeyboard))
//        swipeGestureRecognizer.direction = UISwipeGestureRecognizerDirection.down
//        swipeGestureRecognizer.delegate = self
//        view.addGestureRecognizer(swipeGestureRecognizer)
        
        originY = view.frame.origin.y
    }
    
    //hide
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return (true)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        
        SocketIOManager.sharedInstance.getChatMessage { (messageInfo) -> Void in
            DispatchQueue.main.async(execute: {
                let msg = messageInfo["msg"] as! String
                let sender = messageInfo["sender"] as! String
                let isPro = messageInfo["isPro"] as! Bool
                let createdAt = Date().getTime()
                let info = ChatInfo(sender: sender, isPro: isPro, msg: msg, createdAt: createdAt)
                self.chatCtrl.messages.append(info)
                self.successGetMessage()
            })
        }
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        SocketIOManager.sharedInstance.enterChat(eventId: _id)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        SocketIOManager.sharedInstance.quitChat()
    }
    
    @IBAction func sendMessage(_ sender: UIButton) {
        if txtMessageEditor.text.characters.count > 0 {
            print(txtMessageEditor.text)
            SocketIOManager.sharedInstance.sendMessage(msg: txtMessageEditor.text)
            txtMessageEditor.text = ""
            txtMessageEditor.resignFirstResponder()
        }
    }
    
    func handleKeyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo {
            if let keyboardFrame = (userInfo[UIKeyboardFrameBeginUserInfoKey] as? NSValue)?.cgRectValue {
                view.frame.origin.y -= keyboardFrame.height
                view.layoutIfNeeded()
            }
        }
    }
    
    func handleKeyboardWillHide(notification: Notification) {
        view.frame.origin.y = originY
        view.layoutIfNeeded()
    }

    // MARK: Custom Methods
    
    func configureTableView() {
        tvChat.delegate = self
        tvChat.dataSource = self
        tvChat.register(UINib(nibName: "ChatCell", bundle: nil), forCellReuseIdentifier: "idCellChat")
        tvChat.estimatedRowHeight = 90.0
        tvChat.rowHeight = UITableViewAutomaticDimension
        tvChat.tableFooterView = UIView(frame: .zero)
    }
    
    func tableViewScrollToBottom(animated: Bool) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .milliseconds(300)) {
            let numberOfSections = self.tvChat.numberOfSections
            let numberOfRows = self.tvChat.numberOfRows(inSection: numberOfSections-1)
            if numberOfRows > 0 {
                let indexPath = IndexPath(row: numberOfRows - 1, section: (numberOfSections-1))
                self.tvChat.scrollToRow(at: indexPath, at: .bottom, animated: animated)
            }
        }
    }
    
    func successGetMessage() {
        tvChat.reloadData()
        tableViewScrollToBottom(animated: true)
    }
    
    // MARK: UITableView Delegate and Datasource Methods
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return chatCtrl.messages.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "idCellChat", for: indexPath) as! ChatCell
        let message = chatCtrl.messages[indexPath.row]
        let senderUsername = message.sender
        cell.lblMessage.text = message.msg
        cell.lblMessage.textColor = UIColor.darkGray
        let createdAt = message.createdAt
        let date = (createdAt.count > 5 ? (createdAt.dateFromISO8601?.timeAgoSinceDate(numericDates: false))! : "à \(createdAt)")
        cell.lblMessageDetail.text = "Par \(senderUsername) \(date)"
        
        if senderUsername == username {
            cell.lblMessage.textAlignment = .right
            cell.lblMessageDetail.textAlignment = .right
        } else {
            cell.lblMessage.textAlignment = .left
            cell.lblMessageDetail.textAlignment = .left
        }
        return cell
    }
    
//    func dismissKeyboard() {
//        if txtMessageEditor.isFirstResponder {
//            txtMessageEditor.resignFirstResponder()
//        }
//    }
}
