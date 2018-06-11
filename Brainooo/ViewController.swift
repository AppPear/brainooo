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
  
  @IBAction func sendMessageButton(_ sender: Any) {
    sendMessage(message: "a")
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let chatManager = initChatKit()
    connectToChat(chatManager: chatManager)
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
      self.checkIfUserNameHasBeenSet()
    }
  }
  
}

extension ViewController: PCRoomDelegate {
  func newMessage(message: PCMessage) {
    print("\(message.sender.id) sent \(message.text!)")
  }
}
extension ViewController: PCChatManagerDelegate {}




