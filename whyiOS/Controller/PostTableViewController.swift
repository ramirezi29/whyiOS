//
//  PostTableViewController.swift
//  whyiOS
//
//  Created by Ivan Ramirez on 9/11/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import UIKit

class PostTableViewController: UITableViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        fetchPost()
    }
    
    func fetchPost() {
        PostController.shared.fetchPost{ (success) in
            if success {
                DispatchQueue.main.async {
                    self.tableView.reloadData()
                }
            }else {
                DispatchQueue.main.async {
                    self.title = "there was an error with your request"
                    print("Error with fetchingpost")
                }
            }
        }
    }    // MARK: - Table view data source
    
    
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return PostController.shared.posts.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "postCell", for: indexPath) as? PosTableViewCell else {return UITableViewCell()}
        
        let posts = PostController.shared.posts[indexPath.row]
        cell.post = posts
        
        
        return cell
    }
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
}


extension PostTableViewController {
    
    func presentAlertController(){
        
        var nameTextFieldForReason: UITextField?
        var reasonTextFieldForReason: UITextField?
        // var cohortTextFieldForReason: UITextField?
        
        let alertController = UIAlertController(title: "Add your reason 🧀", message: nil, preferredStyle: .alert)
        
        alertController.addTextField { (nameTextField) in
            nameTextField.placeholder = "Enter Your Name"
            nameTextFieldForReason = nameTextField
            
        }
        
        alertController.addTextField { (reasonTextField) in
            reasonTextField.placeholder = "Why iOS 🍏"
            reasonTextFieldForReason = reasonTextField
        }
        
        let dismissAction = UIAlertAction(title: "Cancel", style: .cancel, handler: nil)
        let saveAction = UIAlertAction(title: "Add Reason", style: .default) { (_) in
            guard let name = nameTextFieldForReason?.text,
                let reason = reasonTextFieldForReason?.text else {return }
            PostController.shared.postReason(with: name, reason: reason, completion: { (success) in
                if success {
                    DispatchQueue.main.async {
                        
                        self.tableView.reloadData()
                    }
                }
            })
        }
        alertController.addAction(dismissAction)
        alertController.addAction(saveAction)
        
        present(alertController, animated: true)
    }
    
    
    @IBAction func refreshButtonTapped(_ sender: UIBarButtonItem) {
        print("refresh button tapped")
        fetchPost()
    }
    
    @IBAction func addButtonTapped(_ sender: UIBarButtonItem) {
        presentAlertController()
        print("add button tapped")
    }
}
