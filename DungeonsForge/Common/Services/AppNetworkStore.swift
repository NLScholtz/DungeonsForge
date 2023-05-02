//
//  AppNetworkStore.swift
//  DungeonsForge
//
//  Created by Nicole Scholtz on 2023/05/02.
//

import Foundation

protocol AppNetwordStorable {
    func makeRequest<Generic: Codable>(url: URL?,
                                       model: Generic.Type,
                                       completion: @escaping (Result<Generic, Error>) -> Void)
}

class AppNetworkStore: AppNetwordStorable {
    enum CustomError: Error{
        case invalidResponse
        case invalidRequest
        case invalidUrl
        case invalidData
    }
    
    func makeRequest<Generic: Codable>(url: URL?,
                                       model: Generic.Type,
                                       completion: @escaping (Result<Generic, Error>) -> Void) {
        
        guard let endpointUrl = url else {
            completion(.failure(CustomError.invalidUrl))
            return
        }
        let apiTask = URLSession.shared.dataTask(with: endpointUrl) { (data, _, error) in
            DispatchQueue.main.async {
                guard let safeData = data else {
                    if let error = error{
                        completion(.failure(error))
                    } else {
                        completion(.failure(CustomError.invalidData))
                    }
                    return
                }
                
                do {
                    let result = try JSONDecoder().decode(model, from: safeData)
                    completion(.success(result))
                } catch {
                    completion(.failure(error))
                }
            }
        }
        apiTask.resume()
    }
}
