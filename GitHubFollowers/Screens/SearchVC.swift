//
//  SearchVC.swift
//  GHFollowers
//
//  Created by Sean Allen on 12/27/19.
//  Copyright © 2019 Sean Allen. All rights reserved.
//

import UIKit

class SearchVC: UIViewController {
    
    let logoImageView: UIImageView = {
        let image = UIImageView()
        image.image = Images.ghLogo
        image.translatesAutoresizingMaskIntoConstraints = false
        return image
    }()
    
    let userNameTextField = GFTextField()
    let callToActionButton = GFButton(backgroundColor: .systemGreen, title: "Get Followers")
    var logoImageViewTopConstraint: NSLayoutConstraint!
    var isUsernameEntered: Bool {!userNameTextField.text!.isEmpty}
    

    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        userNameTextField.delegate = self
        
        
        setUPSubViews()
        configureLogoImageView()
        setUpConstraints()
        createDismissKeyboardTapGesture()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        userNameTextField.text = ""
        navigationController?.setNavigationBarHidden(true, animated: true)
    }
    
    func createDismissKeyboardTapGesture() {
        let tap = UITapGestureRecognizer(target: view, action: #selector(UIView.endEditing))
        view.addGestureRecognizer(tap)
    }
    
    @objc func pushFollowersListVC() {
        
        guard isUsernameEntered else {
            
            presentGFAlert(title: "Empty Username", message: "Please enter a username 🤡", buttonTitle: "Ok")
            return
            
        }
        
        userNameTextField.resignFirstResponder()
        
        let followersListVc = FollowersListVC(username: userNameTextField.text)
        navigationController?.pushViewController(followersListVc, animated: true)
    }
    
    private func setUPSubViews() {
        [logoImageView, userNameTextField, callToActionButton].forEach {view.addSubview($0)}
        
        callToActionButton.addTarget(self, action: #selector(pushFollowersListVC), for: .touchUpInside)
    }
    
    func configureLogoImageView() {
        let topConstraintConstant: CGFloat = DeviceTypes.isiPhoneSE || DeviceTypes.isiPhone8Zoomed ? 20 : 80
        
        logoImageViewTopConstraint = logoImageView.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor, constant: topConstraintConstant)
        logoImageViewTopConstraint.isActive = true
    }
    
    private func setUpConstraints() {
        NSLayoutConstraint.activate([
            
            // MARK: - Logo image
            
            logoImageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            logoImageView.heightAnchor.constraint(equalToConstant: 200),
            logoImageView.widthAnchor.constraint(equalToConstant: 200),
            
            // MARK: - Username Textfield
            
            userNameTextField.topAnchor.constraint(equalTo: logoImageView.bottomAnchor, constant: 48),
            userNameTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            userNameTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            userNameTextField.heightAnchor.constraint(equalToConstant: 40),
            
            // MARK: - Get Followers button
            
            callToActionButton.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.bottomAnchor, constant: -70),
            callToActionButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 50),
            callToActionButton.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
            callToActionButton.heightAnchor.constraint(equalToConstant: 50)
            
            
        ])
    }
}

extension SearchVC: UITextFieldDelegate {
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        pushFollowersListVC()
        
        print("Go button tapped")
        return true
    }
}
