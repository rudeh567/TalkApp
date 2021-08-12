//
//  MainViewController.swift
//  HowITalk
//
//  Created by GSM08 on 2021/07/15.
//

import UIKit
import SnapKit
import Firebase

class PeopleViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    var array : [UserModel] = []
    var tableView : UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()

        tableView = UITableView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.register(UITableViewCell, forCellReuseIdentifier: "Cell")
        view.addSubview(tableView)
        
        tableView.snp.makeConstraints { (m) in
            m.top.equalTo(view).offset(20)
            m.bottom.left.right.equalTo(view)
            
        }
        
        Database.database().reference().child("users").observe(DataEventType.value, with: { (snapshot) in
            
            self.array.removeAll()
            
            for child in snapshot.children {
                
                let fchild = child as! DataSnapshot
                let userModel = UserModel()
                
                userModel.setValuesForKeys(fchild.value as! [String : Any])
                self.array.append(userModel)
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return array.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let imageView = UIImageView()
        cell.addSubview(imageView)
        imageView.snp.makeConstraints { (m) in
            m.centerY.equalTo(cell)
            m.left.equalTo(cell)
            m.height.width.equalTo(50)
        }
        
        URLSession.shared.dataTask(with: URL(string: array[indexPath.row].profileImageUrl!)!) { (data, response, err) in
            
            
            DispatchQueue.main.async {
                imageView.image = UIImage(data: data!)
                imageView.layer.cornerRadius = imageView.frame.size.width/2
                imageView.clipsToBounds = true
            }
            
        }.resume()
        
        let label = UILabel()
        cell.addSubview(label)
        label.snp.makeConstraints { (m) in
            m.centerY.equalTo(cell)
            m.left.equalTo(imageView.snp.right).offset(30)
        }
        
        label.text = array[indexPath.row].userName
        
        return cell
    }

    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
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
