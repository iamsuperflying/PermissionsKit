//
//  PermissionProtocol.swift
//  PermissionsKit
//
//  Created by Flying on 2020/11/27.
//

import Foundation

protocol PermissionProtocol: AnyObject {
    
    var status: Permission.Status { get }
    
    var isAuthorized: Bool { get }
    var isDenied: Bool { get }
    var isLimited: Bool { get }
    var notdetermined: Bool { get }
    
    func request(_ completion: (_ authorized: Bool, _ firstTime: Bool) -> Void)
    
//    @objc optional func requestFullAuthorization(_ completion: (_ authorized: Bool) -> Void)
    
}

extension PermissionProtocol {
    
    var isAuthorized: Bool {
        status == .authorized
    }
    var isDenied: Bool {
        status == .denied
    }
    
    var isLimited: Bool {
        status == .limited
    }
    
    var notdetermined: Bool {
        status == .notdetermined
    }
    
}
