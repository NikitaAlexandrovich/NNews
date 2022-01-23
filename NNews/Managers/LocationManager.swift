//
//  LocationManager.swift
//  NNews
//
//  Created by Никита Ходарёнок on 16.01.22.
//

import Foundation

struct UserLocation{
    let userLocale = Locale.current
    func getCodeCountry() -> String{
        return userLocale.regionCode ?? "NaN"
    }
}
