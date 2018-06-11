//
//  utils.swift
//  Brainooo
//
//  Created by Samu András on 2018. 06. 11..
//  Copyright © 2018. Samu András. All rights reserved.
//

import Foundation
import PusherChatkit

func initChatKit() -> ChatManager {
  return ChatManager(
    instanceLocator: "v1:us1:6303d77e-9e12-4ec3-ab73-afe3e65e3e0b",
    tokenProvider: PCTokenProvider(url: "https://us1.pusherplatform.io/services/chatkit_token_provider/v1/6303d77e-9e12-4ec3-ab73-afe3e65e3e0b/token"),
    userId: "brainooo"
  )
}

extension ViewController {
  func connectToChat(chatManager: ChatManager){
    chatManager.connect(delegate: self) { [unowned self] currentUser, error in
      guard error == nil else {
        print("Error connecting: \(error!.localizedDescription)")
        return
      }
      AppState.connected()
      print("Connected!")
      
      guard let currentUser = currentUser else { return }
      self.currentUser = currentUser
      currentUser.subscribeToRoom(room: currentUser.rooms[0], roomDelegate: self, messageLimit: 0)
    }
  }
  
  func sendMessage(message: String) {
    self.currentUser!.sendMessage(
      roomId: self.currentUser!.rooms.first!.id,
      text: AppState.getName() + "|" + message
    ) { messageId, error in
      guard error == nil else {
        print("Error sending message: \(error!.localizedDescription)")
        return
      }
    }
  }
  
  func checkIfUserNameHasBeenSet() {
    if (AppState.getName() == "default") {
      if let userNameView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "UserName") as? UserNameView
      {
        present(userNameView, animated: true, completion: nil)
      }
    }
  }
}
