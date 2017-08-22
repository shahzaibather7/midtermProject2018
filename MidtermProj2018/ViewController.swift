//
//  ViewController.swift
//  MidtermProj2018
//
//  Created by Mohammad Shahzaib Ather on 2017-08-21.
//  Copyright © 2017 Mohammad Shahzaib Ather. All rights reserved.
//
import Firebase
import UIKit


class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        

        
         view.backgroundColor = UIColor.white
// Do any additional setup after loading the view, typically from a nib.
    

    navigationItem.leftBarButtonItem = UIBarButtonItem.init(title:"Logout" , style: .plain, target: self, action: #selector(handleLogout))
 
        
        navigationItem.rightBarButtonItem = UIBarButtonItem.init(title: "Chat", style: .plain, target: self, action: #selector(handleChat))
}

    func handleLogout () {
        let loginController = LoginController()
        present(loginController, animated: true, completion: nil)
    
}

    func handleChat (){
        let chatLogController = ChatLogControllerTableViewController(collectionViewLayout: UICollectionViewFlowLayout())
        present(chatLogController, animated: true, completion: nil)
    }
    
}

