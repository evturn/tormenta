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
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    let baseURL = NSURL(string: "https://api.forecast.io/forecast/\(forecastAPIKey)/")
    let forecastURL = NSURL(string: "37.8267,-122.423", relativeToURL: baseURL)
    
    let configuration = NSURLSessionConfiguration.defaultSessionConfiguration()
    let session = NSURLSession(configuration: configuration)
    
    let request = NSURLRequest(URL: forecastURL!)
    
    let dataTask = session.dataTaskWithRequest(request, completionHandler: {
      (data, response, error) -> Void in
      print(data)
      print("BACKGROUND THREAD SON!")
    })
    
    print("MAIN THREAD SON!")
    dataTask.resume()
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

