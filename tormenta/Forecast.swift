//
//  Forecast.swift
//  tormenta
//
//  Created by Evan Turner on 2/26/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import Foundation


struct Forecast {
  var currentWeather: CurrentWeather?
  var weekly: [DailyWeather] = []
  
  init(weatherDictionary: [String: AnyObject]?) {
    if let currentWeatherDictionary = weatherDictionary?["currently"] as? [String: AnyObject] {
      currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)
    }
  }
}