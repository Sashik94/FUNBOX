//
//  FirstViewController.swift
//  FUNBOX
//
//  Created by Александр Осипов on 28.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class StoreFrontViewController: UIViewController {

    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var buyButton: UIButton!
    
    var networking = NetworkDataFetcher()
    var models: [ModelRealm] = []
    var numberScreen: Int = 1
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(true)
        
        if UserDefaults.standard.object(forKey: "FirstLoad") == nil {
            UserDefaults.standard.set(false, forKey: "FirstLoad")
            networking.downloadFile()
        }
        models = StorageServis.shared.readObject(store: true)
        addSwipe()
        filling()
    }
    
    func addSwipe() {
        let swipeLeft = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeLeft.direction = .left
        self.view.addGestureRecognizer(swipeLeft)
        
        let swipeRight = UISwipeGestureRecognizer(target: self, action: #selector(handleGesture))
        swipeRight.direction = .right
        self.view.addGestureRecognizer(swipeRight)
    }
    
    @objc func handleGesture(gesture: UISwipeGestureRecognizer) -> Void {
        if gesture.direction == .right {
            print("Swipe Right")
            numberScreen -= 1
            swipe(direction: .right)
        }
        else if gesture.direction == .left {
            print("Swipe Left")
            numberScreen += 1
            swipe(direction: .left)
        }
    }
    
    func swipe(direction: UISwipeGestureRecognizer.Direction) {
        let transition = CATransition()
        transition.duration = 0.5
        transition.type = CATransitionType.push
        if direction == .left {
            transition.subtype = CATransitionSubtype.fromRight
        } else {
            transition.subtype = CATransitionSubtype.fromLeft
        }
        if numberScreen > models.count {
            numberScreen -= 1
            return
        } else if numberScreen < 1 {
            numberScreen += 1
            return
        }
        transition.timingFunction = CAMediaTimingFunction(name: CAMediaTimingFunctionName.easeInEaseOut)
        contentView.layer.add(transition, forKey: kCATransition)
        filling()
    }
    
    func filling() {
        if models.count == 0 {
            nameLabel.text = "Наименование"
            priceLabel.text = ""
            countLabel.text = ""
            buyButton.isHidden = true
            return
        } else if numberScreen == 0 {
            numberScreen = 1
        }
        let model = models[numberScreen - 1]
        nameLabel.text = model.name
        priceLabel.text = model.price.description
        countLabel.text = model.count.description + " шт."
        buyButton.isHidden = false
    }
    
    @IBAction func buyActionButton(_ sender: UIButton) {
        let model = models[numberScreen - 1]
        let newModel = ModelRealm(name: model.name, price: model.price, count: model.count - 1)
        StorageServis.shared.writeModel(model: newModel)
        models = StorageServis.shared.readObject(store: true)
        let swipeDirection = UISwipeGestureRecognizer()
        swipeDirection.direction = .right
        if numberScreen == 1 {
            swipeDirection.direction = .left
        }
        if newModel.count == 0 {
            if numberScreen > 1 {
                numberScreen -= 1
            }
            swipe(direction: swipeDirection.direction)
        }
        filling()
    }
    
}

