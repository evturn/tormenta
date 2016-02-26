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
  
  @IBAction func refreshWeather() {
    locationManager.requestLocation()
    refreshControl?.endRefreshing()
  }
  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
  }
  
  func configureView() {
    tableView.backgroundView = BackgroundView()
    tableView.rowHeight = 64

    if let navBarFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
      let navBarAttributesDictionary: [String: AnyObject]? = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: navBarFont
      ]
      navigationController?.navigationBar.titleTextAttributes = navBarAttributesDictionary
    }
    
    refreshControl?.layer.zPosition = tableView.backgroundView!.layer.zPosition + 1
    refreshControl?.tintColor = UIColor.whiteColor()
    
  }
  
  // MARK: - Table view data source
  
  override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
  }
  
  override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
    return "Forecast"
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    // #warning Incomplete implementation, return the number of rows
    return weeklyWeather.count
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let cell = tableView.dequeueReusableCellWithIdentifier("WeatherCell") as! DailyWeatherTableViewCell
    let dailyWeather = weeklyWeather[indexPath.row]
    if let maxTemp = dailyWeather.maxTemperature {
      cell.temperatureLabel.text = "\(maxTemp)º"
    }
    
    cell.weatherIcon.image = dailyWeather.icon
    cell.dayLabel.text = dailyWeather.day

    return cell
  }
  
  // MARK: - Delegate Methods
  
  override func tableView(tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
    view.tintColor = UIColor(red: 170/255.0, green: 131/255.0, blue: 244/255.0, alpha: 1.0)
    
    if let header = view as? UITableViewHeaderFooterView {
      header.textLabel!.font = UIFont(name: "HelveticaNeue-Thin", size: 14.0)
      header.textLabel!.textColor = UIColor.whiteColor()
    }
  }
  
  override func tableView(tableView: UITableView, didHighlightRowAtIndexPath indexPath: NSIndexPath) {
    let cell = tableView.cellForRowAtIndexPath(indexPath)
    cell?.contentView.backgroundColor = UIColor(red: 165/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
    let highlightView = UIView()
    highlightView.backgroundColor = UIColor(red: 165/255.0, green: 142/255.0, blue: 203/255.0, alpha: 1.0)
    cell?.selectedBackgroundView = highlightView
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
          
          self.tableView.reloadData()
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
