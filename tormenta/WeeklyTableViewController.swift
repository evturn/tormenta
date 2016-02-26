//
//  WeeklyTableViewController.swift
//  tormenta
//
//  Created by Evan Turner on 2/25/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import UIKit
import CoreLocation

class WeeklyTableViewController: UITableViewController, CLLocationManagerDelegate {
  
  @IBOutlet weak var currentWeatherIcon: UIImageView?
  @IBOutlet weak var currentTemperatureLabel: UILabel?
  @IBOutlet weak var currentPrecipitationLabel: UILabel?
  @IBOutlet weak var currentTemperatureRangeLabel: UILabel?
  
  var latitude: Double?
  var longitude: Double?
  
  private let locationManager = CLLocationManager()
  private let forecastAPIKey = "1f46e094ffe74026e1406789fbe04788"
  
  var weeklyWeather: [DailyWeather] = []
  
  
  override func viewDidLoad() {
    super.viewDidLoad()
    configureView()
    locationManager.delegate = self
    locationManager.requestWhenInUseAuthorization()
    locationManager.desiredAccuracy = kCLLocationAccuracyHundredMeters
    locationManager.requestLocation()
  }
  
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func configureView() {
    tableView.backgroundView = BackgroundView()

    if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
      let navBarAttributesDictionary: [String: AnyObject]? = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: navBarFont
      ]
      navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
    }
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    // #warning Incomplete implementation, return the number of sections
    return 0
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return 0
  }
  
  // MARK: - Weather Fetching
  
  func retrieveWeatherForecast() {
    let forecastService = ForecastService(APIKey: forecastAPIKey)
    
    forecastService.getForecast(latitude!, long: longitude!) {
      (let forecast) in
      if let weatherForecast = forecast,
      let currentWeather = weatherForecast.currentWeather {
        dispatch_async(dispatch_get_main_queue()) {
          if let temperature = currentWeather.temperature {
            self.currentTemperatureLabel?.text = "\(temperature)º"
          }
          
          if let precipitation = currentWeather.precipProbability {
            self.currentPrecipitationLabel?.text = "Rain: \(precipitation)%"
          }
          
          if let icon = currentWeather.icon {
            self.currentWeatherIcon?.image = icon
          }
          
          self.weeklyWeather = weatherForecast.weekly
          
          
          if let highTemp = self.weeklyWeather.first?.maxTemperature,
            let lowTemp = self.weeklyWeather.first?.minTemperature {
              self.currentTemperatureRangeLabel?.text = "↑\(highTemp)º↓\(lowTemp)º"
          }
//          if let summary = currentWeather.summary {
//            self.currentWeatherSummary?.text = summary
//          }
        }
      }
    }
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

}
