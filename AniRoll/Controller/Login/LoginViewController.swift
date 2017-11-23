//
//  LoginViewController.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/10/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class LoginViewController: UIViewController, WSAuthenticationDelegate {
    
    enum FormType { case login, information }
    @IBOutlet weak var logo: UIImageView!
    @IBOutlet weak var logoYPosition: NSLayoutConstraint!
    @IBOutlet weak var scrollView: UIScrollView!
    // Login Container
    @IBOutlet weak var loginFormContainer: UIView!
    @IBOutlet weak var loginFormContainerVerticalSpacing: NSLayoutConstraint!
    @IBOutlet weak var userTextField: UITextField!
    @IBOutlet weak var userErrorLabel: UILabel!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var passwordErrorLabel: UILabel!
    @IBOutlet weak var loginButton: UIButton!
    // Informmation Container
    @IBOutlet weak var informationContainer: UIView!
    @IBOutlet weak var informationLabel: UILabel!
    @IBOutlet weak var loginRetryButton: UIButton!
    
    var activeField: UITextField?
    let wsAuthentication = WSAuthentication()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wsAuthentication.delegate = self
        loginButton.layer.borderColor = UIColor.white.cgColor
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        LoadingActivity.show(text: "Loading...", disableUI: true)
        self.wsAuthentication.getAccess(using: .clientCredentials)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.registerForKeyboardNotifications()
        self.displayContainer(self.loginFormContainer)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        self.deregisterFromKeyboardNotifications()
    }
    
    func displayContainer(_ view: UIView, show: Bool = true, callback: ((Bool) -> Void)? = nil) {
        self.loginFormContainer.isHidden = true
        self.informationContainer.isHidden = true
        view.isHidden = false

        let offset = ((self.loginFormContainer.height + self.loginFormContainerVerticalSpacing.constant) / 2) - UIApplication.shared.statusBarFrame.height
        let repositionate = logoYPosition.constant != offset
        
        if repositionate {
            UIView.animate(withDuration: 0.5, delay: show ? 0 : 1.0, options: .curveEaseOut, animations: {
                self.logoYPosition.constant = -offset
                self.view.layoutIfNeeded()
            }){ finished in if finished && !show { callback?(finished) } }
        }
        
        UIView.animate(withDuration: show ? 1.0 : 0.5, delay: show && repositionate ? 0.5 : 0, options: .curveEaseOut, animations: {
            view.alpha = show ? 1.0 : 0.0
        }) { finished in if (finished && show) || !repositionate { callback?(finished) } }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - WSAuthenticationDelegate
    func wsAuthenticationDelegate(accessToken: AccessToken?) {
        LoadingActivity.hide()
        guard let accessToken = accessToken, let storyboard = self.storyboard else {
            AlertController.alert(title: "", message: "Invalid login information, please try again.")
            return
        }
        do {
            let realm = try Realm()
            try realm.write {
                realm.add(accessToken)
            }
            let dashboard = storyboard.instantiateViewController(withIdentifier: "MainView")
            self.present(dashboard, animated: true, completion: nil)
        } catch {
            AlertController.alert(title: "", message: "The application encountered an internal error or misconfiguration and was unable to complete your request. ")
        }
    }
    
    // MARK: - Navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Do stuff
    }
}
