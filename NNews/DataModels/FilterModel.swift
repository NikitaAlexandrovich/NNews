//
//  FilterModel.swift
//  NNews
//
//  Created by Никита Ходарёнок on 21.01.22.
//

import Foundation

enum Country: String, CaseIterable{
    case My_Location
    case US_USA
    case RU_Russia
    case UA_Ukraine
    case DE_Germany
    case IT_Italy
    case JP_Japan
    case CN_China
    case IN_India
    case GR_Greece
    case AU_Australia
    case AT_Austria
    case CA_Canada
    case PL_Poland
    case AE_UAE
    case FR_France
    
    var getCoutry: String {
        if self == .My_Location {
            let local = UserLocation()
            return local.getCodeCountry()
        }
        return rawValue.prefix(2).capitalized
    }
    
    var getLocation: String {
        if self == .My_Location {
            let local = UserLocation()
            return "My location \(local.getCodeCountry())"
//            return "My location"
        }
        return String(rawValue.dropFirst(3))
    }
}

extension Country: Identifiable {
    var id: Self { self }
}

enum Category: String, CaseIterable{
    case general
    case health
    case technology
    case science
    case sports
    case entertainment
    case business
    
    var topHeadlinesGet: String {
        if self == .general {
            return "Top Headlines"
        }
        return rawValue.capitalized
    }
}

extension Category: Identifiable {
    var id: Self { self }
}
