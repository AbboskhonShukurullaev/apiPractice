//
//  NetworkManager.swift
//  apiPractice
//
//  Created by Abbos Shukurullaev on 03/02/22.
//

import Foundation

enum NetworkManagerError: Error {
    case badResponse(URLResponse?)
    case badData
    case badLocalUrl
}

fileprivate
struct APIResponse: Codable {
    let results: [Post]
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private let images = NSCache<NSString, NSData>()
    
    let session: URLSession
    
    init() {
        let configuration = URLSessionConfiguration.default
        session = URLSession(configuration: configuration)
    }
    
    private func components() -> URLComponents {
        var components = URLComponents()
        components.scheme = "https"
        components.host = "api.unsplash.com"
        return components
    }
    
    private func request(url: URL) -> URLRequest {
        var request = URLRequest(url: url)
        request.addValue("Client-ID \(accessKey)", forHTTPHeaderField: "Authorization")
        return request
    }
    
    func posts(query: String, completion: @escaping ([Post]?, Error?) -> Void) {
        var components = components()
        components.path = "/search/photos"
        components.queryItems = [
            URLQueryItem(name: "query", value: query)
        ]
        
        let request = request(url: components.url!)
        
        let task = session.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      completion(nil, NetworkManagerError.badResponse(response))
                      return
                  }
            
            guard let data = data else {
                completion(nil, NetworkManagerError.badData)
                return
            }
            
            do {
                let response = try JSONDecoder().decode(APIResponse.self, from: data)
                completion(response.results, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    private func download(imageURL: URL, completion: @escaping (Data?, Error?) -> Void) {
        if let imageData = images.object(forKey: imageURL.absoluteString as NSString) {
            print("Using cached images")
            completion(imageData as Data, nil)
            return
        }
        
        let task = session.downloadTask(with: imageURL) { localURL, response, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let httpResponse = response as? HTTPURLResponse,
                  (200...299).contains(httpResponse.statusCode) else {
                      completion(nil, NetworkManagerError.badResponse(response))
                      return
                  }
            
            guard let localURL = localURL else {
                completion(nil, NetworkManagerError.badLocalUrl)
                return
            }
            
            do {
                let data = try Data(contentsOf: localURL)
                self.images.setObject(data as NSData, forKey: imageURL.absoluteString as NSString)
                completion(data, nil)
            } catch let error {
                completion(nil, error)
            }
        }
        task.resume()
    }
    
    func image(post: Post, completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: post.urls.regular)!
        download(imageURL: url, completion: completion)
    }
    
    func profileImage(post: Post, completion: @escaping (Data?, Error?) -> Void) {
        let url = URL(string: post.user.profile_image.medium)!
        download(imageURL: url, completion: completion)
    }
}
