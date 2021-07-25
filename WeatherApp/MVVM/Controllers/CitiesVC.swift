//
//  ViewController.swift
//  WeatherApp
//
//  Created by Sandeep Kumar on 23/07/21.
//

import UIKit

class CitiesVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        City.getCities { [weak self] cities in
            
        }
        
//        TestEP.getWeather(city: "Chandigarh").request { responseData in
//
//        } error: { error in
//
//        }

    }
    
}

