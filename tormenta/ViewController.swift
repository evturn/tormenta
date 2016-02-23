//
//  ViewController.swift
//  tormenta
//
//  Created by Evan Turner on 2/21/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
  
  @IBOutlet weak var currentTemperatureLabel: UILabel?
  @IBOutlet weak var currentHumidityLabel: UILabel?
  @IBOutlet weak var currentPrecipitationLabel: UILabel?
  @IBOutlet weak var currentWeatherIcon: UIImageView?
  @IBOutlet weak var currentWeatherSummary: UILabel?
  @IBOutlet weak var refreshButton: UIButton?
  @IBOutlet weak var activityIndicator: UIActivityIndicatorView?
  var latitude: Double?
  var longitude: Double?

  private let locationManager = CLLocationManager()
  private let forecastAPIKey = "1f46e094ffe74026e1406789fbe04788"
  
  override func viewDidLoad() {
    super.viewDidLoad()

    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestLocation()
  }

  // MARK: CLLocationManagerDelegate
  func locationManager(manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
    let location = locations.last

    print(location)
    latitude = location!.coordinate.latitude
    longitude = location!.coordinate.longitude
    retrieveWeatherForecast()
  }
  
  func locationManager(manager: CLLocationManager, didFailWithError error: NSError) {
    print(error)
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
  
  func retrieveWeatherForecast() {
    let forecastService = ForecastService(APIKey: forecastAPIKey)
    
    forecastService.getForecast(latitude!, long: longitude!) {
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
          
          self.toggleRefreshAnimation(false)
        }
      }
    }
  }
  
  @IBAction func refreshWeather() {
    toggleRefreshAnimation(true)
    locationManager.requestLocation()
  }
  
  func toggleRefreshAnimation(on: Bool) {
    refreshButton?.hidden = on
    
    if on {
      activityIndicator?.startAnimating()
    } else {
      activityIndicator?.stopAnimating()
    }
  }
}

