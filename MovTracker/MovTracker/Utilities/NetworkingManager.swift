//
//  NetworkingManager.swift
//  MovTracker
//
//  Created by ali alhawas on 16/04/1445 AH.
//

import Foundation
import Combine

class NetworkingManager {
    
    enum NetworkingError: LocalizedError {
        case badURLResponse(url: URL)
        case nknown
        
        var errorDescription: String? {
            switch self {
                case .badURLResponse(url: let  url): return "[🔥] Bad response from URL: \(url)"
                case .nknown: return "[⚠️] Unknown error occured."
            }
        }
    }
    
    static func download(url: URL) -> AnyPublisher<Data,Error> {
        return URLSession.shared.dataTaskPublisher(for: url)
//            .subscribe(on: DispatchQueue.global(qos: .default)) // no need because it automaticly do that in background thread
            .tryMap({ try handleURLResponse(output: $0, url: url)})
            .retry(3)
//            .receive(on: DispatchQueue.main) // return to main thread after decode in each data service that would be better
            .eraseToAnyPublisher()
    }
    
    static func handleURLResponse(output: URLSession.DataTaskPublisher.Output, url: URL) throws -> Data {
        guard let response = output.response as?HTTPURLResponse, response.statusCode >= 200 && response.statusCode < 300 else {
            throw NetworkingError.badURLResponse(url: url)
//            throw URLError(.badServerResponse)
        }
        return output.data
    }
    
    static func handleCompletion(completion: Subscribers.Completion<Error>){
        switch completion {
            case .finished: break
            case .failure(let error): print(error.localizedDescription)
        }
    }
}
