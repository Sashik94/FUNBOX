//
//  ModelRealm.swift
//  FUNBOX
//
//  Created by Александр Осипов on 29.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation
import RealmSwift

class ModelRealm: Object {
    @objc dynamic var name: String = ""
    @objc dynamic var price: Int = 0
    @objc dynamic var count: Int = 0
    
    override static func primaryKey() -> String? {
      return "name"
    }
    
    required init(name: String, price: Int, count: Int) {
        self.name = name
        self.price = price
        self.count = count
    }
    
    required init(partsModel: [String]) {
        if partsModel.count == 3 {
            self.name = partsModel[0]
            self.price = Int(partsModel[1]) ?? 0
            self.count = Int(partsModel[2]) ?? 0
        }
    }
    
    required init() {
        self.name = ""
        self.price = 0
        self.count = 0
    }
    
}
