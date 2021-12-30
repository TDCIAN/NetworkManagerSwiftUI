//
//  ContentView.swift
//  NetworkManagerSwiftUI
//
//  Created by JeongminKim on 2021/12/30.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject var networkManager = NetworkManager()
    
    var body: some View {
        
        Group {
            if networkManager.isConnected {
                // show main content
            } else {
                // show failed internet screen
            }
        }
        
        ZStack {
            Color(.systemBlue).ignoresSafeArea()
            
            VStack {
                Image(systemName: networkManager.imageName)
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200, height: 200)
                    .foregroundColor(Color.white)
                
                Text(networkManager.connectionDescription)
                    .font(.system(size: 18))
                    .foregroundColor(.white)
                    .padding()
                
                Button(action: {
                    networkManager.startMonitoring()
                }, label: {
                    Text("Check Status")
                        .padding()
                        .font(.headline)
                        .foregroundColor(Color(.systemBlue))
                })
                .frame(width: 140)
                .background(Color.white)
                .clipShape(Capsule())
                .padding()
            }
        }
    }
}
