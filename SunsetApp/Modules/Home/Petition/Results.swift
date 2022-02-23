//
//  Petition.swift
//  SunsetApp
//
//  Created by Nicolás López Cano on 1/12/21.
//

import Foundation

struct Results: Decodable {
    enum CodingKeys: String, CodingKey {
        case civilTwilightBegin = "civil_twilight_begin"
        case civilTwilightEnd = "civil_twilight_end"
        case nauticalTwilightBegin = "nautical_twilight_begin"
        case nauticalTwilightEnd = "nautical_twilight_end"
        case sunrise, sunset
    }
    let civilTwilightBegin: String?
    let civilTwilightEnd: String?
    let nauticalTwilightBegin: String?
    let nauticalTwilightEnd: String?
    let sunrise: String?
    let sunset: String?
}
