//
//  StringHandler.swift
//  CovidWorldData
//
//  Created by Rafał Swat on 19/04/2021.
//

import Foundation

class StringHandler {
    
    func extractFirstFromText(from data: NSString, startedBy: String, endedBy: String) -> String {
        
        let splitedString = data.components(separatedBy: startedBy)
        
        if splitedString.count > 1 {
            
            let secondPartOfSplitedString = splitedString[1].components(separatedBy: endedBy)
            
            if secondPartOfSplitedString.count > 0 {
                
                let resultString         = secondPartOfSplitedString[0]
                let noSpacesResultString = resultString.trimmingCharacters(in: .whitespaces)
                return noSpacesResultString
            }
            return "Can not find \"endedBy\" String in the data"
        }
        return "Can not find \"startedBy\" String in the data"
    }
}
