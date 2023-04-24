//
//  ErrorType.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import Foundation

enum ErrorType: Error {

    case decodingError
    case dataError
    case urlError
    case responseError

    var localizedDescription: String {

        switch self {
        case .decodingError:
            return "Decode error"
        case .dataError:
            return "Data error"
        case .urlError:
            return "URL error"
        case .responseError:
            return "Response error"
        }
    }
}
