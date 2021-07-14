//
//  SignupViewController.swift
//  HowTalk
//
//  Created by GSM08 on 2021/07/14.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseABTesting
import FirebaseCoreDiagnostics

class SignupViewController: UIViewController {

    @IBOutlet var email: UITextField!
    @IBOutlet var name: UITextField!
    @IBOutlet var password: UITextField!
    
    @IBOutlet var signup: UIButton!
    @IBOutlet var cancel: UIButton!
    
    let remoteconfig = RemoteConfig.remoteConfig()
    var color : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let statusBar = UIView()
        self.view.addSubview(statusBar)
        statusBar.snp.makeConstraints { (m) in
            m.right.top.left.equalTo(self.view)
            m.height.equalTo(20)
        }
        
        color = remoteconfig["splash_background"].stringValue
        statusBar.backgroundColor = UIColor(hex: color!)
        signup.backgroundColor = UIColor(hex: color!)
        cancel.backgroundColor = UIColor(hex: color!)
        
        // Do any additional setup after loading the view.
    }
    
    func signupEvent() {
        Auth.auth().createUser(withEmail: email.text!, password: password.text!) { authResult, error in
            
            FirebaseApp.configure()
            let userID = Auth.auth().currentUser!.uid
            
            var ref: DatabaseReference!

            ref = Database.database().reference()
            
            Database.database().refernce().child("users").child(userID).setValue(["name":name.text!])
        }
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
