//
//  utils.swift
//  Brainooo
//
//  Created by Samu András on 2018. 06. 11..
//  Copyright © 2018. Samu András. All rights reserved.
//

import Foundation
import PusherChatkit
import AudioToolbox.AudioServices

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
  
  func playShortSignal() {
    if UIDevice.current.hasHapticFeedback {
      mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .light)
    }
    mediumImpactFeedbackGenerator?.prepare()
    
    if UIDevice.current.hasHapticFeedback {
      mediumImpactFeedbackGenerator?.impactOccurred()
    } else if UIDevice.current.hasTapticEngine {
      // Fallback for older devices
      let peek = SystemSoundID(1520)
      AudioServicesPlaySystemSound(peek)
    }
  }
  
  func playLongSignal() {
//    if UIDevice.current.hasHapticFeedback {
//      mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
//    }
//    mediumImpactFeedbackGenerator?.prepare()
//
//    if UIDevice.current.hasHapticFeedback {
//      mediumImpactFeedbackGenerator?.impactOccurred()
//    } else if UIDevice.current.hasTapticEngine {
//      // Fallback for older devices
//      let pop = SystemSoundID(1520)
//      AudioServicesPlaySystemSound(pop)
//    }
    AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))

  }
}

extension UIDevice {
  enum DevicePlatform: String {
    case other = "Old Device"
    case iPhone6S = "iPhone 6S"
    case iPhone6SPlus = "iPhone 6S Plus"
    case iPhone7 = "iPhone 7"
    case iPhone7Plus = "iPhone 7 Plus"
  }
  
  var platform: DevicePlatform {
    get {
      var sysinfo = utsname()
      uname(&sysinfo)
      let platform = String(bytes: Data(bytes: &sysinfo.machine, count: Int(_SYS_NAMELEN)), encoding: .ascii)!.trimmingCharacters(in: .controlCharacters)
      switch platform {
      case "iPhone9,2", "iPhone9,4":
        return .iPhone7Plus
      case "iPhone9,1", "iPhone9,3":
        return .iPhone7
      case "iPhone8,2":
        return .iPhone6SPlus
      case "iPhone8,1":
        return .iPhone6S
      default:
        return .other
      }
    }
  }
  
  var hasTapticEngine: Bool {
    get {
      return platform == .iPhone6S || platform == .iPhone6SPlus ||
        platform == .iPhone7 || platform == .iPhone7Plus
    }
  }
  
  var hasHapticFeedback: Bool {
    get {
      return platform == .iPhone7 || platform == .iPhone7Plus
    }
  }
}
