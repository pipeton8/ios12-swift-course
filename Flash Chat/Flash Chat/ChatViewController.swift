//
//  ViewController.swift
//  Flash Chat
//
//  Created by Angela Yu on 29/08/2015.
//  Copyright (c) 2015 London App Brewery. All rights reserved.
//

import UIKit
import Firebase


class ChatViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UITextFieldDelegate {
    
    // Declare instance variables here
    let CUSTOM_MESSAGE_CELL = "customMessageCell"
    let CUSTOM_MESSAGE_XIB = "MessageCell"
    let MESSAGES_DATABASE_REFERENCE = "Messages"
    let ESTIMATED_ROW_HEIGHT : CGFloat = 120.0
    let SEND_HEIGHT_OFFSET : CGFloat = 10.0
    let KEYBOARD_ANIMATION_TIME : TimeInterval = 0.23
    let SEND_MESSAGE_HEIGHT : CGFloat = 50.0
    
    var messageArray : [Message] = [Message]()
    
    // We've pre-linked the IBOutlets
    @IBOutlet var heightConstraint: NSLayoutConstraint!
    @IBOutlet var sendButton: UIButton!
    @IBOutlet var messageTextfield: UITextField!
    @IBOutlet var messageTableView: UITableView!
    
    fileprivate func AddKeyboardObservers() {
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillHide),
            name: UIResponder.keyboardWillHideNotification,
            object: nil
        )
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        AddKeyboardObservers()
    }
    
    fileprivate func ConformToProtocols() {
        messageTableView.dataSource = self
        messageTableView.delegate = self
        messageTextfield.delegate = self
    }
    
    fileprivate func ConfigureTapGesture() {
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(TableViewTapped))
        messageTableView.addGestureRecognizer(tapGesture)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.hidesBackButton = true
        ConformToProtocols()
        ConfigureTapGesture()
        ConfigureTableView()
        RetrieveMessages()
    }

    ///////////////////////////////////////////
    
    //MARK: - TableView DataSource Methods
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: CUSTOM_MESSAGE_CELL, for : indexPath) as! CustomMessageCell
        let messageToDisplay = messageArray[indexPath.row]
        cell.messageBody.text = messageToDisplay.messageBody
        cell.senderUsername.text = messageToDisplay.sender
        cell.avatarImageView.image = UIImage(named: "egg")
        
        return cell
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return messageArray.count
    }
    
    @objc func TableViewTapped() {
        DismissKeyboard()
    }
    
    func ConfigureTableView() {
        messageTableView.register(UINib(nibName: CUSTOM_MESSAGE_XIB, bundle: nil), forCellReuseIdentifier: CUSTOM_MESSAGE_CELL)
        messageTableView.rowHeight = UITableView.automaticDimension
        messageTableView.estimatedRowHeight = ESTIMATED_ROW_HEIGHT
    }
    
    ///////////////////////////////////////////
    
    //MARK:- TextField and Keyboard Methods
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        DismissKeyboard()
        RequestSendMessage()
        return true
    }
    
    fileprivate func AnimateKeyboard() {
        UIView.animate(withDuration: KEYBOARD_ANIMATION_TIME) { self.view.layoutIfNeeded() }
    }
    
    fileprivate func GetKeyboardHeight(_ notification : Notification) -> CGFloat {
        let keyboardFrame: NSValue = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)!
        return keyboardFrame.cgRectValue.height
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        let KEYBOARD_HEIGHT = GetKeyboardHeight(notification)
        heightConstraint.constant = KEYBOARD_HEIGHT + SEND_HEIGHT_OFFSET
        AnimateKeyboard()
    }
    
    @objc func keyboardWillHide(_ notification: Notification) {
        heightConstraint.constant = SEND_MESSAGE_HEIGHT
        AnimateKeyboard()
    }
    
    ///////////////////////////////////////////

    //MARK: - Send & Recieve from Firebase
    
    
    
    
    
    fileprivate func DismissKeyboard() {
        messageTextfield.endEditing(true)
        messageTextfield.resignFirstResponder()
    }
    
    @IBAction func sendPressed(_ sender: AnyObject) {
        DismissKeyboard()
        RequestSendMessage()
        
        
    }

    fileprivate func RequestSendMessage() {
        if messageTextfield.text == nil || messageTextfield.text! == "" { return }
        
        DisableInputs()
        
        let messagesDB = Database.database().reference().child(MESSAGES_DATABASE_REFERENCE)
        let messageDict = ["sender" : Auth.auth().currentUser?.email, "messageBody" : messageTextfield.text!]
        
        messagesDB.childByAutoId().setValue(messageDict) {
            (error, reference) in
            if error != nil {
                print(error!)
            } else {
                print("Message sent successfully")
            }
        }
        
        
        RestoreInputs()
    }
    
    fileprivate func DisableInputs() {
        messageTextfield.isEnabled = false
        sendButton.isEnabled = false
    }
    
    fileprivate func RestoreInputs() {
        messageTextfield.isEnabled = true
        messageTextfield.text = ""
        sendButton.isEnabled = true
    }

    fileprivate func RetrieveMessages() {
        let messageDB = Database.database().reference().child(MESSAGES_DATABASE_REFERENCE)
        
        messageDB.observe(.childAdded) {
            (snapshot) in
            let snapshotValue = snapshot.value as! Dictionary<String,String>
            let message : Message = Message(sender : snapshotValue["sender"]!, body : snapshotValue["messageBody"]!)
            self.messageArray.append(message)
            self.ConfigureTableView()
            self.messageTableView.reloadData()
        }
        
    }
    
    @IBAction func logOutPressed(_ sender: AnyObject) {
        do {
            try Auth.auth().signOut()
            navigationController?.popToRootViewController(animated: true)
        } catch let error {
            print(error)
        }
    }
}
