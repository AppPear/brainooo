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
  var mediumImpactFeedbackGenerator: UIImpactFeedbackGenerator?
  var startTime:Double?
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let chatManager = initChatKit()
    connectToChat(chatManager: chatManager)
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
      self.checkIfUserNameHasBeenSet()
    }
  }
  
  @IBAction func touchDown(_ sender: Any) {
    startTime = Date().timeIntervalSinceReferenceDate
  }
  @IBAction func touchUp(_ sender: Any) {
    let elapsed = (Date().timeIntervalSinceReferenceDate - startTime!) * 100
   
  }
  
}

extension ViewController: PCRoomDelegate {
  func newMessage(message: PCMessage) {
    print("\(message.sender.id) sent \(message.text!)")
  }
}
extension ViewController: PCChatManagerDelegate {}




