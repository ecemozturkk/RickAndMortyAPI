//
//  SplashScreenView.swift
//  RickAndMortyAPI
//
//  Created by Ecem Öztürk on 24.04.2023.
//

import SwiftUI

struct SplashScreenView: View {
    @State private var orientation = UIDeviceOrientation.unknown
    
    @State var isHomeRootScreen = false
    @State var scaleAmount: CGFloat = 1
    @State var helloWelcome:String = "helloImg"
    
    var body: some View {
       
        VStack{
            if isHomeRootScreen {
                    MainTabView()
                
            } else {
                ZStack {
                    Image("backgroundImg").resizable()
                        .aspectRatio(contentMode: .fill)
                        .edgesIgnoringSafeArea(.all)
                        .frame(width: UIScreen.main.bounds.width, height: UIScreen.main.bounds.height)
                    VStack {
                        Image(helloWelcome).resizable().aspectRatio(contentMode: .fit).frame(width: 300)
                        Image("rickandmorty")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .scaleEffect(scaleAmount)
                            .frame(width: 400)

                    }
                }}
        }
        .ignoresSafeArea()
        .onAppear{
            //shrink the icon
            helloWelcome = getWelcomeText()
            withAnimation(.easeOut(duration: 1)) {
                scaleAmount = 0.8
            }
            //enlarge the icon
            withAnimation(.easeInOut(duration: 0.8).delay(1)) {
                if orientation.isPortrait {
                    scaleAmount = 100} else {
                        scaleAmount = 180
                    }
            }
            // go to home screen
            DispatchQueue.main.asyncAfter(deadline: .now() + 1.8) {
                isHomeRootScreen = true
                }
            }
    }
    
    private func getWelcomeText() -> String {
        if UserDefaults.standard.bool(forKey: "isFirstLaunch") {
            return "helloImg"
        } else {
            UserDefaults.standard.set(true, forKey: "isFirstLaunch")
            return "welcomeImg"
        }
    }
    
    
    struct ContentView_Previews: PreviewProvider {
        static var previews: some View {
            SplashScreenView()
        }
    }
    
    struct DeviceRotationViewModifier: ViewModifier {
        let action: (UIDeviceOrientation) -> Void

        func body(content: Content) -> some View {
            content
                .onAppear()
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    action(UIDevice.current.orientation)
                }
        }
    }
}



