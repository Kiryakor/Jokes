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
    private var welcomeLabel: UILabel!
    private var emailLabel:UILabel!
    private var emailTextField:TextFieldBottonLine!
    private var emailStackView:UIStackView!
    private var passwordLabel:UILabel!
    private var passwordTextField:TextFieldBottonLine!
    private var passwordStackView:UIStackView!
    private var emailButton:UIButton!
    private var emailTap:UITapGestureRecognizer!
    private var buttonStackView:UIStackView!
    private var mainStackView:UIStackView!
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor()
        setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(AuthViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AuthViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Function
    @objc func tapEnterButton(){
        guard let emailText = emailTextField.text, let passwordText = passwordTextField.text else {
            errorTextField()
            return
        }
        Server.createUser(email: emailText, password: passwordText) { [weak self] (result) in
            switch result{
            case true:
                self?.present(ContentViewController(modalPresentationStyle: .fullScreen),animated: true,completion: nil)
            case false:
                self?.errorTextField()
            }
        }
    }
}

//MARK: Работа с клавиатурой и TextField
extension AuthViewController:UITextFieldDelegate{
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    @objc func keyboardWillShow(notification: NSNotification) {
        guard let keyboardSize = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else { return }
        if keyboardSize.height + 250 > (view.frame.height - buttonStackView.frame.maxY){
            self.view.frame.origin.y = 0 - keyboardSize.height + 150
        }
    }
       
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
    
    private func errorTextField(){
        emailTextField.errorAnimation()
        passwordTextField.errorAnimation()
    }
}

//MARK: Setup
extension AuthViewController{
    private func setup() {
        //setup welcomeImageView
        welcomeLabel = UILabel(text: "Infinity meme", font: .avenir32())
        welcomeLabel.textAlignment = .center
        
        //setup email element
        emailLabel = UILabel(text: "Email", font: .avenir16())
        emailTextField = TextFieldBottonLine(font: .avenir16(), backgroundColor: .blackColor(),textContentType: .emailAddress)
        emailTextField.delegate = self
        emailStackView = UIStackView(arrangedSubviews: [emailLabel,emailTextField], axis: .vertical, spacing: 0)
        
        //setup password element
        passwordLabel = UILabel(text: "Password", font: .avenir16())
        passwordTextField = TextFieldBottonLine(font: .avenir16(), backgroundColor: .blackColor(),textContentType: .password)
        passwordTextField.delegate = self
        passwordTextField.isSecureTextEntry = true
        passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,passwordTextField], axis: .vertical, spacing: 0)
        
        //setup button
        emailButton = UIButton(title: "Email", titleColor: .blackColor(), backgroundColor: .whiteColor(), font: .avenir16(), cornerRadius: 0, isShadow: true)
        emailTap = UITapGestureRecognizer(target: self, action: #selector(tapEnterButton))
        emailButton.addGestureRecognizer(emailTap)
        buttonStackView = UIStackView(arrangedSubviews: [emailButton], axis: .horizontal, spacing: 16)
        buttonStackView.distribution = .fillEqually
        
        //setup main StackView
        mainStackView = UIStackView(arrangedSubviews: [welcomeLabel,emailStackView,passwordStackView,buttonStackView], axis: .vertical, spacing: 32)
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.centerYAnchor.constraint(equalTo: view.centerYAnchor,constant: -50),
            mainStackView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -32)
        ])
    }
}
