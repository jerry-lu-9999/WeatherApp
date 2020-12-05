//
//  TVC.swift
//  
//
//  Created by Jiahao Lu on 12/2/20.
//  Copyright © 2020 Jiahao Lu. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

//extension CLPlacemark{
//    var city: String? { locality }
//    var state: String? { administrativeArea }
//    var county: String? {subAdministrativeArea }
//}
//
//extension CLLocation{
//    func placemark(completion: @escaping (_ placemark: CLPlacemark?, _ error: Error?) -> ()){
//        CLGeocoder().reverseGeocodeLocation(self){
//            completion($0?.first, $1)
//        }
//    }
//}

class TVC: UITableViewController, CLLocationManagerDelegate{

    var weathersModel : model!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = Bundle.main.displayName
        self.tableView.rowHeight = 140
        loadRequest()
        
        //display refresh
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Getting you the most updated data")
        refreshControl.addTarget(self, action: #selector(getWeather(_:)), for: .valueChanged)
        self.refreshControl = refreshControl
        
        //Getting the name of the city from latitude and longitdue
//        let location = CLLocation(latitude: currentLoc.coordinate.latitude, longitude: currentLoc.coordinate.longitude)
//        location.placemark{ placemark, error in
//            guard let placemark = placemark else{
//                print("ERROR:", error ?? "nil")
//                return
//            }
//            print(placemark.city!)
//        }
    }
    
    @objc func getWeather(_ sender:Any){
        loadRequest()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    func loadRequest(){
            let weathers = readJSON(fileName: "darksky_sample", type: Weathers.self)
        weathersModel = model(items: weathers!.daily.data, latitude: weathers!.latitude, longtitude: weathers!.longitude, timezone: weathers!.timezone)
            print(weathersModel.items)
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

//                }
//            }
//            task.resume()
    }
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return self.weathersModel.items.count
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "TableViewCell", for: indexPath) as? TableViewCell else{
            fatalError("Expect tableviewcell")
        }
        
        let currentDate = dayFromSeconds(seconds: self.weathersModel.items[indexPath.row].time, timeZone: self.weathersModel.timezone)
        cell.dateLabel?.text = currentDate
        
        var temp = self.weathersModel.items[indexPath.row].temperatureHigh
        if UserDefaults.standard.bool(forKey: "dCelcius") == true{
            temp = (temp - 32.0) * 5 / 9
            let tempString = String(format: "%.0f", temp) + "ºC"
            cell.tempLabel?.text = tempString
        } else{
            let tempString = String(format: "%.0f", temp) + "ºF"
            cell.tempLabel?.text = tempString
        }
        
        cell.tempLabel.adjustsFontSizeToFitWidth = true
        
        cell.cityNameLabel?.text = "Rochester"

        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
    }
    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
