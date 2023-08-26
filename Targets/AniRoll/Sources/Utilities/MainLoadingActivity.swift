//
//  LoadingActivity.swift
//  AniRoll
//
//  Created by Lech H. Conde on 11/21/17.
//  Copyright © 2017 Lech H. Conde. All rights reserved.
//

import UIKit
import SnapKit

/// Based on goktugyil's EZLoadingActivity <https://github.com/goktugyil/EZLoadingActivity>
public struct LoadingActivity {
    
    public struct Settings {
        public static var BackgroundColor = UIColor.black.withAlphaComponent(0.6)
        public static var ActivityColor = UIColor.white
        public static var TextColor = UIColor.white
        public static var FontName = "HelveticaNeue-Light"
        public static var SuccessIcon = "✔︎"
        public static var FailIcon = "✘"
        public static var SuccessText = "Exitoso"
        public static var FailText = "Falló"
        public static var SuccessColor = UIColor(red: 68/255, green: 118/255, blue: 4/255, alpha: 1.0)
        public static var FailColor = UIColor(red: 255/255, green: 75/255, blue: 56/255, alpha: 1.0)
        static var WidthDivision: CGFloat {
            get {
                if UIDevice.current.userInterfaceIdiom == UIUserInterfaceIdiom.pad {
                    return  3.5
                } else {
                    return 1.6
                }
            }
        }
    }
    
    private static var instance: LoadingActivity?
    private static var hidingInProgress = false
    
    public static var isActive: Bool { get { return instance != nil } }
    
    /// Disable UI stops users touch actions until LoadingActivity is hidden.
    /// Return success status
    @discardableResult public static func show(text: String, disableUI: Bool) -> Bool {
        guard instance == nil else {
            print("MainLoadingActivity: You still have an active activity, please stop that before creating a new one")
            return false
        }
        
        guard topMostController != nil else {
            print("MainLoadingActivity Error: You don't have any views set. You may be calling them in viewDidLoad. Try viewDidAppear instead.")
            return false
        }
        
        instance = LoadingActivity(text: text, disableUI: disableUI)
        return true
    }
    
    @discardableResult public static func showWithDelay(text: String, disableUI: Bool, seconds: Double) -> Bool {
        let showValue = show(text: text, disableUI: disableUI)
        delay(seconds: seconds, after: DispatchWorkItem {
            self.hide(success: true, animated: false)
        })
        return showValue
    }
    
    /// Returns success status
    @discardableResult public static func hide(success: Bool? = nil, animated: Bool = false) -> Bool {
        guard instance != nil else {
            print("MainLoadingActivity: You don't have an activity instance")
            return false
        }
        
        guard hidingInProgress == false else {
            print("MainLoadingActivity: Hiding already in progress")
            return false
        }
        
        if !Thread.current.isMainThread {
            DispatchQueue.main.async {
                instance?.hideLoadingActivity(success: success, animated: animated)
            }
        } else {
            instance?.hideLoadingActivity(success: success, animated: animated)
        }
        
        return true
    }
    
    private static func delay(seconds: Double, after: DispatchWorkItem) {
        DispatchQueue.main.asyncAfter(deadline: .now() + seconds, execute: after)
    }
    
    private class LoadingActivity: UIView {
        var textLabel: UILabel!
        var activityView: UIActivityIndicatorView!
        var icon: UILabel!
        var UIDisabled = false
        
        private var topMostController: UIViewController? {
            var presentedVC = UIApplication.shared.keyWindow?.rootViewController
            while let pVC = presentedVC?.presentedViewController {
                presentedVC = pVC
            }
            
            return presentedVC
        }
        
        convenience init(text: String, disableUI: Bool) {
            let width = UIScreen.ScreenWidth / Settings.WidthDivision
            self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.ScreenWidth, height: UIScreen.ScreenHeight))
            backgroundColor = Settings.BackgroundColor
            alpha = 1
            //createShadow()
            //self.autoresizingMask = .flexibleWidth | .flexibleHeight | .flexibleBottomMargin | .flexibleLeftMargin | .flexibleRightMargin | .flexibleTopMargin | .flexibleBottomMargin
            
            let yPosition = frame.height / 2
            let xPosition = frame.width / 2
            
            activityView = UIActivityIndicatorView(style: UIActivityIndicatorView.Style.whiteLarge)
            activityView.color = Settings.ActivityColor
            activityView.startAnimating()
            
            textLabel = UILabel(frame: CGRect(x: xPosition - 50, y: yPosition, width: width - 70, height: 40))
            textLabel.textColor = Settings.TextColor
            textLabel.font = UIFont(name: Settings.FontName, size: 17)
            textLabel.adjustsFontSizeToFitWidth = true
            textLabel.minimumScaleFactor = 0.25
            textLabel.textAlignment = .center
            textLabel.numberOfLines = 2
            textLabel.text = text
            
            addSubview(activityView)
            addSubview(textLabel)
            
            topMostController!.view.addSubview(self)
            
            if disableUI {
                UIApplication.shared.beginIgnoringInteractionEvents()
                UIDisabled = true
            }
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            
            self.snp.makeConstraints() { make in
                make.width.equalTo(UIScreen.ScreenWidth)
                make.height.equalTo(UIScreen.ScreenHeight)
            }
            
            let offset = (activityView.height + textLabel.height) / 2
            activityView.snp.makeConstraints() { make in
                make.centerX.equalTo(self)
                make.centerY.equalTo(self).offset(-offset)
            }
            
            textLabel.snp.makeConstraints() { make in
                make.left.equalTo(self).offset(8)
                make.right.equalTo(self).offset(-8)
                make.centerY.equalTo(self).offset(-offset + activityView.height)
            }
        }
        
        func createShadow() {
            layer.shadowPath = createShadowPath().cgPath
            layer.masksToBounds = false
            layer.shadowColor = UIColor.black.cgColor
            layer.shadowOffset = CGSize(width: 0, height: 0)
            layer.shadowRadius = 0.0
            layer.shadowOpacity = 0.5
        }
        
        func createShadowPath() -> UIBezierPath {
            let myBezier = UIBezierPath()
            myBezier.move(to: CGPoint(x: -3, y: -3))
            myBezier.addLine(to: CGPoint(x: frame.width + 3, y: -3))
            myBezier.addLine(to: CGPoint(x: frame.width + 3, y: frame.height + 3))
            myBezier.addLine(to: CGPoint(x: -3, y: frame.height + 3))
            myBezier.close()
            return myBezier
        }
        
        func hideLoadingActivity(success: Bool?, animated: Bool) {
            hidingInProgress = true
            if UIDisabled {
                UIApplication.shared.endIgnoringInteractionEvents()
            }
            
            var animationDuration: Double = 0
            if success != nil {
                if success! {
                    animationDuration = 1
                } else {
                    animationDuration = 1
                }
            }
            
            let yPosition = frame.height/2
            let xPosition = frame.width/2
            
            icon = UILabel(frame: CGRect(x: xPosition - 10, y: yPosition - 40, width: 40, height: 40))
            icon.font = UIFont(name: Settings.FontName, size: 60)
            icon.textAlignment = NSTextAlignment.center
            
            if animated {
                textLabel.fadeTransition(duration: animationDuration)
            }
            
            if success != nil {
                if success! {
                    icon.textColor = Settings.SuccessColor
                    icon.text = Settings.SuccessIcon
                    textLabel.text = Settings.SuccessText
                } else {
                    icon.textColor = Settings.FailColor
                    icon.text = Settings.FailIcon
                    textLabel.text = Settings.FailText
                }
            }
            
            addSubview(icon)
            
            if animated {
                icon.alpha = 0
                activityView.stopAnimating()
                UIView.animate(withDuration: animationDuration, animations: {
                    self.icon.alpha = 1
                }, completion: { (value: Bool) in
                    self.callSelectorAsync(selector: .removeFromSuperview, delay: animationDuration)
                    instance = nil
                    hidingInProgress = false
                })
            } else {
                activityView.stopAnimating()
                self.callSelectorAsync(selector: .removeFromSuperview, delay: animationDuration)
                instance = nil
                hidingInProgress = false
            }
        }
    }
}

private extension UIView {
    /// Extension: insert view.fadeTransition right before changing content
    func fadeTransition(duration: CFTimeInterval) {
        let animation: CATransition = CATransition()
        animation.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        animation.type = CATransitionType.fade
        animation.duration = duration
        self.layer.add(animation, forKey: CATransitionType.fade.rawValue)
    }
}

private extension NSObject {
    func callSelectorAsync(selector: Selector, delay: TimeInterval) {
        let timer = Timer.scheduledTimer(timeInterval: delay, target: self, selector: selector, userInfo: nil, repeats: false)
        RunLoop.main.add(timer, forMode: RunLoop.Mode.common)
    }
}

private extension UIScreen {
    class var Orientation: UIInterfaceOrientation {
        get {
            return UIApplication.shared.statusBarOrientation
        }
    }
    class var ScreenWidth: CGFloat {
        get {
            if Orientation.isPortrait {
                return UIScreen.main.bounds.size.width
            } else {
                return UIScreen.main.bounds.size.height
            }
        }
    }
    class var ScreenHeight: CGFloat {
        get {
            if Orientation.isPortrait {
                return UIScreen.main.bounds.size.height
            } else {
                return UIScreen.main.bounds.size.width
            }
        }
    }
}

private extension Selector {
    static let removeFromSuperview =
        #selector(UIView.removeFromSuperview)
}

private var topMostController: UIViewController? {
    var presentedVC = UIApplication.shared.keyWindow?.rootViewController
    while let pVC = presentedVC?.presentedViewController {
        presentedVC = pVC
    }
    
    return presentedVC
}
