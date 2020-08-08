//
//  NetworkDataFetcher.swift
//  FUNBOX
//
//  Created by Александр Осипов on 29.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import Foundation

class NetworkDataFetcher {
    
    func downloadFile() {
        sleep(10)
        guard let path = Bundle.main.path(forResource: "data", ofType: "csv") else {
            return
        }
        let fileURL = URL(fileURLWithPath: path)
        let file: FileHandle? = try? FileHandle(forReadingFrom: fileURL)
        if file != nil {
            let data = file?.readDataToEndOfFile()
            file?.closeFile()
            let fileString = NSString(data: data!, encoding: String.Encoding.utf8.rawValue)
            print(fileString!)
            let lines = fileString!.components(separatedBy: "\r\n")
            for line in lines {
                let line = line.replacingOccurrences(of: ", ", with: "")
                let modelParts = line.split(separator: "\"").map { String($0) }
                let model = ModelRealm(partsModel: modelParts)
                StorageServis.shared.writeModel(model: model)
            }
        }
        else {
            print("Ooops! Something went wrong!")
        }
    }
}
