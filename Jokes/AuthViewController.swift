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
    
    //MARK: Lifecycle
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .backgroundColor()
        setup()
        
        NotificationCenter.default.addObserver(self, selector: #selector(AuthViewController.keyboardWillShow), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(AuthViewController.keyboardWillHide), name: UIResponder.keyboardWillHideNotification, object: nil)
    }
    
    //MARK: Function
    @objc func presentAuthVC(){
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
        //MARK: костыль!! -> исправить на ScrollView -> https://fluffy.es/move-view-when-keyboard-is-shown/
        if keyboardSize.height + 250 > (view.frame.height - buttonStackView.frame.maxY){
            self.view.frame.origin.y = 0 - keyboardSize.height + 150
        }else{
            self.view.frame.origin.y = 0
        }
    }
       
    @objc func keyboardWillHide(notification: NSNotification) {
        self.view.frame.origin.y = 0
    }
}

//MARK: Setup
extension AuthViewController{
    private func setup() {
        welcomeImageView = UIImageView(image: #imageLiteral(resourceName: "welcome"), contentMode: .scaleAspectFit)
        view.addSubview(welcomeImageView)
        welcomeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 16),
            welcomeImageView.widthAnchor.constraint(equalToConstant: view.frame.width - 32),
            welcomeImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            welcomeImageView.heightAnchor.constraint(equalToConstant: 250)
        ])
        
        //setup email element
        emailLabel = UILabel(text: "Email", font: .avenir16())
        emailTextField = TextFieldBottonLine(font: .avenir16(), backgroundColor: .grayColor())
        emailTextField.delegate = self
        emailStackView = UIStackView(arrangedSubviews: [emailLabel,emailTextField], axis: .vertical, spacing: 0)
        
        //setup password element
        passwordLabel = UILabel(text: "Password", font: .avenir16())
        passwordTextField = TextFieldBottonLine(font: .avenir16(), backgroundColor: .grayColor())
        passwordTextField.delegate = self
        passwordStackView = UIStackView(arrangedSubviews: [passwordLabel,passwordTextField], axis: .vertical, spacing: 0)
        
        //setup button
        emailButton = UIButton(title: "Email", titleColor: .blackColor(), backgroundColor: .whiteColor(), font: .avenir16(), cornerRadius: 0, isShadow: true)
        emailTap = UITapGestureRecognizer(target: self, action: #selector(presentAuthVC))
        emailButton.addGestureRecognizer(emailTap)
        appleButton = UIButton(title: "Apple", titleColor: .blackColor(), backgroundColor: .whiteColor(), font: .avenir16(), cornerRadius: 0, isShadow: true)
        buttonStackView = UIStackView(arrangedSubviews: [emailButton,appleButton], axis: .horizontal, spacing: 16)
        buttonStackView.distribution = .fillEqually
        
        //setup main StackView
        mainStackView = UIStackView(arrangedSubviews: [emailStackView,passwordStackView,buttonStackView], axis: .vertical, spacing: 32)
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor,constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -32)
        ])
    }
}
