//
//  ViewController.swift
//  AppChat
//
//  Created by Nguyên Nguyễn Khôi on 03/06/2024.
//

import UIKit

struct People {
    let avatar: String
    let name: String
}

class HomeViewController: UIViewController {
    @IBOutlet weak var tableView: UITableView!
    
    private let homeCellIdentifier = "HomeCell"
    
    var people = [
        People(avatar: "a1", name: "Nguyen"),
        People(avatar: "a2", name: "Long"),
        People(avatar: "a3", name: "Nam"),
        People(avatar: "a4", name: "Vy")
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.register(UINib(nibName: homeCellIdentifier, bundle: nil), forCellReuseIdentifier: homeCellIdentifier)
        self.navigationController?.navigationBar.prefersLargeTitles = true
        self.title = "Home"
    }


}

extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return people.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: homeCellIdentifier) as!  HomeCell
        cell.binding(people: people[indexPath.row])
        cell.accessoryType = .disclosureIndicator
        return cell
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 44+16
    }
}
