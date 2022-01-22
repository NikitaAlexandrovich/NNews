//
//  NetworkManager.swift
//  NNews
//
//  Created by Никита Ходарёнок on 16.01.22.
//

import Foundation
import Network

@MainActor
class NetworkManager: ObservableObject{
    
    @Published var isConnected = true
    let monitor = NWPathMonitor()
    let queue = DispatchQueue(label: "Network")
    
    init(){
//        monitor.pathUpdateHandler = { path in
//            DispatchQueue.main.async { [self] in
//                self.isConnected = path.status == .satisfied
//            }
//        }
//        monitor.start(queue: queue)
        updateStatus()
    }
    
    func updateStatus() {
        
        monitor.pathUpdateHandler = { path in
            DispatchQueue.main.async { [self] in
                self.isConnected = path.status == .satisfied
            }
        }
        monitor.start(queue: queue)
    }
}
