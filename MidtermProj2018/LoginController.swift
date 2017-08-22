//
//  LoginController.swift
//  MidtermProj2018
//
//  Created by Mohammad Shahzaib Ather on 2017-08-21.
//  Copyright © 2017 Mohammad Shahzaib Ather. All rights reserved.
//


import UIKit
import Firebase

class LoginController: UIViewController {
    
    let inputsContainerView : UIView  = {
        
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.translatesAutoresizingMaskIntoConstraints = false
        view.layer.cornerRadius = 5
        view.layer.masksToBounds = true
        return view
    }()
    
    lazy var loginRegisterButton : UIButton = {
        let button = UIButton(type:.system)
        button.backgroundColor = UIColor.gray
        button.setTitle("Register", for: UIControlState.normal)
        button.setTitleColor(UIColor.white, for: UIControlState.normal)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.addTarget(self, action: #selector(handleRegister), for: .touchUpInside)
        return button
    }()
    
    func handleRegister() {
        guard let email = emailTextField.text , let password = passwordTextField.text , let name = nameTextField.text
            else {
                print("form is not valid")
                return
        }
        Auth.auth().createUser(withEmail: email, password: password) { (user: User?, error) in
            if error != nil{
                return
            }
//Authenticates user
            
            guard (user?.uid) != nil else {
                return
            }
            
            
            let ref = Database.database().reference(fromURL:"https://midtermproj2018.firebaseio.com/" )
            let usersRef = ref.child("users").child((user?.uid)!)
            let values = ["name": name, "email" :email]
            usersRef.updateChildValues(values, withCompletionBlock: { (err, ref) in
                if error != nil{
                    return
                }
                print("Saved user successfully into Firebase database")
            })
            
            
            
        }
        
    }
    
    
    
    let nameTextField : UITextField = {
        let tf = UITextField()
        tf.placeholder = "Name"
        tf.translatesAutoresizingMaskIntoConstraints = false
        return tf
    } ()
    
    let emailTextField : UITextField = {
        let emailTextField = UITextField()
        emailTextField.placeholder = "Email"
        emailTextField.translatesAutoresizingMaskIntoConstraints = false
        return emailTextField
    } ()
    
    let passwordTextField : UITextField = {
        let passwordtf = UITextField()
        passwordtf.placeholder = "Password"
        passwordtf.translatesAutoresizingMaskIntoConstraints = false
        passwordtf.isSecureTextEntry = true
        return passwordtf
    } ()
    
    //VIEW DID LOAD
    override func viewDidLoad() {
        super.viewDidLoad()
        
        view.backgroundColor = UIColor(r:66, g: 244, b: 188)
        view.addSubview(inputsContainerView)
        view.addSubview(loginRegisterButton)
        
        
        
        setupInputsContainerView()
        setupRegisterButtonView()
       // handleRegister()
        
    }
    
    func setupInputsContainerView() {
        
        //Input textfield
        
        inputsContainerView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        inputsContainerView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        inputsContainerView.widthAnchor.constraint(equalTo: view.widthAnchor, constant: -24).isActive = true
        inputsContainerView.heightAnchor.constraint(equalToConstant: 150).isActive = true
        
        //Name textfield
        inputsContainerView.addSubview(nameTextField)
        nameTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        nameTextField.topAnchor.constraint(equalTo: inputsContainerView.topAnchor ).isActive = true
        nameTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        nameTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        //Email textfield
        inputsContainerView.addSubview(emailTextField)
        emailTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        emailTextField.topAnchor.constraint(equalTo: nameTextField.bottomAnchor ).isActive = true
        emailTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        emailTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        //Password textfield
        
        inputsContainerView.addSubview(passwordTextField)
        passwordTextField.leftAnchor.constraint(equalTo: inputsContainerView.leftAnchor, constant: 12).isActive = true
        passwordTextField.topAnchor.constraint(equalTo: emailTextField.bottomAnchor ).isActive = true
        passwordTextField.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        passwordTextField.heightAnchor.constraint(equalTo: inputsContainerView.heightAnchor, multiplier: 1/3).isActive = true
        
        
        
        
    }
    
    func setupRegisterButtonView () {
        loginRegisterButton.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        loginRegisterButton.centerYAnchor.constraint(equalTo: inputsContainerView.bottomAnchor, constant: 20).isActive = true
        loginRegisterButton.widthAnchor.constraint(equalTo: inputsContainerView.widthAnchor).isActive = true
        loginRegisterButton.heightAnchor.constraint(equalToConstant: 30).isActive = true
    }
    
    
    
    override var preferredStatusBarStyle: UIStatusBarStyle {
        return .lightContent;
    }
    
}

extension UIColor {
    convenience init(r :CGFloat ,  g:CGFloat, b: CGFloat) {
        self.init (red: r/255 , green: g/255, blue: b/255, alpha:1 )
    }
}

