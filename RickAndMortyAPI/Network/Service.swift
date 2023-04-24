//
//  Service.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import Foundation

class Service: ObservableObject {
    static let baseURL = "https://rickandmortyapi.com/api/"
    static let shared = Service()

    //MARK: - Request Location
    func fetchLocationRequest (filterLocation:String, endpointType: endpointType, completion: @escaping (Result<LocationModel<InfoModel>, ErrorType>) -> ()) {

        let url = Service.baseURL + endpointType.apiTypeString + "/?name=" + filterLocation

        guard let requestURL = URL(string: url) else {
            completion(.failure(.urlError))
            return
        }

        let task = URLSession.shared.dataTask(with: requestURL) { data, resp, err in

            guard let httpResponse = resp as? HTTPURLResponse, 200..<300 ~= httpResponse.statusCode else {
                completion(.failure(.responseError))
                return
            }

            guard let data = data else {
                completion(.failure(.dataError))
                return
            }

            do {
                let response = try JSONDecoder().decode(LocationModel<InfoModel>.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(response))
                }
            }
            catch {
                completion(.failure(.decodingError))
            }
        }
        task.resume()
    }
}
