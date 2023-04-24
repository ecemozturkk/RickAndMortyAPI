//
//  FormatDateExtension.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import Foundation

extension String {
    func formatDate() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ss.SSSZ"
        guard let date = dateFormatter.date(from: self) else { return self }
        dateFormatter.dateFormat = "d MMMM yyyy, HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        return dateFormatter.string(from: date)
    }
}
