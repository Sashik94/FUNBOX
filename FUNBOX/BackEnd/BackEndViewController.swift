//
//  SecondViewController.swift
//  FUNBOX
//
//  Created by Александр Осипов on 28.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class BackEndViewController: UIViewController {
    
    @IBOutlet weak var productTableView: UITableView!
    
    var models: [ModelRealm] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        filling()
    }
    
    func filling() {
        models = StorageServis.shared.readObject(store: false)
        productTableView.reloadData()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let editVC = segue.destination as! EditViewController
        if segue.identifier == "Edit" {
            let productViewCell = sender as! UITableViewCell
            let indexPath = productTableView.indexPath(for: productViewCell)!
            editVC.model = models[indexPath.row]
        }
        editVC.reloadView = { self.filling() }
    }
    
}

extension BackEndViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return models.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductCell", for: indexPath) as! BackEndTableViewCell
        let model = models[indexPath.row]
        
        cell.modelCell = model
        
        return cell
    }
    
}
