//
//  EndpointType.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import Foundation

enum endpointType {
    case character
    case episode
    case location

    var apiTypeString: String {
        switch self {
        case .character:
            return "character"
        case .episode:
            return "episode"
        case .location:
            return "location"
        }
    }
}
