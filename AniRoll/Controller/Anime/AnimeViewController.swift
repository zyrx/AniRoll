//
//  AnimeViewController.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/21/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import RealmSwift

class AnimeViewController: UIViewController, WSSerieDelegate {
    
    let wsSerie = WSSerie()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.wsSerie.delegate = self
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
        self.wsSerie.getSeries(type: .anime, user: "zyrx")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @IBAction func toggleMenu(_ sender: Any) {
        NotificationCenter.default.post(name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
    }

    // MARK: - WSSerieDelegate
    func onResponseError(error: NSError) {
        LoadingActivity.hide()
        if let message = error.userInfo["message"] as? String {
            AlertController.alert(title: "", message: message)
            return
        }
        switch error.code {
        case NSURLErrorCancelled, NSURLErrorNotConnectedToInternet, NSURLErrorNetworkConnectionLost: break
        case NSURLErrorTimedOut, NSURLErrorCannotFindHost, NSURLErrorCannotConnectToHost:
            AlertController.alert(title: "Se agotó el tiempo de espera", message: "El servidor tardó demasiado en responder")
        default:
            let title = "Error (\(error.code)) en el servidor"
            print("Server error: \(error.localizedDescription)")
            AlertController.alert(title: title, message: "Favor de contactar al Administrador.")
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
