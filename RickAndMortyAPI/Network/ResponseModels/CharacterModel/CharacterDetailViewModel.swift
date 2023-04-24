//
//  CharacterDetailViewModel.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import Foundation

class CharacterDetailViewModel: ObservableObject {
    @Published var characters: [Character] = []
    
    func fetchCharactersbyIds(ids: String){
        let urlString = "https://rickandmortyapi.com/api/character/\(ids)"
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print("Error: \(error.localizedDescription)")
                return
            }
            
            guard let data = data else { return }
            
            do {
                let characters = try JSONDecoder().decode([Character].self, from: data)
                DispatchQueue.main.async {
                    self.characters = characters
                }
            } catch {
                do {
                    let character = try JSONDecoder().decode(Character.self, from: data)
                    DispatchQueue.main.async {
                        self.characters = [character]
                    }
                } catch {
                    print("ERROR: \(error.localizedDescription)")
                }
            }
        }.resume()
    }
    
    
}
