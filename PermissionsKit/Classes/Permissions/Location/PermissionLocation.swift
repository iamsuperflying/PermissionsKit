//
//  PermissionLocation.swift
//  PermissionsKit
//
//  Created by Flying on 2020/11/27.
//

import UIKit

public class PermissionLocation: PermissionProtocol {
    
    public var status: Permission.Status {
        return .denied
    }
    
    public func request(_ completion: (Bool, Bool) -> Void) {
//        PermissionLocationManager.manager
    }
    
}
