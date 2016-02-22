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
  
  init(url: NSURL) {
    self.queryURL = url
  }
  
}
