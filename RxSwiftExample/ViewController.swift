//
//  ViewController.swift
//  RxSwiftExample
//
//  Created by Emre HAVAN on 30.06.2018.
//  Copyright © 2018 Emre HAVAN. All rights reserved.
//

import UIKit
import RxSwift

class ViewController: UIViewController {

    var userToDisplay = Variable(User(name: "Ayse", age: 25, city: "Istanbul"))
    var userToDisplayObservable: Observable<User> {
        return userToDisplay.asObservable()
    }
    
    let disposeBag = DisposeBag()
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var ageLabel: UILabel!
    @IBOutlet weak var cityLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        subscribeToUsers()
        configureLabels()
        
    }
    
    func configureLabels() {
        //1
        userToDisplayObservable.subscribe(onNext: { [weak self] user in
            //2
            self?.nameLabel.text = user.name
            self?.ageLabel.text = String(user.age)
            self?.cityLabel.text = user.city
        }).disposed(by: disposeBag)//3
    }
    
    func subscribeToUsers() {
        //1
        let secondVC = tabBarController?.viewControllers?.last as! UserViewController
        secondVC.userToShowInFirstVcObservable.subscribe(onNext: { [weak self] user in
            //2
            self?.userToDisplay.value = user
            //3
            self?.configureLabels()
        }).disposed(by: disposeBag)
    }
}

