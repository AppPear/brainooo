//
//  appState.swift
//  Brainooo
//
//  Created by Samu András on 2018. 06. 11..
//  Copyright © 2018. Samu András. All rights reserved.
//

import Foundation
import PusherChatkit
import AudioToolbox.AudioServices

enum ConnectionState {
  case NotConnected
  case Connected
}

class AppState: NSObject, PCChatManagerDelegate {
  static private var name = "default"
  static private let defaults = UserDefaults.standard
  static private var connection = ConnectionState.NotConnected
  static public var selectedName: String? = nil
  static public var friendsList = [String]()
  static public var currentUser: PCCurrentUser? = nil
  static public func connected() {
    AppState.connection = ConnectionState.Connected
  }

  static public func checkConnectionState() -> ConnectionState {
    return AppState.connection
  }
  
  static public func loadValues() {
    AppState.name = defaults.object(forKey: "userName") as? String ?? "default"
    AppState.friendsList = defaults.object(forKey: "friendList") as? [String] ?? [String]()
  }
  
  static public func setName(name: String) {
    AppState.name = name
    defaults.set(name, forKey: "userName")
  }
  
  static public func getName() -> String {
    return AppState.name
  }
  
  static public func saveValues() {
    defaults.set(friendsList, forKey: "friendList")
  
  }
  
  static public func sendMessage(message: String) {
    AppState.currentUser!.sendMessage(
      roomId: AppState.currentUser!.rooms.first!.id,
      text: AppState.getName() + "|" + message
    ) { messageId, error in
      guard error == nil else {
        print("Error sending message: \(error!.localizedDescription)")
        return
      }
    }
  }

  
}

