//
//  BonViewController.swift
//  Bon
//
//  Created by Chris on 16/5/14.
//  Copyright © 2016年 Chris. All rights reserved.
//

import Cocoa

class BonViewController: NSViewController {
    
    @IBOutlet weak var usernameTextField: NSTextField!
    @IBOutlet weak var passwordTextField: NSSecureTextField!
    
    @IBOutlet weak var bonLoginView: BonLoginView!
    @IBOutlet weak var loginButton: NSButton!
    
    @IBOutlet weak var loadingIndicator: NSProgressIndicator!
    
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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.wantsLayer = true
        
        view.layer?.backgroundColor = NSColor.grayColor().CGColor
        
        username = BonUserDefaults.username
        password = BonUserDefaults.password
    }
    
    func showPopover() {
        //popover.showRelativeToRect(button.bounds, ofView: button, preferredEdge: NSRectEdge.MinY)
    }
    
    @IBAction func onLoginButton(sender: AnyObject) {
        loadingIndicator.hidden = false
        loadingIndicator.startAnimation(sender)
        
        self.login()
    }
    
    @IBAction func onLogoutButton(sender: AnyObject) {
        
        delay(2.0) {
            self.forceLogout()
        }
        
    }
    
    @IBAction func onSettingsButton(sender: BonButton) {
        SettingsMenuAction.makeSettingsMenu(sender)
    }

    //    @IBAction func onHelpCenterButton(sender: AnyObject) {
    //        let url : NSURL = NSURL(string: BIT.URL.HelpCenter)!
    //        if NSApplication.sharedApplication().canOpenURL(url) {
    //            NSApplication.sharedApplication().openURL(url)
    //        }
    //    }
    
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
                self.getOnlineInfo()
                delay(1) {
                    self.loadingIndicator.stopAnimation(nil)
                    self.bonLoginView.hidden = true
                }
            } else {
                self.loadingIndicator.stopAnimation(nil)
            }
        }) { (error) in
            self.loadingIndicator.stopAnimating(nil)
        }
    }
    
    
    // MARK : - logout
    
    func logout() {
        
        let parameters = [
            "action": "auto_logout"
        ]
        BonNetwork.post(parameters) { (value) in
            //            BonAlert.alert(title: "Logout Success", message: "Aha! You are offline now.", dismissTitle: "OK", inViewController: self, withDismissAction: nil)
        }
    }
    
    
    // MARK : - forcelogout
    
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
            self.loadingIndicator.stopAnimation(nil)
        }
    }
    
    // MARK : - get online info
    
    func getOnlineInfo() {
        
        let parameters = [
            "action": "get_online_info"
        ]
        
        BonNetwork.post(parameters) { (value) in
            print(value)
            let info = value.componentsSeparatedByString(",")
            
            let usedData = Double(info[0])!
            BonUserDefaults.usedData = usedData
            
            let seconds = Int(info[1])!
            BonUserDefaults.seconds = seconds
            
            let balance = Double(info[2])!
            BonUserDefaults.balance = balance
            
            let key = ["connectionTime", "inFlow", "outFlow", "usableFlow", "unknown1", "unknown2", "unknown3", "username"]
            
            let userInformation: [String: String] = {
                var dict = Dictionary<String, String>()
                for index in 0...7 {
                    dict[key[index]] = info[index]
                }
                return dict
            }()

        }
    }
    
    var items = [AnyObject]() // 数据列表，包括
    let format = NSDateFormatter() // 格式化更新时间
    
    
}

extension BonViewController {
    
}
extension BonViewController: NSTableViewDataSource {
    
    func numberOfRowsInTableView(aTableView: NSTableView) -> Int {
        return 0
    }
    
//    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
//        loadOlderIfNeeded(row) // 判断是否需要加载更早的数据
//        return BonSectionCell.view(tableView, owner: self, subject: items[row]) ?? GankItemCell.view(tableView, owner: self, subject: items[row])
//    }
    
    func tableView(tableView: NSTableView, viewForTableColumn tableColumn: NSTableColumn?, row: Int) -> NSView? {
        let cellView = tableView.makeViewWithIdentifier(tableColumn!.identifier, owner: tableView) as! BonCell
        //cellView.configureData(self.model[row])
        return cellView
    }
    
    private func loadOlderIfNeeded(row: Int) {
        if items.count - row == 1 { // ph设置的值是15，我这里设置的是下拉到底时才触发加载新数据，节省流量
            NSNotificationCenter.defaultCenter().postNotificationName("Reload", object: nil)
        }
    }
    
}

// 列表的动作代理
extension BonViewController: NSTableViewDelegate {
    
    func tableView(tableView: NSTableView, isGroupRow row: Int) -> Bool {
        return (items[row] as? String) != nil // 显示日期的是GroupRow
    }
    
    func tableView(tableView: NSTableView, heightOfRow row: Int) -> CGFloat {
        return (items[row] as? String) != nil ? 45 : tableView.rowHeight // GroupRow高度是45
    }
    
    func tableView(tableView: NSTableView, shouldSelectRow row: Int) -> Bool {
        return true
    }
    
}