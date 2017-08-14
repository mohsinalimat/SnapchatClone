//
//  UsernameController.swift
//  Snapchat Clone
//
//  Created by Michael Lema on 8/13/17.
//  Copyright © 2017 Michael Lema. All rights reserved.
//

import Foundation
import UIKit

class UsernameController: UIViewController, UIScrollViewDelegate, UITextFieldDelegate {
    
    private let purpleButtonColor =  UIColor.rgb(red: 153, green: 87, blue: 159)
    private let grayButtonColor = UIColor.rgb(red: 185, green: 192, blue: 199)
    private var bottomConstraint: NSLayoutConstraint?

    
    lazy var scrollView: UIScrollView = {
        let scrollView = UIScrollView()
        scrollView.backgroundColor = .red
        scrollView.showsVerticalScrollIndicator = false
        scrollView.alwaysBounceVertical = true
        scrollView.delegate = self
        return scrollView
    }()
    let contentView: UIView = {
        let view = UIView()
        view.backgroundColor = .white
        return view
    }()
    
    let pickUsernameLabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 19)
        label.text = "Pick a username"
        return label
    }()
    
    let descriptionLabel: UILabel = {
       let label = UILabel()
        label.textAlignment = .center
        label.font = UIFont(name: "Avenir-Medium", size: 14)
        label.textColor = .darkGray
        label.numberOfLines = 0
        label.text = "Your username is how friends add you on Snapchat clone."
        return label
    }()
    
    let usernamelabel: UILabel = {
        let label = UILabel()
        label.textAlignment = .left
        label.font = UIFont(name: "Avenir-Heavy", size: 11)
        label.textColor = .lightGray
        label.text = "USERNAME"
        return label
    }()
    
    lazy var usernameTextField: UITextField = {
        let textField = UITextField()
        textField.autocorrectionType = .no
        textField.returnKeyType = .next
        textField.enablesReturnKeyAutomatically = true
        textField.font = UIFont(name: "Avenir-Medium", size: 16)
        textField.setUnderlinedBorder()
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
        textField.rightViewMode = UITextFieldViewMode.whileEditing
        textField.delegate = self
        return textField
    }()
    
    lazy var refreshButton: UIButton = {
        let button = UIButton(type: .system)
        button.frame = CGRect(x: 0, y: 0, width: 20, height: 20)
        let image = UIImage(named: "Refresh")?.withRenderingMode(.alwaysOriginal)
        button.setImage(image, for: .normal)
        button.addTarget(self, action: #selector(refreshTapped), for: .touchUpInside)
        button.isHidden = true
        return button
    }()
    
    lazy var continueButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setTitleColor(.white, for: .normal)
        button.setTitle("Continue", for: .normal)
        button.titleLabel?.font = UIFont(name: "Avenir-Heavy", size: 14)
        button.backgroundColor = self.grayButtonColor
        button.addTarget(self, action: #selector(continueButtonTapped), for: .touchUpInside)
        //: Make button round
        button.layer.cornerRadius = 22
        button.layer.masksToBounds = true
        return button
    }()
    
    func refreshTapped() {
        print("Refresh button tapped")
    }
    
    func textFieldDidChange(textField: UITextField) {
        print("text has changed")
        guard let text = textField.text else {
            return
        }
        if !text.isEmpty {
            refreshButton.isHidden = false
            
        } else {
            refreshButton.isHidden = true
        }
        
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        print("Text field is active now")
    }
    
    func continueButtonTapped() {
        print("Button tapped!")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .red
        setUpNavigationBar(leftImage: "BackButton")
        
        self.view.addSubview(scrollView)
        scrollView.addSubview(contentView)
        self.automaticallyAdjustsScrollViewInsets = false
        
        contentView.addSubview(pickUsernameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(usernamelabel)
        contentView.addSubview(usernameTextField)
        view.addSubview(continueButton)
        
        setUpViews()
        usernameTextField.rightView = refreshButton

        //: Implement a listener for when the keyboard will show up
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: .UIKeyboardWillShow, object: nil)
    }
    
    func setUpViews() {
        let screenCenter = UIScreen.main.bounds.height / 3.5
        //: ScrollView & contentView constraints
        view.addConstraintsWithFormat(format: "H:|[v0]|", views: scrollView)
        view.addConstraintsWithFormat(format: "V:|[v0]|", views: scrollView)
        scrollView.addConstraintsWithFormat(format: "H:|[v0]|", views: contentView)
        scrollView.addConstraintsWithFormat(format: "V:|[v0]|", views: contentView)
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .width, relatedBy: .equal, toItem: view, attribute: .width, multiplier: 1, constant: 0))
        view.addConstraint(NSLayoutConstraint(item: contentView, attribute: .height, relatedBy: .equal, toItem: view, attribute: .height, multiplier: 1, constant: 0))
        
        contentView.addConstraintsWithFormat(format: "H:|-75-[v0]-75-|", views: pickUsernameLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: descriptionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: usernamelabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: usernameTextField)
    
        contentView.addConstraintsWithFormat(format: "V:|-\(screenCenter)-[v0(30)][v1(40)]-15-[v2(11)]-3-[v3(35)]", views: pickUsernameLabel, descriptionLabel, usernamelabel, usernameTextField)
        
        view.addConstraintsWithFormat(format: "H:|-68-[v0]-68-|", views: continueButton)
        view.addConstraintsWithFormat(format: "V:[v0(44)]", views: continueButton)
        bottomConstraint = NSLayoutConstraint(item: continueButton, attribute: .bottom, relatedBy: .equal, toItem: view, attribute: .bottom, multiplier: 1, constant: -25)
        view.addConstraint(bottomConstraint!)
    }
    fileprivate func reapplyViews() {
        let screenCenter = UIScreen.main.bounds.height / 8
        pickUsernameLabel.removeFromSuperview()
        descriptionLabel.removeFromSuperview()
        usernamelabel.removeFromSuperview()
        usernameTextField.removeFromSuperview()
        contentView.addSubview(pickUsernameLabel)
        contentView.addSubview(descriptionLabel)
        contentView.addSubview(usernamelabel)
        contentView.addSubview(usernameTextField)
        contentView.addConstraintsWithFormat(format: "H:|-75-[v0]-75-|", views: pickUsernameLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: descriptionLabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: usernamelabel)
        contentView.addConstraintsWithFormat(format: "H:|-50-[v0]-50-|", views: usernameTextField)
        
        contentView.addConstraintsWithFormat(format: "V:|-\(screenCenter)-[v0(30)][v1(40)]-15-[v2(11)]-3-[v3(35)]", views: pickUsernameLabel, descriptionLabel, usernamelabel, usernameTextField)
    }
    
    //: MARK: - Handle Keyboard Notification
    func handleKeyboardNotification(notification: NSNotification) {
        if let userInfo = notification.userInfo {
            let keyboardFrame = userInfo[UIKeyboardFrameBeginUserInfoKey] as? CGRect
            bottomConstraint?.constant = -(keyboardFrame!.height + 25)
            reapplyViews()
        }
    }
   
    //: Hide the status bar
    override var prefersStatusBarHidden: Bool {
        return true
    }
    
}
