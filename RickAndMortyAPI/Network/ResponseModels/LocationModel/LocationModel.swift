//
//  LocationModel.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import Foundation

struct LocationModel<T:Codable>: Codable {
    let info: T?
    let results: [LocationResult]?
}
