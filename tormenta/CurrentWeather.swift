//
//  CurrentWeather.swift
//  tormenta
//
//  Created by Evan Turner on 2/21/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import Foundation

struct CurrentWeather {
  
  let temperature: Int
  let humidity: Int
  let precipProbability: Int
  let summary: String
  
  init(weatherDictionary: [String: AnyObject]) {
    temperature = weatherDictionary["temperature"] as! Int
    humidity = weatherDictionary["humidity"] as! Int
    precipProbability = weatherDictionary["precipChance"] as! Int
    summary = weatherDictionary["summary"] as! String
  }
}