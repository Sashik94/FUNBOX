//
//  EditViewController.swift
//  FUNBOX
//
//  Created by Александр Осипов on 29.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class EditViewController: UIViewController {
    
    @IBOutlet weak var nameTextView: UITextView!
    @IBOutlet weak var priceTextView: UITextView!
    @IBOutlet weak var countTextView: UITextView!
    
    var reloadView: (() -> Void)?
    var model: ModelRealm!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let model = model { configurationView(model) }
    }
    
    @IBAction func searchTapGestureRecognizer(_ sender: UITapGestureRecognizer) {
        self.view.endEditing(true)
    }
    
    func configurationView(_ model: ModelRealm) {
        nameTextView.text = model.name
        priceTextView.text = model.price.description
        countTextView.text = model.count.description
    }

    @IBAction func saveButton(_ sender: UIButton) {
        
        let newModel = ModelRealm(name: nameTextView.text, price: Int(priceTextView.text!) ?? 0, count: Int(countTextView.text!) ?? 0)
        DispatchQueue.global(qos: .background).async {
            sleep(10)
            StorageServis.shared.writeModel(model: newModel)
            DispatchQueue.main.async {
                self.reloadView!()
            }
        }
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func cancelBatton(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
