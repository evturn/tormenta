//
//  ViewController.swift
//  tormenta
//
//  Created by Evan Turner on 2/21/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
  
  @IBOutlet weak var currentTemperatureLabel: UILabel?
  @IBOutlet weak var currentHumidityLabel: UILabel?
  @IBOutlet weak var currentPrecipitationLabel: UILabel?
  
  private let forecastAPIKey = "1f46e094ffe74026e1406789fbe04788"
  
  let coordinate: (lat: Double, long: Double) = (37.8267,-122.423)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    let forecastService = ForecastService(APIKey: forecastAPIKey)
    
    forecastService.getForecast(coordinate.lat, long: coordinate.long) {
      (let currently) in
      if let currentWeather = currently {
        dispatch_async(dispatch_get_main_queue()) {
          if let temperature = currentWeather.temperature {
            self.currentTemperatureLabel?.text = "\(temperature)º"
          }
          
          if let humidity = currentWeather.humidity {
            self.currentHumidityLabel?.text = "\(humidity)%"
          }
          
          if let precipitation = currentWeather.precipProbability {
            self.currentPrecipitationLabel?.text = "\(precipitation)%"
          }
        }
      }
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

