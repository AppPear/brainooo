//
//  SelectionView.swift
//  Brainooo
//
//  Created by Samu András on 2018. 06. 12..
//  Copyright © 2018. Samu András. All rights reserved.
//

import UIKit

class SelectionView: UIViewController {
  
  override func viewDidLoad() {
    print(AppState.selectedName)
  }
  @IBAction func CheatSheet(_ sender: Any) {
    if let userNameView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "CheatSheetView") as? CheatSheetView
    {
      present(userNameView, animated: true, completion: nil)
    }
  }
  @IBAction func Tap(_ sender: Any) {
    if let userNameView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "TapView") as? TapView
    {
      present(userNameView, animated: true, completion: nil)
    }
  }
  
}
