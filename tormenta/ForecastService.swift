//
//  ForecastService.swift
//  tormenta
//
//  Created by Evan Turner on 2/22/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import Foundation


struct ForecastService {
  
  let forecastAPIKey: String
  let forecastBaseURL: NSURL?
  
  init(APIKey: String) {
    forecastAPIKey = APIKey
    forecastBaseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
  }
  
  func getForecast(lat: Double, long: Double, completion: (CurrentWeather? -> Void)) {
    if let forecastURL = NSURL(string: "\(lat),\(long)", relativeToURL: forecastBaseURL) {
      let networkOperation = NetworkOperation(url: forecastURL)
      
      networkOperation.downloadJSONFromURL {
        (let JSONDictionary) in
        let currentWeather = self.currentWeatherFromJSON(JSONDictionary)
        completion(currentWeather)
      }
    } else {
      print("Couldn't construct a valid URL")
    }
  }
}