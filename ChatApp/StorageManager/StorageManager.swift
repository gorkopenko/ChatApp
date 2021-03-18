//
//  StorageManager.swift
//  123
//
//  Created by Gorkopenko Sergey on 11.03.2021.
//  Copyright © 2021 Gorkopenko Sergey. All rights reserved.
//

import Foundation
import FirebaseStorage

final class StorageManager {
    static let shared = StorageManager()
    private let storage = Storage.storage().reference()
    
    public typealias UpLoadPictureCompletion = (Result<String, Error>) -> Void
    
    public func uploadProfilePicture(
        with data: Data,
        filename: String,
        completion: @escaping UpLoadPictureCompletion)
    {
        storage.child("images/\(filename)").putData(data, metadata: nil, completion: {metadata, error in
            guard error == nil else {
                print(error!)
                completion(.failure(StorageErrors.failedToUpload))
                return
            }
            self.storage.child("images/\(filename)").downloadURL(completion: { url, error in
                guard error == nil else {
                    print(error!)
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                
                guard let url = url else {
                    print("failed to get download")
                    completion(.failure(StorageErrors.failedToGetDownloadUrl))
                    return
                }
                let urlString = url.absoluteString
                print("download url return:\(urlString)")
                completion(.success(urlString))
            })
        })
    }
    
    public enum StorageErrors: Error {
        case failedToUpload
        case failedToGetDownloadUrl
    }
}
