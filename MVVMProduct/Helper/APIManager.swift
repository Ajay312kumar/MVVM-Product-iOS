//
//  APIManager.swift
//  MVVMProduct
//
//  Created by ajay kumar on 12/04/24.
//

import Foundation

enum DataError: Error{
    
    case invalidResponse
    case invalidURL
    case invalidData
    case network(Error?)
    
}

typealias handler = (Result<[ProductModel], DataError>) -> Void

// signletone Design pattern
final class APIManager{
    
    static let shared = APIManager()
    private init( ) {}
    
    func fetchProducts(completion: @escaping handler)  {
        
        guard let url = URL(string: Constant.API.url) else{
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data = data, error == nil else{
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  200 ... 299 ~= response.statusCode else{
                completion(.failure(.invalidResponse))
                return
            }
            
            do{
                let product = try JSONDecoder().decode([ProductModel].self, from: data)
                completion(.success(product))
            }catch{
                completion(.failure(.network(error)))
            }
            
        }.resume()
    }
}
