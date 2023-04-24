//
//  LocationViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import Foundation

import Foundation

class LocationViewModel: ObservableObject {
    let service = Service.shared
    
    @Published var locationResponse = [LocationResult]()
    
    func initialize(filterLocation: String) {
        fetchContent(filterLocation: filterLocation)
    }
    
    func fetchContent(filterLocation: String) {
        service.fetchLocationRequest(filterLocation:filterLocation ,endpointType: endpointType.location) { [weak self] (response: Result<LocationModel<InfoModel>, ErrorType>) in
            switch response {
            case .success(let model):
                guard let results = model.results else { return }
                self?.locationResponse = results
            case .failure(let error):
                print(error.localizedDescription)
            }
            
        }
    }
    func getIdsString(forIndex index: Int) -> String {
        let locationResidents = locationResponse[index].residents
        let ids = locationResidents!.compactMap { resident -> String? in
            if let url = URL(string: resident) {
                return url.lastPathComponent
            }
            return nil
        }
        return ids.joined(separator: ",")
    }
    
}

