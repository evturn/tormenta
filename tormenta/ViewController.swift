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
  
  @IBOutlet weak var weatherIcon: UIImageView?
  @IBOutlet weak var summaryLabel: UILabel?
  @IBOutlet weak var sunriseTimeLabel: UILabel?
  @IBOutlet weak var sunsetTimeLabel: UILabel?
  
  override func viewDidLoad() {
    super.viewDidLoad()

  }
  
  func configureView() {
    if let weather = dailyWeather {
      self.title = weather.day
    }
    
    if let buttonFont = UIFont(name: "HelveticaNeue-Thin", size: 20.0) {
      let barButtonAttributesDictionary: [String: AnyObject]? = [
        NSForegroundColorAttributeName: UIColor.whiteColor(),
        NSFontAttributeName: buttonFont
      ]
      
      UIBarButtonItem.appearance().setTitleTextAttributes(barButtonAttributesDictionary, forState: .Normal)
    }
  }

  override func didReceiveMemoryWarning() {
    super.didReceiveMemoryWarning()
    // Dispose of any resources that can be recreated.
  }
}

