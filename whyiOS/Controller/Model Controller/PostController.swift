//
//  PostController.swift
//  whyiOS
//
//  Created by Ivan Ramirez on 9/11/18.
//  Copyright © 2018 ramcomw. All rights reserved.
//

import Foundation

class PostController: Codable {
    
    
    
    static let shared = PostController()
    
    var posts: [Post] = []
    
    let baseURL = URL(string:"https://whydidyouchooseios.firebaseio.com/reasons")
    
    
    /*
     --------------------------------
     Create Func below
     --------------------------------
     */
    
    func postReason(with name: String, reason: String, completion: @escaping (Bool) -> Void) {
        let post = Post(name: name, reason: reason)
        
        enum HttpMethod: String {
            case put = "PUT"
            case post = "POST"
            case patch = "Patch"
            case delete = "Delete"
        }
        
        guard let url = baseURL else {
            fatalError("bad url")
        }
        
        let builtURL = url.appendingPathExtension("json")
        //let builtURL = url.appendingPathComponent(post.name).appendingPathExtension("json")
        
        //Request
        var request = URLRequest(url: builtURL)
        
        do{
            let data = try JSONEncoder().encode(post)
            request.httpMethod = HttpMethod.post.rawValue
            request.httpBody = data
            
        } catch let error {
            print("There was an error encoding the object\(error)\(error.localizedDescription)")
        }
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            // urlSes. postReas Error
            if let error = error {
                print("there was an with dataTask\(error) \(error.localizedDescription)")
                completion(false); return
            }
            
            guard let data = data else {completion(false); return}
            if let objectString = String(data: data, encoding: .utf8){
                print(objectString)
            }else {
                print("bad data")
                completion(false); return
            }
            self.posts.append(post)
            completion(true)
            
            }.resume()
    }
    
    /*
     --------------------------------
     fetchPost Func below
     --------------------------------
     */
    
    func fetchPost(completion: @escaping(Bool) -> Void) {
        guard let url = baseURL else {
            fatalError("bad url")
        }
        let builtURL = url.appendingPathExtension("json")
        //fetch.URLses * request
        var request = URLRequest(url: builtURL)
        request.httpMethod = "GET"
        request.httpBody = nil
        
        
        URLSession.shared.dataTask(with: request) { (data, _, error) in
            
            //fetch.URLSes * data
            
            guard let data = data else {completion (false); return}
            // need to decode the object
            do {
                let postDictionary = try JSONDecoder().decode([String:Post].self, from: data)
                let posts = postDictionary.compactMap({$0.value})
                self.posts = posts
                completion(true)
                
            }catch let error {
                print("there was an error decoding the data \(error) \(error.localizedDescription)")
            }
            //fetch.URLSes * error
            if let error = error {
                print("Error with data task \(error) \(error.localizedDescription)")
                completion(false); return
            }
            
            }.resume()
    }
    
}
