//
//  Persistent.swift
//  FUNBOX
//
//  Created by Александр Осипов on 29.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation
import RealmSwift

class StorageServis {
    
    static var shared = StorageServis()
    private let realm = try! Realm()
    
    func writeModel(model: ModelRealm) {
        try! self.realm.write {
            self.realm.create(ModelRealm.self, value: model, update: .modified)
            self.realm.refresh()
        }
    }
    
    func readObject(store: Bool) -> [ModelRealm] {
        
        let object: [ModelRealm]
        
        if store {
            object = realm.objects(ModelRealm.self).filter("count > 0").array
        } else {
            object = realm.objects(ModelRealm.self).array
        }
        
        return object
    }
    
    func deleteModel(model: ModelRealm) {
        try! self.realm.write {
            self.realm.delete(model)
            self.realm.refresh()
        }
    }
    
}

extension List {
    var array: [Element] {
        return self.count > 0 ? self.map { $0 } : []
    }
    
    func toArray<T>(ofType: T.Type) -> [T] {
            var array = [T]()
            for i in 0 ..< count {
                if let result = self[i] as? T {
                    array.append(result)
                }
            }
            return array
        }
}

extension Results {
    var array: [Element] {
        return self.count > 0 ? self.map { $0 } : []
    }
}
