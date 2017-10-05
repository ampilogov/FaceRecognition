//
//  SecurityStorage.swift
//  FaceRecognition
//
//  Created by Vitaliy Ampilogov on 10/5/17.
//  Copyright © 2017 Vitaliy Ampilogov. All rights reserved.
//

import Foundation
import RNCryptor

protocol SecurityStorageProtocol {
    func save(_ data: Data, fileName: String)
    func read(fileName: String) -> Data?
}

class SecurityStorage: SecurityStorageProtocol {
    
    private let documentsUrl = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first
    
    private let password: String
    
    init(password: String) {
        self.password = password
    }
    
    func save(_ data: Data, fileName: String) {
        
        guard  let documentsUrl = documentsUrl else {
            return
        }

        let fileUrl = documentsUrl.appendingPathComponent(fileName)
        let encryptedData = RNCryptor.encrypt(data: data, withPassword: password)
        
        try? encryptedData.write(to: fileUrl)
    }
    
    func read(fileName: String) -> Data? {
        
        guard  let documentsUrl = documentsUrl else {
            return nil
        }

        let fileUrl = documentsUrl.appendingPathComponent(fileName)
        guard let encryptedData = try? Data.init(contentsOf: fileUrl),
            let decriptedData = try? RNCryptor.decrypt(data: encryptedData, withPassword: password)else {
            return nil
        }
        
        return decriptedData
    }
    
}
