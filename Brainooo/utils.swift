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
