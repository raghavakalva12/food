//
//  SavedViewController.swift
//  food
//
//  Created by Raghava on 10/04/21.
//  Copyright © 2021 Raghava. All rights reserved.
//

import UIKit

class SavedViewController: UIViewController,UITableViewDelegate,UITableViewDataSource{
    @IBOutlet weak var tableView: UITableView!
    var dataSourceArr = [Food]()
    override func viewDidLoad() {
        super.viewDidLoad()
        self.dataSourceArr =  DataManager.instance.fetchData()
        tableView.dataSource = self
        tableView.delegate = self
        // Do any additional setup after loading the view.
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataSourceArr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cellList = tableView.dequeueReusableCell(withIdentifier: "cellData", for: indexPath) as! SavedTableViewCell
        cellList.foodNames.text! = dataSourceArr[indexPath.row].foodName!
        cellList.foodImage.image = UIImage(data: self.dataSourceArr[indexPath.row].foodImage!)
        cellList.foodInstr.text! = dataSourceArr[indexPath.row].foodInt!
    return cellList
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 639
    }

}
