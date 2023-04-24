//
//  MainTabView.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import SwiftUI

struct MainTabView: View {
    @ObservedObject var locationViewModel = LocationViewModel()
    @State var filterLocation = ""
    @State private var selectedButtonIndex: Int?
    @ObservedObject var locationDetailViewModel = CharacterDetailViewModel()
    @State var selectedCharacter: Character?
    
    var location: LocationResult?
    
    
    var body: some View {
        NavigationView {
            VStack {
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 10) {
                        ForEach(Array(locationViewModel.locationResponse.indices), id: \.self) { index in
                            Button(action: {
                                selectedButtonIndex = index
                                let locationResidents = locationViewModel.locationResponse[index].residents
                                let ids = locationResidents?
                                    .compactMap { URL(string: $0)?.lastPathComponent }
                                    .joined(separator: ",")
                                locationDetailViewModel.fetchCharactersbyIds(ids: ids!)
                            }) {
                                VStack(spacing: 10) {
                                    Text(locationViewModel.locationResponse[index].name ?? "DefaultLocationName")
                                        .foregroundColor(selectedButtonIndex == index ? Color("colorDarkGreen") : Color("colorLightGreen"))
                                        .font(.custom("Avenir", size: 20))
                                        .bold()
                                        .padding(.horizontal)
                                    Capsule()
                                        .fill(selectedButtonIndex == index ? Color("colorDarkGreen") : .clear)
                                        .frame(height: 3)
                                        .padding(.horizontal, -10)
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                }; ScrollView(.vertical) {
                    LazyVStack(spacing: 10) {
                        ForEach(locationDetailViewModel.characters) { character in
                            VStack {
                                NavigationLink(destination: CharacterDetailView(character: character)) {
                                    MainCellView(character: character)
                                        .background(Color.white)
                                        .cornerRadius(8)
                                        .padding(.horizontal)
                                }
                                Divider()
                            }
                        }
                    }
                }
            }
            .onAppear() {
                locationViewModel.initialize(filterLocation: filterLocation)
                let characterIds = Array(1...20).map(String.init).joined(separator: ",")
                locationDetailViewModel.fetchCharactersbyIds(ids: characterIds)
                
            }
            .navigationTitle("Rick and Morty")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .principal) {
                    Image("rmLogo").resizable().aspectRatio(contentMode: .fill).frame(width: 70, height: 50)
                }
            }
        }
    }}


struct LocationTabView_Previews: PreviewProvider {
    static var previews: some View {
        MainTabView()
    }
}
