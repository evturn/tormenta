//
//  NetworkOperation.swift
//  tormenta
//
//  Created by Evan Turner on 2/22/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import Foundation

class NetworkOperation {
  
  lazy var config: NSURLSessionConfiguration = NSURLSessionConfiguration.defaultSessionConfiguration()
  lazy var session: NSURLSession = NSURLSession(configuration: self.config)
  let queryURL: NSURL
  
  typealias JSONDictionaryCompletion = ([String: AnyObject]?) -> ()
  
  init(url: NSURL) {
    self.queryURL = url
  }
  
  func downloadJSONFromURL(completion: JSONDictionaryCompletion) {
    let request: NSURLRequest = NSURLRequest(URL: queryURL)
    let dataTask = session.dataTaskWithRequest(request) {
      (let data, let response, let error) in
      
      if let httpResponse = response as? NSHTTPURLResponse {
        
        switch(httpResponse.statusCode) {
          case 200:
            do {
              let jsonDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions()) as! [String: AnyObject]
              completion(jsonDictionary)
            } catch {
              print(error)
          }
          default:
            print("GET request not successful. HTTP status code \(httpResponse.statusCode)")
        }
      } else {
        print("Error: Not a valid HTTP Repsonse")
      }
    }
    
    dataTask.resume()
  }
  
}
