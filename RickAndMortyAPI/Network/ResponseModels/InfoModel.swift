//
//  InfoModel.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import Foundation

struct InfoModel: Codable {
    let count: Int?
    let pages: Int?
    let next: String?
    let prev: String?
}
