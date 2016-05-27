//
//  BonViewController.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

class BonViewController: NSViewController {
    
    @IBOutlet weak var infoTableView: NSTableView!
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    @IBOutlet weak var bonLoginView: BonLoginView!
    @IBOutlet weak var settingsButton: BonButton!
    
    var username: String = ""{
        didSet {
            usernameTextField.stringValue = username
            BonUserDefaults.username = username
        }
    }
    var password: String = ""{
        didSet {
            passwordTextField.stringValue = password
            BonUserDefaults.password = password
        }
    }
    
    var seconds: Int = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        view.layer?.backgroundColor = NSColor.bonHighlightColor().CGColor
        
        username = BonUserDefaults.username
        password = BonUserDefaults.password
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(getOnlineInfo), name: BonConfig.BonNotification.GetOnlineInfo, object: nil)
        
        getOnlineInfo()
        
    }
    
    @IBAction func onLoginButton(sender: AnyObject) {
        
        bonLoginView.show(.Loading)
        login()
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        
        bonLoginView.show(.Loading)
        forceLogout()
        
    }
    
    @IBAction func onSettingsButton(sender: BonButton) {
        SettingsMenuAction.makeSettingsMenu(sender)
    }

    
    func showLoginView() {
        bonLoginView.hidden = false
    }
    
    func hideLoginView() {
        bonLoginView.hidden = true
    }
    
    // MARK: - Network operation
    
    func login() {
        
        username = usernameTextField.stringValue
        password = passwordTextField.stringValue
        
        let parameters = [
            "action": "login",
            "username": username,
            "password": password,
            "ac_id": "1",
            "user_ip": "",
            "nas_ip": "",
            "user_mac": "",
            "save_me": "1",
            "ajax": "1"
        ]
        
        BonNetwork.post(parameters, success: { (value) in
            print(value)
            if value.containsString("login_ok,") {
                
                delay(1) {
                    self.getOnlineInfo()
                }
                delay(1) {
                    self.bonLoginView.show(.LoginSuccess)
                }
            } else if value.containsString("You are already online.") {
                self.forceLogout()
                self.login()
            } else if value.containsString("Password is error.") {
                delay(1) {
                    self.bonLoginView.show(.PasswordError)
                }
            } else if value.containsString("User not found.") {
                delay(1) {
                    self.bonLoginView.show(.UsernameError)
                }
            } else {
                delay(1) {
                    self.bonLoginView.show(.Error)
                }
            }
        }) { (error) in
            self.bonLoginView.show(.Timeout)
        }
    }
    
    
    // MARK : - logout
    
    func logout() {
        
        let parameters = [
            "action": "auto_logout"
        ]
        BonNetwork.post(parameters) { (value) in
            self.bonLoginView.hidden = false
        }
    }
    
    
    // TODO : - forcelogout
    //Parse response
    
    func forceLogout() {
        username = usernameTextField.stringValue
        password = passwordTextField.stringValue
        
        BonNetwork.updateLoginState()
        
        switch loginState {
            
        case .Offline:
            delay(1) {
                self.bonLoginView.showLoginState(.Offline)
            }
            
        case .Online:
            let parameters = [
                "action": "logout",
                "username": username,
                "password": password,
                "ajax": "1"
            ]
            
            BonNetwork.post(parameters) { (value) in
                print(value)
                delay(1) {
                    self.bonLoginView.show(.LogoutSuccess)
                }
            }
        }

    }
    
    // MARK : - get online info
    
    func getOnlineInfo() {
        
        let parameters = [
            "action": "get_online_info"
        ]
        
        BonNetwork.post(parameters, success: { (value) in
            
            NSLog(value)
            if(value == "not_online") {
                loginState = .Offline
                self.showLoginView()
            } else {
                self.hideLoginView()
                loginState = .Online
                print(value)
                let info = value.componentsSeparatedByString(",")
                self.seconds = Int(info[1])!
                
                self.itemsInfo = BonFormat.formatOnlineInfo(info)
                
                self.updateItems()
            }
            
        }) { (error) in
            loginState = .Offline
            self.showLoginView()
        }
    }
    
    var items = [BonItem]()
    var itemsInfo = [String]()
    let itemsName = ["username", "used Data", "used Time", "balance", "daily Available Data"]
    
    func updateItems() {
        self.items = []
        for index in 0...4 {
            let item = BonItem(name: itemsName[index], info: itemsInfo[index])
            items.append(item)
        }
        infoTableView.reloadData()
    }
    
}


// MARK: - Table view

extension BonViewController: NSTableViewDataSource {
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return items.count
    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        return BonCell.view(tableView, owner: self, subject: items[row])
    }
    
}

extension BonViewController: NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    
}