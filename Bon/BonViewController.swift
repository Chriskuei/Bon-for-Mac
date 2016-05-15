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
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: #selector(getOnlineInfo), name: "GetOnlineInfo", object: nil)
        
        switch loginState {
        case .Online:
            getOnlineInfo()
            bonLoginView.hidden = true
        default:
            break;
        }
        
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
                
                delay(0.5) {
                    self.getOnlineInfo()
                }
                delay(1) {
                    self.bonLoginView.show(.LoginSuccess)
                }
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
        
        
        let parameters = [
            "action": "logout",
            "username": username,
            "password": password,
            "ajax": "1"
        ]
        
        BonNetwork.post(parameters) { (value) in
            print(value)
            self.bonLoginView.show(.LogoutSuccess)
        }
    }
    
    // MARK : - get online info
    
    func getOnlineInfo() {
        
        let parameters = [
            "action": "get_online_info"
        ]
        
        BonNetwork.post(parameters) { (value) in
            if(value == "not_online") {
                loginState = .Offline
            } else {
                loginState = .Online
                print(value)
                let info = value.componentsSeparatedByString(",")
                self.seconds = Int(info[1])!
                
                self.itemsInfo = BonFormat.formatOnlineInfo(self.username, info: info)
                
                self.updateItems()
            }
            
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
    
    func updateTime() {
        seconds = seconds + 1
        //        let date = NSDate()
        //        let formatter = NSDateFormatter()
        //        formatter.timeStyle = .MediumStyle
        //        timeLabel.text = formatter.stringFromDate(date)
    }

    func quit() {
        NSApplication.sharedApplication().terminate(self)
    }

    
}


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