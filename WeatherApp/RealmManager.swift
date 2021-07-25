//
//  RealmManager.swift
//  WeatherApp
//
//  Created by Sandeep Kumar on 24/07/21.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    public var realm: Realm!
    
    private init() {
        realm = try! Realm()
    }
    
    func saveWeather(for obj: WeatherData) {
        realm.beginWrite()
        realm.add(obj)
        do {
            try realm.commitWrite()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }
    
    func getWeather(for city: String) -> WeatherData? {
        guard let weathers = try? realm.objects(WeatherData.self) else {
            return nil
        }
        let obj = weathers.first(where: {/$0.name.lowercased() == city.lowercased()})
        return obj
    }
    
    func saveCities(cities: [City]) {
        realm.beginWrite()
        realm.add(cities)
        do {
            try realm.commitWrite()
        } catch {
            debugPrint(error.localizedDescription)
        }
    }

    func getCities() -> [City] {
        guard let cities = try? realm.objects(City.self) else {
            return []
        }
        return Array(cities)
    }
}
