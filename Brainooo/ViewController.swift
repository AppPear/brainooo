//
//  ViewController.swift
//  Brainooo
//
//  Created by Samu András on 2018. 06. 11..
//  Copyright © 2018. Samu András. All rights reserved.
//

import UIKit
import PusherChatkit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
 
  var startTime:Double?
  var textField: UITextField?
  var currentUser: PCCurrentUser?
  var mediumImpactFeedbackGenerator: UIImpactFeedbackGenerator?

  @IBOutlet weak var messagesTable: UITableView!

  override func viewDidLoad() {
    super.viewDidLoad()
    messagesTable.register(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    messagesTable.dataSource = self
    
    let chatManager = initChatKit()
    connectToChat(chatManager: chatManager)
    Timer.scheduledTimer(withTimeInterval: 0.2, repeats: false) { (timer) in
      self.checkIfUserNameHasBeenSet()
    }
    if UIDevice.current.hasHapticFeedback {
      mediumImpactFeedbackGenerator = UIImpactFeedbackGenerator(style: .heavy)
    }
    mediumImpactFeedbackGenerator?.prepare()
  }
  
  @IBAction func sendMessage(_ sender: Any) {
    AppState.sendMessage(message: "mnana")
  }
  @IBAction func addFriend(_ sender: Any) {
    var alert = UIAlertController(title: "Add friend", message: "Write your friend's username", preferredStyle: UIAlertControllerStyle.alert)
    
    alert.addTextField(configurationHandler: configurationTextField)
    
    alert.addAction(UIAlertAction(title: "Add", style: UIAlertActionStyle.default, handler:{ (UIAlertAction) in
      guard let textField = alert.textFields?.first else {
        return
      }
      AppState.friendsList.append(textField.text!)
      DispatchQueue.main.async {
        self.messagesTable.reloadData()
      }
    }))
    
    self.present(alert, animated: true, completion: nil)
  }
  
  func configurationTextField(textField: UITextField!){
    textField.placeholder = "Username"
    
  }
  
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return AppState.friendsList.count
  }
  
  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
    print(indexPath.row)
    let message = AppState.friendsList[indexPath.row]
    cell.textLabel?.text = message
    return cell
  }
  
  func tableView(_ tableView: UITableView, didDeselectRowAt indexPath: IndexPath) {
    guard let currentCell = tableView.cellForRow(at: indexPath) else {
      return
    }
    print(currentCell.textLabel!.text!)
    print(indexPath.row)
    AppState.selectedName = currentCell.textLabel!.text!
    if let userNameView = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "SelectionView") as? SelectionView
    {
      present(userNameView, animated: true, completion: nil)
    }
  }
  
}

extension ViewController: PCRoomDelegate {
  
  func newMessage(message: PCMessage) {
    let splitted = message.text!.split(separator: "|")
    if(splitted[0] != AppState.getName()){
      if(splitted[1] == "l") {
        playLongSignal()
      }else{
        DispatchQueue.main.async {
          self.playShortSignal()
        }
      }
    }
    
  }
}
extension ViewController: PCChatManagerDelegate {}



