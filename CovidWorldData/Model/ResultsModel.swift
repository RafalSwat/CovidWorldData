//
//  ResultsModel.swift
//  CovidWorldData
//
//  Created by Rafał Swat on 19/04/2021.
//

import Foundation

class ResultsModel {
    var country                : String
    var lastUpdated            : String
    var casesCount             : String
    var deathCount             : String
    var recoveredCount         : String
    
    var infectedCount          : String
    var midConditionCount      : String
    var seriousOrCriticalCount : String
    
    var newCasesCount: String
    
    init(country: String,
         lastUpdated: String,
         cases: String,
         death: String,
         recovered: String,
         infected: String,
         midCondition: String,
         seriousOrCritical: String,
         newCases: String) {
        
        self.country                = country
        self.lastUpdated            = lastUpdated
        self.casesCount             = cases
        self.deathCount             = death
        self.recoveredCount         = recovered
        self.infectedCount          = infected
        self.midConditionCount      = midCondition
        self.seriousOrCriticalCount = seriousOrCritical
        self.newCasesCount          = newCases
    }
         
         
    
}
