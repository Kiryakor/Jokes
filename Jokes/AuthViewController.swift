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
        
        emailTap = UITapGestureRecognizer(target: self, action: #selector(tapp))
        emailButton.addGestureRecognizer(emailTap)
    }
    
    @objc func tapp(){
        let content = ContentViewController()
        content.modalPresentationStyle = .fullScreen
        content.modalTransitionStyle = .coverVertical
        present(content,animated: true,completion: nil)
    }
}

//MARK: Setup
extension AuthViewController{
    private func setup() {
        //setup welcomeImage
        welcomeImageView = UIImageView(image: #imageLiteral(resourceName: "welcome"), contentMode: .scaleAspectFit)
        view.addSubview(welcomeImageView)
        welcomeImageView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            welcomeImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 16),
            welcomeImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 16),
            welcomeImageView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -16),
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
        view.addSubview(mainStackView)
        mainStackView.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            mainStackView.topAnchor.constraint(equalTo: welcomeImageView.bottomAnchor,constant: 16),
            mainStackView.leadingAnchor.constraint(equalTo: view.leadingAnchor,constant: 32),
            mainStackView.trailingAnchor.constraint(equalTo: view.trailingAnchor,constant: -32)
        ])
    }
}
