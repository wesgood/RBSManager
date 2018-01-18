//
//  ModalContainerView.swift
//  Logger
//
//  Created by Wes Goodhoofd on 2017-10-29.
//  Copyright © 2017 Wes Goodhoofd. All rights reserved.
//

import UIKit

protocol ModalViewDelegate {
    func modalViewDidClose(_ modal: ModalContainerView)
}

class ModalContainerView: UIView {
    var backgroundView: UIView?
    var parentWindow: UIWindow?
    var containerView: UIView?
    var mainView: UIView?
    var viewDelegate: ModalViewDelegate?
    static let greenColour = UIColor(red:0.19, green:0.63, blue:0.12, alpha:1.0)
    
    convenience init() {
        let window = UIApplication.shared.keyWindow!
        self.init(frame: window.bounds)
        self.parentWindow = window
        self.isHidden = true
    }
    
    func buildView() {        
        // background black view
        backgroundView = UIView(frame: self.bounds)
        backgroundView?.backgroundColor = UIColor(white: 0, alpha: 0.8)
        self.addSubview(backgroundView!)
        
        // dismiss when tapped
        let gesture = UITapGestureRecognizer(target: self, action: #selector(dismiss))
        backgroundView?.addGestureRecognizer(gesture)
        
        // build the container view
        let margin:CGFloat = 10
        var containerFrame = CGRect(x: 0, y: 0, width: self.frame.size.width-2*margin, height: margin)
        self.containerView = UIView(frame: containerFrame)
        self.containerView?.backgroundColor = UIColor.white
        let buttonMaxHeight: CGFloat = 40
        var minSpace: CGFloat = margin * 6 + buttonMaxHeight
        
        if let titleString = getTitle() {
            let titleLabel = UILabel(frame: CGRect(x: margin, y: containerFrame.size.height, width: 0, height: 0))
            titleLabel.text = titleString
            titleLabel.font = UIFont.boldSystemFont(ofSize: 20)
            titleLabel.textColor = UIColor.black
            titleLabel.sizeToFit()
            self.containerView?.addSubview(titleLabel)
            containerFrame.size.height += titleLabel.frame.size.height+margin
            minSpace += titleLabel.frame.size.height + margin*2
        }
        
        self.mainView = getMainView(CGSize(width: containerFrame.size.width - 2*margin, height: self.frame.size.height - minSpace))
        if self.mainView != nil {
            let space: CGFloat = min(margin, (containerFrame.size.width - self.mainView!.frame.size.width) / 2.0)
            self.mainView!.frame = CGRect(x: space, y: containerFrame.size.height, width: self.mainView!.frame.size.width, height: self.mainView!.frame.size.height)
            containerFrame.size.width = self.mainView!.frame.size.width + 2*space
            containerFrame.size.height += self.mainView!.frame.size.height+space
            containerView!.addSubview(self.mainView!)
        }
        
        // add buttons
        var buttonHeight: CGFloat = 0
        if let leftButton = getLeftButton() {
            leftButton.frame = CGRect(x: margin, y: containerFrame.size.height, width: leftButton.frame.size.width, height: min(buttonMaxHeight, leftButton.frame.size.height))
            self.containerView?.addSubview(leftButton)
            buttonHeight = leftButton.frame.size.height
        }
        
        if let rightButton = getRightButton() {
            rightButton.frame = CGRect(x: containerFrame.size.width - margin - rightButton.frame.size.width, y: containerFrame.size.height, width: rightButton.frame.size.width, height: min(buttonMaxHeight, rightButton.frame.size.height))
            self.containerView?.addSubview(rightButton)
            buttonHeight = max(buttonHeight, rightButton.frame.size.height)
        }
        
        minSpace += buttonHeight
        containerFrame.size.height += buttonHeight + margin
        self.containerView?.frame = containerFrame
        self.containerView?.center = CGPoint(x: self.frame.size.width/2, y: self.frame.size.height/2)
        self.addSubview(self.containerView!)
        
        self.parentWindow?.addSubview(self)
    }
    
    @objc func dismiss() {
        UIView.animate(withDuration: 0.25, animations: {
            self.alpha = 0.0
        }) { (complete) in
            self.isHidden = true
            self.viewDelegate?.modalViewDidClose(self)
        }
    }
    
    func show() {
        self.buildView()
        self.setNeedsLayout()
        self.willShow()
        self.alpha = 0
        self.isHidden = false
        
        UIView.animate(withDuration: 0.25) {
            self.alpha = 1.0
        }
    }

    // overridden methods
    func getMainView(_ availableSize: CGSize) -> UIView? {
        return nil
    }
    
    func willShow() {
        
    }
    
    func getTitle() -> String? {
        return "Modal view"
    }
    
    func getLeftButton() -> UIButton? {
        return nil
    }
    
    func getRightButton() -> UIButton? {
        let dismissButton = createBottomButton(title: NSLocalizedString("dismiss", comment: "dismiss button"), color: ModalContainerView.greenColour)
        dismissButton.addTarget(self, action: #selector(dismiss), for: .touchUpInside)
        return dismissButton
    }
    
    func createBottomButton(title: String, color: UIColor) -> UIButton {
        let button = UIButton(type: .custom)
        button.frame = CGRect(x: 0, y: 0, width: 0, height: 40)
        button.setTitle(title, for: .normal)
        button.backgroundColor = color
        button.setTitleColor(UIColor.white, for: .normal)
        button.titleLabel?.font = UIFont.boldSystemFont(ofSize: 17)
        button.sizeToFit()
        button.frame = CGRect(x: 0, y: 0, width: button.frame.size.width + 20, height: button.frame.size.height)
        return button
    }
}
