//
//  Message.swift
//  Flash Chat
//
//  This is the model class that represents the blueprint for a message

class Message {
    
    //TODO: Messages need a messageBody and a sender variable
    var body : String = ""
    var sender : String = ""
    
    init(sender : String, body : String) {
        self.sender = sender
        self.body = body
    }
    
    
}
