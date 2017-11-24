//
//  MainViewController.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/22/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit

class MainViewController: UIViewController {
    
    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var slidingMenu: UIView!
    @IBOutlet weak var containerView: UIView!
    @IBOutlet weak var visualEffect: UIVisualEffectView!
    
    var accessToken: AccessToken?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DispatchQueue.main.async() {
            self.closeMenu(animated: false)
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(toggleMenu), name: NSNotification.Name(rawValue: "toggleMenu"), object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(closeMenuViaNotification), name: NSNotification.Name(rawValue: "closeMenuViaNotification"), object: nil)
        
        // Close the menu when the device rotates
        NotificationCenter.default.addObserver(self, selector: #selector(rotated), name: NSNotification.Name.UIDeviceOrientationDidChange, object: nil)
        
        // LeftMenu sends openModalWindow
        NotificationCenter.default.addObserver(self, selector: #selector(openModalWindow), name: NSNotification.Name(rawValue: "openModalWindow"), object: nil)
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    @objc func openModalWindow() {
        performSegue(withIdentifier: "openModalWindow", sender: nil)
    }
    
    @objc func toggleMenu() {
        scrollView.contentOffset.x == 0  ? closeMenu() : openMenu()
    }
    
    @objc func closeMenuViaNotification(){
        closeMenu()
    }
    
    func closeMenu(animated:Bool = true) {
        self.scrollView.setContentOffset(CGPoint(x: slidingMenu.width, y: 0), animated: animated)
        self.visualEffect.isHidden = true
    }
    
    func openMenu() {
        self.scrollView.setContentOffset(CGPoint(x: 0, y: 0), animated: true)
        self.visualEffect.isHidden = false
    }
    
    // see http://stackoverflow.com/questions/25666269/ios8-swift-how-to-detect-orientation-change
    // close the menu when rotating to landscape.
    // Note: you have to put this on the main queue in order for it to work
    @objc func rotated(){
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            DispatchQueue.main.async() {
                print("closing menu on rotate")
                self.closeMenu()
            }
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
