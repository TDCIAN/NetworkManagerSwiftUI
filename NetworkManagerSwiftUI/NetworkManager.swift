//
//  NetworkManager.swift
//  NetworkManagerSwiftUI
//
//  Created by JeongminKim on 2021/12/30.
// 도움 출처: https://magicmon.tistory.com/229

import Foundation
import Network

class NetworkManager: ObservableObject {
    let monitor = NWPathMonitor()

    @Published var isConnected = true
    
    var imageName: String {
        return isConnected ? "wifi" : "wifi.slash"
    }
    
    var connectionDescription: String {
        if isConnected {
            return "Internet connection looks good!"
        } else {
            return "It looks like you're not connected to the internet"
        }
    }
    
    init() {
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async {
                self.isConnected = path.status == .satisfied
            }
        }
        
        monitor.start(queue: DispatchQueue.global())
    }
    
    func startMonitoring() {
        monitor.start(queue: DispatchQueue.main)
        monitor.pathUpdateHandler = { path in
            self.isConnected = path.status == .satisfied
            
            if path.usesInterfaceType(.wifi) {
                print("Using wifi")
            } else if path.usesInterfaceType(.cellular) {
                print("Using cellular")
            }
        }
    }
    
    func stopMonitoring() {
        monitor.cancel()
    }
}
