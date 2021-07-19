//
//  LoginViewController.swift
//  HowITalk
//
//  Created by GSM08 on 2021/07/14.
//

import UIKit
import Firebase

class LoginViewController: UIViewController {
    
    @IBOutlet var password: UITextField!
    @IBOutlet var email: UITextField!
    @IBOutlet var loginButton: UIButton!
    @IBOutlet var signup: UIButton!
    
    let remoteconfig = RemoteConfig.remoteConfig()
    var color : String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        try! Auth.auth().signOut()
        let statusBar = UIView()
        self.view.addSubview(statusBar)
        statusBar.snp.makeConstraints { (m) in
            m.right.top.left.equalTo(self.view)
            m.height.equalTo(20)
        }
        
        
        color = remoteconfig["splash_background"].stringValue
        
        statusBar.backgroundColor = UIColor(hex: color)
        loginButton.backgroundColor = UIColor(hex: color)
        signup.backgroundColor = UIColor(hex: color)
        
        loginButton.addTarget(self, action: #selector(loginEvent), for: .touchUpInside)
        
        signup.addTarget(self, action: #selector(presentSingup), for: .touchUpInside)
        
        Auth.auth().addStateDidChangeListener { (auth, user) in
            if user != nil {
                let view = self.storyboard?.instantiateViewController(withIdentifier: "MainViewController") as! MainViewController
                self.present(view, animated: true, completion: nil)
            }
        }
        // Do any additional setup after loading the view.
    }
    
    @objc func loginEvent() {
        
        Auth.auth().signIn(withEmail: email.text!, password: password.text!) { (user, err) in
            
            if err != nil {
                let alert = UIAlertController(title: "에러", message: err.debugDescription, preferredStyle: UIAlertController.Style.alert)
                alert.addAction(UIAlertAction(title: "확인", style: UIAlertAction.Style.default, handler: nil))
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    @objc func presentSingup() {
        let view = self.storyboard?.instantiateViewController(withIdentifier: "SignupViewController") as! SignupViewController
        
        self.present(view, animated: true, completion: nil)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
