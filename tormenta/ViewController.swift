//
//  ViewController.swift
//  tormenta
//
//  Created by Evan Turner on 2/21/16.
//  Copyright © 2016 Evan Turner. All rights reserved.
//

import UIKit


class ViewController: UIViewController {
  
  var dailyWeather: DailyWeather? {
    didSet {
      configureView()
    }
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  func configureView() {
    if let weather = dailyWeather {
      self.title = weather.day
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

