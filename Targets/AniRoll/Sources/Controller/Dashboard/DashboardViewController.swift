//
//  DashboardViewController.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/22/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class DashboardViewController: UIViewController, WSUserDelegate {
    
    let wsUser = WSUser()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.wsUser.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let accessToken = App.shared.accessToken, accessToken.expirationDate > Date() else {
            self.dismiss(animated: true, completion: nil)
            return
        }
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LoadingActivity.show(text: "Downloading...", disableUI: true)
        self.wsUser.getUser(id: "zyrx")
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }
    
    // MARK: - WSUserDelegate
    func wsUserDelegate(user: User?) {
        LoadingActivity.hide()
        guard let user = user else {
             AlertController.alert(title: "", message: "The user doesn't exist. Please try again.")
            return
        }
        do {
            let realm = try Realm(configuration: App.shared.realmConfiguration)
            try realm.write {
                realm.add(user)
            }
        } catch {
             AlertController.alert(title: "", message: "The application encountered an internal error or misconfiguration and was unable to complete your request.")
        }
    }
    
    func wsUserDelegate(users: [User]) {
        // Do stuff
    }
    
    func wsUserDelegate(authorizationCode: String?) {
        // Do stuff
    }
    
    func onResponseError(error: NSError) {
        LoadingActivity.hide()
        if let message = error.userInfo["message"] as? String {
            AlertController.alert(title: "", message: message)
            return
        }
        switch error.code {
        case NSURLErrorCancelled, NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost: break
        case NSURLErrorTimedOut, NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
            AlertController.alert(title: "Timeout error", message: "Taking too long to respond")
        default:
            let title = "Error \(error.code)"
            print("Server error: \(error.localizedDescription)")
            AlertController.alert(title: title, message: "Please contact the system administrator.")
        }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
