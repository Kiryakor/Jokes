//
//  ViewController.swift
//  Jokes
//
//  Created by Кирилл on 05.04.2020.
//  Copyright © 2020 Кирилл. All rights reserved.
//

import UIKit

class AuthViewController: UIViewController {

    //MARK: Var
    private var welcomeImageView: UIImageView!
    private var emailLabel:UILabel!
    private var emailTextField:TextFieldBottonLine!
    private var emailStackView:UIStackView!
    private var passwordLabel:UILabel!
    private var passwordTextField:TextFieldBottonLine!
    private var passwordStackView:UIStackView!
    private var emailButton:UIButton!
    private var appleButton:UIButton!
    private var buttonStackView:UIStackView!
    private var mainStackView:UIStackView!
    private var emailTap:UITapGestureRecognizer!
    
    var scrollView:UIScrollView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor()
        setup()
        
        emailTap = UITapGestureRecognizer(target: self, action: #selector(tapp))
        emailButton.addGestureRecognizer(emailTap)
        
        passwordTextField.delegate = self
        emailTextField.delegate = self
        NotificationCenter.default.addObserver(self, selector: #selector(AuthViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AuthViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    @objc func tapp(){
        let content = ContentViewController()
        content.modalPresentationStyle = .fullScreen
        content.modalTransitionStyle = .coverVertical
        present(content,animated: true,completion: nil)
    }
}

//MARK: работа с клавиатурой
extension AuthViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        self.view.frame.origin.y = 0 - keyboardSize.height
    }
       
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

//MARK: Setup
extension AuthViewController{
    private func setup() {
        scrollView = UIScrollView(frame: view.frame)
        view.addSubview(scrollView)
        //setup welcomeImage
        welcomeImageView = UIImageView(image: #imageLiteral(resourceName: "welcome"), contentMode: .scaleAspectFit)
        scrollView.addSubview(welcomeImageView)
        welcomeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeImageView.topAnchor.constraint(equalTo: scrollView.topAnchor,constant: 16),
            welcomeImageView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 16),
            welcomeImageView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -16),
            welcomeImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        //setup email element
        emailLabel = UILabel(text: "Email", font: .avenir16())
        emailTextField = TextFieldBottonLine(font: .avenir16(), backgroundColor: .grayColor())
        emailStackView = UIStackView(arrangedSubviews: [emailLabel,emailTextField], axis: .vertical, spacing: 0)
        
        //setup password element
        passwordLabel = UILabel(text: "Password", font: .avenir16())
        passwordTextField = TextFieldBottonLine(font: .avenir16(), backgroundColor: .grayColor())
        passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,passwordTextField], axis: .vertical, spacing: 0)
        
        //setup button
        emailButton = UIButton(title: "Email", titleColor: .blackColor(), backgroundColor: .whiteColor(), font: .avenir16(), cornerRadius: 0, isShadow: true)
        appleButton = UIButton(title: "Apple", titleColor: .blackColor(), backgroundColor: .whiteColor(), font: .avenir16(), cornerRadius: 0, isShadow: true)
        buttonStackView = UIStackView(arrangedSubviews: [emailButton,appleButton], axis: .horizontal, spacing: 16)
        buttonStackView.distribution = .fillEqually
        
        //setup main StackView
        mainStackView = UIStackView(arrangedSubviews: [emailStackView,passwordStackView,buttonStackView], axis: .vertical, spacing: 32)
        scrollView.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor,constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: scrollView.leadingAnchor,constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: scrollView.trailingAnchor,constant: -32)
        ])
    }
}
