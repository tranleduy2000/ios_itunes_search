//
//  APIController.swift
//  TableView
//
//  Created by Duy on 2/19/18.
//  Copyright © 2018 Duy. All rights reserved.
//

import Foundation

class APIController{
    open static let KEY_THUMBNAIL: String = "thumbnailURLString"
    open static let KEY_APP_NAME: String = "appName"
    open static let KEY_PRICE: String = "price"
    
    var delagate: APIControllerProtocol?
    
    func searchItunesFor(searchTerm: String){
        
        let itunesSearchTerm = searchTerm.replacingOccurrences(of: " ", with: "+", options: .caseInsensitive, range: nil)
        let escapedSearchTerm = itunesSearchTerm.addingPercentEncoding(withAllowedCharacters: [])!
        let urlPath = "http://itunes.apple.com/search?term=\(escapedSearchTerm)&media=software"
        let url = URL(string: urlPath)!
        let session = URLSession.shared
        
        let task = session.dataTask(with: url, completionHandler: {(data, response, error) in
            print("Task complete")
            if (error != nil){
                print(error!.localizedDescription)
            }
            
            do{
                let jsonResult = try JSONSerialization.jsonObject(with: data!, options: .mutableContainers) as! Dictionary<String, Any>
                self.processResult(searchResult: jsonResult);
            } catch let err{
                print(err)
            }
        })
        task.resume()
        
    }
    
    private func processResult(searchResult: Dictionary<String, Any>){
        
        guard let results = searchResult["results"] as? Array<Dictionary<String, Any>> else {
            print("count not process result")
            return
        }
        
        var apps = Array<Dictionary<String, String>>()
        for result in results {
            if let thumbnail = result["artworkUrl100"] as? String,
                let appName = result["trackName"] as? String,
                let price = result["formattedPrice"] as? String{
                apps.append(
                    [
                        APIController.KEY_THUMBNAIL: thumbnail,
                        APIController.KEY_APP_NAME: appName,
                        APIController.KEY_PRICE: price
                    ])
            }
        }
        
        delagate?.didReceiveApiResults(results: apps)
    }
    
}
