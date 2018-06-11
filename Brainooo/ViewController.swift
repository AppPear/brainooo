//
//  ViewController.swift
//  Brainooo
//
//  Created by Samu András on 2018. 06. 11..
//  Copyright © 2018. Samu András. All rights reserved.
//

import UIKit
import PusherChatkit

class ViewController: UIViewController {
  var currentUser: PCCurrentUser?
  var messages: [PCMessage] = []
  var defaultFrame: CGRect!
  
  @IBAction func sendMessageButton(_ sender: Any) {
    self.currentUser!.sendMessage(
      roomId: self.currentUser!.rooms.first!.id,
      text: self.messageInput.text!
    ) { messageId, error in
      guard error == nil else {
        print("Error sending message: \(error!.localizedDescription)")
        return
      }
      print("Message sent!")
    }
    self.messageInput.text!.removeAll()
  }
  
  @IBOutlet weak var messageInput: UITextField!
  @IBOutlet weak var messagesTable: UITableView!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    messagesTable.transform = CGAffineTransform(scaleX: 1, y: -1)
    defaultFrame = self.view.frame
    NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillShow), name: .UIKeyboardWillShow, object: nil)
    NotificationCenter.default.addObserver(self, selector: #selector(keyBoardWillHide), name: .UIKeyboardWillHide, object: nil)
    
    messagesTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    messagesTable.dataSource = self
    
    let chatManager = initChatKit()
    
    chatManager.connect(delegate: self) { [unowned self] currentUser, error in
      guard error == nil else {
        print("Error connecting: \(error!.localizedDescription)")
        return
      }
      print("Connected!")
      
      guard let currentUser = currentUser else { return }
      self.currentUser = currentUser
      
      currentUser.subscribeToRoom(room: currentUser.rooms[0], roomDelegate: self)
    }
  }
  
  func moveViewsWithKeyboard(height: CGFloat) {
    self.view.frame = defaultFrame.offsetBy(dx: 0, dy: height)
  }
  
  @objc func keyBoardWillShow(notification: NSNotification) {
    let frame = (notification.userInfo![UIKeyboardFrameEndUserInfoKey] as! NSValue).cgRectValue
    moveViewsWithKeyboard(height: -frame.height)
  }
  
  @objc func keyBoardWillHide(notification: NSNotification) {
    moveViewsWithKeyboard(height: 0)
  }
}

extension ViewController: PCChatManagerDelegate {}

extension ViewController: PCRoomDelegate {
  func newMessage(message: PCMessage) {
    print("\(message.sender.id) sent \(message.text!)")
    messages.insert(message, at: 0)
    DispatchQueue.main.async {
      self.messagesTable.reloadData()
    }
  }
}

extension ViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return messages.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    cell.contentView.transform = CGAffineTransform(scaleX: 1, y: -1)
    let message = self.messages[indexPath.row]
    cell.textLabel?.text = "\(message.sender.displayName): \(message.text!)"
    return cell
  }
}

