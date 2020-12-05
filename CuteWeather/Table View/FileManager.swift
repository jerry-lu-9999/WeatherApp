//
//  FileManager.swift
//  CuteWeather
//
//  Created by Jiahao Lu on 12/3/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import Foundation

let kWeatherFile = "WeatherFile"

extension FileManager{
    
//    func getWeathers() -> Weathers {
//                
//       if let url = urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(kWeatherFile, isDirectory: false) {
//            
//            if let jsondata = contents(atPath: url.path) {
//                let decoder = JSONDecoder()
//                do {
//                    let model = try decoder.decode(Weathers.self, from: jsondata)
//                    return model
//                } catch { fatalError(error.localizedDescription) }
//            }
//        }
//        
//        //return Weathers()
//    }
    
    func saveWeatherFromApi(){
        if let url = urls(for: .documentDirectory, in: .userDomainMask).first?.appendingPathComponent(kWeatherFile, isDirectory: false) {
            
            if fileExists(atPath: url.path) {
                do {
                    try removeItem(at: url)
                } catch { fatalError(error.localizedDescription) }
            }
            
            
            let weathers = readJSON(fileName: "darksky_sample", type: Weathers.self)
//            weatherModel.latitude = weathers!.latitude
//            weatherModel.longitude = weathers!.longitude
//            weatherModel.items = weathers!.daily.data
            let weatherModel = model(items: weathers!.daily.data, latitude: weathers!.latitude, longtitude: weathers!.longitude, timezone: weathers!.timezone)
            print(weatherModel.items)
//            let lat = 43.2360
//            let long = -77.6933
//            let weburl = URL(string: "https://api.darksky.net/forecast/\(Constants.apiKey)/\(lat),\(long)/")!
//            let request = URLRequest(url: weburl)
//            let session = URLSession(configuration: .default, delegate: nil, delegateQueue: OperationQueue.main)
//            let task = session.dataTask(with: request){(data, response, error) in
//
//                if let error = error {
//                    print(error.localizedDescription)
//                } else if let data = data {
                      
                      //let masterDictionary = try! JSONSerialization.jsonObject(with: data, options: []) as! [String:Any]
//
//                    let dict = dataDictionary["rates"] as! [String:Double]
//                    let keys = dict.keys
//                    var arrOfKeys = [String]()
//                    arrOfKeys.append(contentsOf: keys)
//
//                    let dateString = dataDictionary["date"] as! String
//
//                    var arrOfItems = [RateItem]()
//                    for str in arrOfKeys {
//                        arrOfItems.append(RateItem(date: dateString, country: str, rates: dict[str] ?? 1))
//                    }
//                    rates.arrOfItems = arrOfItems
//                }
//            }
//            task.resume()
            
            if let encodedData = try? JSONEncoder().encode(weatherModel) {
                createFile(atPath: url.path, contents: encodedData, attributes: nil)
            } else {
                fatalError("Couldn't write data!")
            }
        }
    }
}
