//
//  NetworkHandler.swift
//  CovidWorldData
//
//  Created by Rafał Swat on 19/04/2021.
//

import Foundation
import UIKit

class NetworkHandler {
    
    let stringHandler = StringHandler()
    
    let urlString = "https://www.worldometers.info/coronavirus/country/"

    func fetchCovData(from country: String, completion: @escaping (ResultsModel?, Bool, String?)->()) {
        
        var convertCountry = country.replacingOccurrences(of: " ", with: "-")
        convertCountry = stringHandler.replaceIfNeeded(country: convertCountry)
        let pathUrl = urlString + convertCountry + "/"
        
        if verifyUrl(urlString: pathUrl) {
            if let url = URL(string: pathUrl) {
                
                let request = NSURLRequest(url: url)
                let task    = URLSession.shared.dataTask(with: request as URLRequest) { data, response, error in
                    if error != nil {
                        completion(nil, true, error?.localizedDescription)
                    } else {
                        if let unrapedData = data {
                            if let dataString = NSString(data: unrapedData, encoding: String.Encoding.utf8.rawValue) {
                                self.getBaseInfo(dataString: dataString, completion: { result, errorOccur, errorDescription in
                                    completion(result, errorOccur, errorDescription)
                                })
                                
                            } else {
                                completion(nil, true, "Can not encode data from URL session")
                            }
                        } else {
                            completion(nil, true, "Can not find data for given request")
                        }
                    }
                }
                task.resume()
            } else {
                completion(nil, true, "Can not construct URL from: \(pathUrl)")
            }
        } else {
            completion(nil, true, "Can not open find data for this country!")
            print("Can not open URl -> Link is incorrect")
        }
    }
    
    func verifyUrl(urlString: String?) -> Bool {
        guard let urlString = urlString,
              let url = URL(string: urlString) else {
            return false
        }
        return UIApplication.shared.canOpenURL(url)
    }

    func getBaseInfo(dataString: NSString, completion: @escaping (ResultsModel?, Bool, String?)->()) {
        let lastUpdate       = stringHandler.extractFirstFromText(from: dataString,
                                                                  startedBy: Separators.updateStart,
                                                                  endedBy: Separators.updateEnd)
        
        let titleResult      = stringHandler.extractFirstFromText(from: dataString,
                                                                  startedBy: Separators.titleStart,
                                                                  endedBy: Separators.titleEnd)
        
        let recovered        = stringHandler.extractFirstFromText(from: dataString,
                                                                  startedBy: Separators.recoveredStart,
                                                                  endedBy: Separators.recoveredEnd)
        
        let curretlyInfected = stringHandler.extractFirstFromText(from: dataString,
                                                                  startedBy: Separators.currentlyStart,
                                                                  endedBy: Separators.currentlyEnd)
        
        let inMidCondition   = stringHandler.extractFirstFromText(from: dataString,
                                                                  startedBy: Separators.midConditionStart,
                                                                  endedBy: Separators.midConditionEnd)

        let criticalSeriuos  = stringHandler.extractFirstFromText(from: dataString,
                                                                  startedBy: Separators.criticalStart,
                                                                  endedBy: Separators.criticalEnd)
        var newCases         = stringHandler.extractFirstFromText(from: dataString,
                                                                  startedBy: Separators.newStart,
                                                                  endedBy: Separators.newEnd)
        
        if newCases.components(separatedBy: " ").count > 1 { newCases = "unknown" }
        
        if titleResult != "404 Not Found" {
            let titleArray  = titleResult.components(separatedBy: " ")
            
            let casesIndex  = titleArray.firstIndex(of: "Cases")
            let deathsIndex = titleArray.firstIndex(of: "Deaths")
            
            let country     = titleResult.components(separatedBy: Separators.countryEnd)[0]
            let cases       = titleArray[(casesIndex ?? 4)-1]
            let deaths      = titleArray[(deathsIndex ?? 7)-1]
            
            let result = ResultsModel(country      : country,
                                  lastUpdated      : lastUpdate,
                                  cases            : cases,
                                  death            : deaths,
                                  recovered        : recovered,
                                  infected         : curretlyInfected,
                                  midCondition     : inMidCondition,
                                  seriousOrCritical: criticalSeriuos,
                                  newCases         : newCases)
            
            completion(result, false, nil)
        } else {
            completion(nil , true, "Can not find data related to this country. Please check if you have entered the correct name of the country.")
        }
    }
}

extension NetworkHandler {
    enum Separators {
        static let countryEnd        = "COVID:"
        static let updateStart       = "<div style=\"font-size:13px; color:#999; text-align:center\">"
        static let updateEnd         = "</div>"
        
        static let titleStart        = "<title>"
        static let titleEnd          = "</title>"
        
        static let recoveredStart    = "<span class=\"number-table\" style=\"color:#8ACA2B\">"
        static let recoveredEnd      = "</span>"
        
        static let currentlyStart    = "<div class=\"number-table-main\">"
        static let currentlyEnd      = "</div>"
        
        static let midConditionStart = "<span class=\"number-table\" style=\"color:#8080FF\">"
        static let midConditionEnd   = "</span>"
        
        static let criticalStart     = "<span class=\"number-table\" style=\"color:red \">"
        static let criticalEnd       = "</span>"
        
        static let newStart          = "<span id=\"updates\" class=\"news_category_title\">Updates</span><div class=\"news_post\">\n<div class=\"news_body\">\n<ul class=\"news_ul\"><li class=\"news_li\"><strong>"
        static let newEnd            = "new cases</strong>"
    }
}

