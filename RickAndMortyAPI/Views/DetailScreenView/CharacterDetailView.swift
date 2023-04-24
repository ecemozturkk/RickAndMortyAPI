//
//  CharacterDetailView.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import SwiftUI

struct CharacterDetailView: View {
    
    @Environment(\.verticalSizeClass) var verticalSizeClass
    @Environment(\.horizontalSizeClass) var horizontalSizeClass
    
    var isLandscape: Bool {
        verticalSizeClass == .compact
    }
    
    
    
    var character: Character?
    var episodeModels: [EpisodeModel] {
        character?.episode?.compactMap({ EpisodeModel(episodeURL: $0) }) ?? []
    }
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        
        let layout = isLandscape == true ? AnyLayout(HStackLayout()) : AnyLayout(VStackLayout())
        
        layout {
            layout{
                ZStack { // MARK: Character Image
                    RoundedRectangle(cornerRadius: 25)
                        .frame(width: 275, height: 275, alignment: .center)
                        .padding(.bottom, isLandscape ? 0 : 50)
                        .padding(.horizontal, 50)
                        .padding(.vertical, 20)
                        .foregroundColor(.white)
                    
                    
                    AsyncImage(url: URL(string: character?.image ?? "")) { image in
                        image
                            .resizable()
                            .frame(width: 275, height: 275, alignment: .center)
                            .aspectRatio(contentMode: .fit)
                            .clipShape(RoundedRectangle(cornerRadius: 25))
                            .padding(.bottom, isLandscape ? 0 : 50)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 20)
                        
                    } placeholder: {
                        RoundedRectangle(cornerRadius: 25)
                            .frame(width: 275, height: 275, alignment: .center)
                            .padding(.horizontal, 50)
                            .padding(.vertical, 20)
                            .foregroundColor(Color("colorGreen"))
                            .overlay(
                                ProgressView()
                            )
                            .padding(.bottom, isLandscape ? 0 : 50)
                    }
                }
            }.frame(width: isLandscape ? getRect().width / 2.7 : getRect().width,
                    height: isLandscape ? getRect().height : getRect().height / 3)
            
            
            ScrollView(.vertical, showsIndicators: false){
                VStack(alignment: .leading, spacing: 15){
                    Text(character?.name ?? "Character Name").font(.custom("GetSchwifty-Regular", size: 35)).foregroundColor(Color("colorDarkGreen")).padding(.horizontal,20).padding(.vertical, 5)
                }.padding(.top, 20).frame(maxWidth: .infinity, maxHeight: .infinity)
                
                
                // MARK: Character Status
                HStack {
                    Text("Status").font(.custom("Avenir", size: 22).bold())
                    Spacer()
                    Text(character?.status?.rawValue ?? "Character Status").font(.custom("Avenir", size: 22))
                    
                }.padding(.vertical,10)
                    .padding(.horizontal,20)
                
                // MARK: Character Species
                HStack {
                    Text("Species").font(.custom("Avenir", size: 22).bold())
                    Spacer()
                    Text(character?.species?.rawValue ?? "Character Species").font(.custom("Avenir", size: 22))
                }.padding(.vertical,5)
                    .padding(.horizontal,20)
                
                // MARK: Character Gender
                HStack {
                    Text("Gender").font(.custom("Avenir", size: 22).bold())
                    Spacer()
                    Text(character?.gender?.rawValue ?? "Character Gender").font(.custom("Avenir", size: 22))
                }.padding(.vertical,5)
                    .padding(.horizontal,20)
                
                // MARK: Character Origin
                HStack {
                    Text("Origin").font(.custom("Avenir", size: 22).bold())
                    Spacer()
                    Text(character?.origin?.name ?? "Character Origin").font(.custom("Avenir", size: 22))
                }.padding(.vertical,5)
                    .padding(.horizontal,20)
                
                // MARK: Character Location
                HStack {
                    Text("Location").font(.custom("Avenir", size: 22).bold())
                    Spacer()
                    Text(character?.location?.name ?? "Character Location").font(.custom("Avenir", size: 22))
                }.padding(.vertical,5)
                    .padding(.horizontal,20)
                
                // MARK: Character Episodes
                HStack {
                    Text("Episodes").font(.custom("Avenir", size: 22).bold())
                    Spacer()
                    ScrollView(.horizontal, showsIndicators: false) {
                        LazyHStack {
                            ForEach(episodeModels, id: \.episodeNumber) { episode in
                                Text(episode.episodeNumber).font(.custom("Avenir", size: 22)).fixedSize(horizontal: true, vertical: true)
                                    .padding(12)
                                    .background(Color("colorLightGreen"))
                                    .cornerRadius(10)
                                    .frame(width: 50, height: 50)
                            }
                        }
                    }.frame(width: 150)
                }.padding(.vertical,5)
                    .padding(.horizontal,20)
                
                // MARK: Character CreatedAt
                HStack {
                    Text("Created At").font(.custom("Avenir", size: 22).bold())
                    Spacer()
                    Text(character?.created?.formatDate() ?? "createdat").font(.custom("Avenir", size: 22))
                }.padding(.vertical,5)
                    .padding(.horizontal,20).padding(.bottom, 20)
                
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color(.white).clipShape(isLandscape ?
                                                CustomCorners(corners: [.topLeft, .bottomLeft], radius: 25) :
                                                    CustomCorners(corners: [.topLeft, .topRight], radius: 25)).ignoresSafeArea())
        }
        .background(Image("backgroundImg").ignoresSafeArea())
        .navigationBarBackButtonHidden(true)
        .navigationBarItems(leading:
                                Button(action: {
            presentationMode.wrappedValue.dismiss()
        }) {
            Image(systemName: "arrowshape.left.fill")
                .foregroundColor(Color("colorDarkGreen"))
                .imageScale(.large)
        })
        
        
    }
}
struct CharacterDetailView_Previews: PreviewProvider {
    static var previews: some View {
        CharacterDetailView()
    }
}

extension View {
    func getRect() -> CGRect{
        return UIScreen.main.bounds
    }
}


