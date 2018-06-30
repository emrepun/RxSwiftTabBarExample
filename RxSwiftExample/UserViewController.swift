//
//  UserViewController.swift
//  RxSwiftExample
//
//  Created by Emre HAVAN on 30.06.2018.
//  Copyright © 2018 Emre HAVAN. All rights reserved.
//

import UIKit
import RxSwift

class UserViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {
    
    @IBOutlet weak var tableView: UITableView!
    
    var userToShowInFirstVc = Variable(User(name: "Ayşe", age: 25, city: "Istanbul"))
    var userToShowInFirstVcObservable: Observable<User> {
        return userToShowInFirstVc.asObservable()
    }
    
    var userArray = Variable([User]())
    var userArrayObservable: Observable<[User]> {
        return userArray.asObservable()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        deployUsers()
        tableView.tableFooterView = UIView()
    }
    
    func deployUsers() {
        userArray.value = [
            User(name: "Mehmet", age: 23, city: "Istanbul"),
            User(name: "Ogul", age: 24, city: "Eskişehir"),
            User(name: "Gökhan", age: 26, city: "Münih")
        ]
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return userArray.value.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "cell") else {
            return UITableViewCell()
        }
        
        cell.textLabel?.text = userArray.value[indexPath.row].name
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        userToShowInFirstVc.value = userArray.value[indexPath.row]
    }
}
