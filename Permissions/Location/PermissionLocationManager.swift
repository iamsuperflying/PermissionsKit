//
//  PermissionLocationManager.swift
//  PermissionsKit
//
//  Created by Flying on 2020/12/1.
//

import UIKit
import CoreLocation

struct Constants {
    /// API for iOS11 after
    static let AlwaysUsageDescription  = "NSLocationAlwaysUsageDescription"
    static let AlwaysAndWhenInUseUsageDescription = "NSLocationAlwaysAndWhenInUseUsageDescription"
    static let WhenInUseUsageDescription = "NSLocationWhenInUseUsageDescription"
}

class PermissionLocationManager: NSObject {
    
    static let manager = PermissionLocationManager()
    
    var type: LocationType = .whenInUse
    
    lazy var locationManager: CLLocationManager = {
        CLLocationManager()
    }()
    
    var status: CLAuthorizationStatus {
        if #available(iOS 14.0, *) {
            return locationManager.authorizationStatus
        } else {
            return CLLocationManager.authorizationStatus()
        }
    }
    
    var completionHandler: CompletionHandler?
    
    override init() {
        super.init()
    }

}

// MARK: - Enum
extension PermissionLocationManager {
    
    enum LocationType {
        case whenInUse, always
    }
    
}

// MARK: - Can
extension PermissionLocationManager {
    
    var canAlways: Bool {
        let info = Bundle.main.infoDictionary
        if #available(iOS 11.0, *) {
            return  info?[Constants.AlwaysAndWhenInUseUsageDescription] != nil
                 && info?[Constants.WhenInUseUsageDescription] != nil
        } else {
            return info?[Constants.AlwaysUsageDescription] != nil
        }
    }
    
    var canWhenInUse: Bool {
        let info = Bundle.main.infoDictionary
        return info?[Constants.WhenInUseUsageDescription] != nil
    }
    
    var isAuthorized: Bool {
        if status == .authorizedAlways {
            return true
        }
        let whenInUse = type == .whenInUse
        return whenInUse ? status == .authorizedWhenInUse : false
    }
    
    var isDenied: Bool {
        status == .denied || status == .restricted
    }
    
}

// MARK: - Handler
extension PermissionLocationManager {
    
    func request(type: LocationType, completion: CompletionHandler?)  {
        
        guard let completion = completion else { return }
        
        self.type = type
        self.completionHandler = completion
        
        if status == .notDetermined {
            locationManager.delegate = self
            if type == .always {
                
            } else {
                
            }
            
        } else {
            completion(isAuthorized)
        }
        
    }
    
}

extension PermissionLocationManager: CLLocationManagerDelegate {
    
    
    // MARK: - 授权结果回调
    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        
        
        
    }
    // MARK: - 授权结果回调 For iOS14
    func locationManagerDidChangeAuthorization(_ manager: CLLocationManager) {
        
    }
    
}

extension PermissionLocationManager {
    typealias CompletionHandler = (Bool) -> Void
}
