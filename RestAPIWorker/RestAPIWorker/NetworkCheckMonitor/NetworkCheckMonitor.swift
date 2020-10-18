//
//  NetworkCheckMonitor.swift
//  RestAPIWorker
//
//  Created by Gagan  Vishal on 10/18/20.
//

import Foundation
import Network

class NetworkCheckMonitor {
    static public let shared = NetworkCheckMonitor()
    private var monitor: NWPathMonitor
    private var queue = DispatchQueue.global()
    var netOn: Bool = true
    var connType: ConnectionType = .wifi
    //MARK:- Init
    private init() {
        self.monitor = NWPathMonitor()
        self.queue = DispatchQueue.global(qos: .background)
        self.monitor.start(queue: queue)
    }
    
    //MARK:- Start Network Monitoring
    func startMonitoring() {
        self.monitor.pathUpdateHandler = { path in
            self.netOn = path.status == .satisfied
            self.connType = self.checkConnectionTypeForPath(path)
        }
    }
    
    //MARK:- Stop Network monitoring
    func stopMonitoring() {
        self.monitor.cancel()
    }
    
    //MARK:- Check for Connection Type
    func checkConnectionTypeForPath(_ path: NWPath) -> ConnectionType {
        if path.usesInterfaceType(.wifi) {
            return .wifi
        } else if path.usesInterfaceType(.wiredEthernet) {
            return .ethernet
        } else if path.usesInterfaceType(.cellular) {
            return .cellular
        }
        return .unknown
    }
}

public enum ConnectionType {
    case wifi
    case ethernet
    case cellular
    case unknown
}
