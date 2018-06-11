//
//  UserNameView.swift
//  Brainooo
//
//  Created by Samu András on 2018. 06. 11..
//  Copyright © 2018. Samu András. All rights reserved.
//

import UIKit

class UserNameView: UIViewController,UITextFieldDelegate {
  
  @IBOutlet weak var nameField: UITextField!
  @IBAction func setName(_ sender: Any) {
    AppState.setName(name: nameField.text!)
    self.dismiss(animated: true, completion: nil)
  }
  override func viewDidLoad() {

  }
}
