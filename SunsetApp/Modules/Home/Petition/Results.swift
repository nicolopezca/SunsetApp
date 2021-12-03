//
//  Petition.swift
//  SunsetApp
//
//  Created by Nicolás López Cano on 1/12/21.
//

import Foundation

struct Results: Decodable {
//    var astronomical_twilight_begin: String?
//    var astronomical_twilight_end: String?
    var civil_twilight_begin: String?
    var civil_twilight_end: String?
//    var day_length: String?
    var nautical_twilight_begin: String?
    var nautical_twilight_end: String?
//    var solar_noon: String?
    var sunrise: String?
    var sunset: String?
}
