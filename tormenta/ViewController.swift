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
  

  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    if let plistPath = NSBundle.mainBundle().pathForResource("CurrentWeather", ofType: "plist"),
    let weatherDictionary = NSDictionary(contentsOfFile: plistPath),
    let currentWeatherDictionary = weatherDictionary["currently"] as? [String: AnyObject] {
      let currentWeather = CurrentWeather(weatherDictionary: currentWeatherDictionary)]
      
      currentTemperatureLabel?.text = "\(currentWeather.temperature)º"
    }
    
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }


}

