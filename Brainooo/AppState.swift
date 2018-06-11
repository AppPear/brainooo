//
//  appState.swift
//  Brainooo
//
//  Created by Samu András on 2018. 06. 11..
//  Copyright © 2018. Samu András. All rights reserved.
//

import Foundation

enum ConnectionState {
  case NotConnected
  case Connected
}

class AppState {
  static private var name = "default"
  static private let defaults = UserDefaults.standard
  static private var connection = ConnectionState.NotConnected
  
  static public func connected() {
    AppState.connection = ConnectionState.Connected
  }
  
  static public func checkConnectionState() -> ConnectionState {
    return AppState.connection
  }
  
  static public func loadValues() {
    AppState.name = defaults.object(forKey: "userName") as? String ?? "default"
  }
  
  static public func setName(name: String) {
    AppState.name = name
    defaults.set(name, forKey: "userName")
  }
  
  static public func getName() -> String {
    return AppState.name
  }
  
}
