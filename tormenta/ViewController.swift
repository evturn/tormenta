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
  @IBOutlet weak var currentWeatherIcon: UIImageView?
  @IBOutlet weak var currentWeatherSummary: UILabel?
  
  private let forecastAPIKey = "1f46e094ffe74026e1406789fbe04788"

  let coordinate: (lat: Double, long: Double) = (40.758896,-73.985130)
  
  override func viewDidLoad() {
    super.viewDidLoad()
    retrieveWeatherForecast()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }

  func retrieveWeatherForecast() {
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
          
          if let icon = currentWeather.icon {
            self.currentWeatherIcon?.image = icon
          }
          
          if let summary = currentWeather.summary {
            self.currentWeatherSummary?.text = summary
          }
        }
      }
    }
  }
  
  @IBAction func refreshWeather() {
    retrieveWeatherForecast()
  }
  
}

