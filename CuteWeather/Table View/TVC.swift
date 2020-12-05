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
import SpriteKit
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
        
        NotificationCenter.default.addObserver(self, selector: #selector(receivedMetricChanged), name: Notification.Name("system changed"), object: nil)
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
    
    @objc func receivedMetricChanged(){
        weathersModel.celcius = true
        self.tableView.reloadData()
    }
    
    @objc func getWeather(_ sender:Any){
        loadRequest()
        self.tableView.reloadData()
        self.refreshControl?.endRefreshing()
    }

    func loadRequest(){
            NotificationCenter.default.addObserver(self, selector: #selector(receivedMetricChanged), name: Notification.Name("system changed"), object: nil)
            let weathers = readJSON(fileName: "darksky_sample", type: Weathers.self)
        weathersModel = model(items: weathers!.daily.data, latitude: weathers!.latitude, longtitude: weathers!.longitude, timezone: weathers!.timezone)
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
        if self.weathersModel.celcius == true{
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
    
    //MARK: -Navigation to another view controller
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "showdetail", sender: self)
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let destination = segue.destination as? detailVC{
            destination.details = self.weathersModel.items[(tableView.indexPathForSelectedRow?.row)!]
        }
        
    }

    //MARK: - DELETION
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            let dailyWeather = self.weathersModel.items[indexPath.row]
            deleteAlert(){ _ in
                self.deleteWeather(weather: dailyWeather)
                self.tableView.deleteRows(at: [indexPath], with: .top)
                //self.tableView.reloadData()
            }
        }
    }
    
    func deleteAlert(completion: @escaping (UIAlertAction) -> Void){
        let alertMsg = NSLocalizedString("str_alertmsg", comment: "")
        let alert = UIAlertController(title: NSLocalizedString("str_warning", comment: "") , message: alertMsg, preferredStyle: .actionSheet)
        
        let deleteAction = UIAlertAction(title: NSLocalizedString("str_delete", comment: ""), style: .destructive, handler: completion)
        let cancelAction = UIAlertAction(title: NSLocalizedString("str_cancel", comment: ""), style: .cancel, handler: nil)
        
        alert.addAction(deleteAction)
        alert.addAction(cancelAction)
        
        alert.popoverPresentationController?.permittedArrowDirections = []
        alert.popoverPresentationController?.sourceView = self.view
        alert.popoverPresentationController?.sourceRect = CGRect(x: self.view.frame.midX, y: self.view.frame.midY, width: 0, height: 0)
        
        present(alert, animated: true, completion: nil)
    }
    
    func deleteWeather(weather: DailyWeather){
        if let index = weathersModel.items.firstIndex(where:{$0.time == weather.time}){
            weathersModel.items.remove(at: index)
        }
    }

}
