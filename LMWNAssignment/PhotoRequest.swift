//
//  PhotoRequest.swift
//  LMWNAssignment
//
//  Created by TPmac on 20/3/2565 BE.
//

import Foundation

enum PhotosError: Error{
    case noDataAvailable
    case canNotProcessData
}

struct PhotosRequest{
    let resourceURL: URL
    
    init(page: Int){
        let resourceString = "https://api.500px.com/v1/photos?feature=popular&page=\(page)"
        
        guard let resourceURL = URL(string: resourceString) else { fatalError() }
        self.resourceURL = resourceURL
    }
    
    func getPhotos(completion: @escaping(Result<[PhotoDetail], PhotosError>) -> Void){
        let dataTask = URLSession.shared.dataTask(with: resourceURL){data, _, _ in
            guard let jsonData = data else {
                completion(.failure(.noDataAvailable))
                return
            }
            
            do{
                let decoder = JSONDecoder()
                let photoResponse = try decoder.decode(PhotosResponse.self, from: jsonData)
                let photoDetails = photoResponse.photos
                completion(.success(photoDetails))
            }catch{
                completion(.failure(.canNotProcessData))
            }
        }
        dataTask.resume()
    }
    
}
