//
//  TapView.swift
//  Brainooo
//
//  Created by Samu András on 2018. 06. 12..
//  Copyright © 2018. Samu András. All rights reserved.
//

import UIKit
import PusherChatkit

class TapView: UIViewController {
  var startTime:Double?

  @IBOutlet weak var fingerImageView: UIImageView!
  @IBAction func touchDown(_ sender: Any) {
    startTime = Date().timeIntervalSinceReferenceDate
    fingerImageView.image = #imageLiteral(resourceName: "uj-down")
  }
  @IBAction func touchUp(_ sender: Any) {
    fingerImageView.image = #imageLiteral(resourceName: "uj")
    let elapsed = (Date().timeIntervalSinceReferenceDate - startTime!) * 100
    print(elapsed)
    if (AppState.checkConnectionState() == ConnectionState.Connected) {
      if (elapsed > 14) {
        AppState.sendMessage(message: "l")
      }else{
        AppState.sendMessage(message: "s")
      }
    }
  }
}
