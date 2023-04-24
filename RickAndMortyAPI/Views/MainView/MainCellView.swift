//
//  MainCellView.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import SwiftUI

struct MainCellView : View {
    
    var character: Character?
    
    var body: some View {
        VStack {
            HStack {
                
                HStack {
                    HStack {
                        AsyncImage(url: URL(string: character?.image ?? "")) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: 121, height: 121, alignment: .center)
                                .cornerRadius(8)
                        } placeholder: {
                            RoundedRectangle(cornerRadius: 4)
                                .fill(Color("colorLightGreen"))
                                .frame(width: 121, height: 121, alignment: .center)
                                .overlay(ProgressView())
                                .cornerRadius(8)
                        }
                    }
                    VStack(spacing: 10) {
                        HStack {
                            Text(character?.name ?? "Character Name")
                                .font(.custom("Avenir", size: 20))
                                .foregroundColor(.black)
                            Spacer()
                        }
                    }
                    
                    ZStack {
                        RoundedRectangle(cornerRadius: 5)
                            .frame(width: 30, height: 30, alignment: .center)
                            .foregroundColor(character?.gender?.rawValue == "Female" ? Color("colorFemale") : character?.gender?.rawValue == "Male" ? Color("colorMale") : character?.gender?.rawValue == "Genderless" ? Color("colorGenderless") : Color("colorUnknown"))
                        Image(character?.gender?.rawValue == "Female" ? "genderFemale" : character?.gender?.rawValue == "Male" ? "genderMale" : character?.gender?.rawValue == "Genderless" ? "genderGenderless" : "genderUnknown")
                            .resizable()
                            .frame(width: 20, height: 20, alignment: .center)
                    }
                    
                    Spacer()
                }.padding()
            }
        }
    }
}

struct MainCellView_Previews: PreviewProvider {
    static var previews: some View {
        MainCellView()
    }
}

