//
//  swift
//  PermissionsKit
//
//  Created by Flying on 2020/11/27.
//

import UIKit

@objc public class Permission: NSObject {
    
//    @property (nonatomic, strong) NSDictionary<NSNumber *, NSString *> *permissions;
//    @property (nonatomic, strong) id<RSPermissionProtocol> permission;
    
    var permission: PermissionProtocol?
    
    func authorizationStatus(for permissionGenre: Genre) -> Status {
        .notdetermined
    }

    func request(for permissionGenre: Genre, completion: @escaping (_ status: Status) -> Void)  {
        guard let className = self.permissions[permissionGenre],
              let permissionClass = NSClassFromString("PermissionsKit." + className) as? PermissionProtocol.Type else {
                return
        }
        
        let per = (permissionClass as! NSObject.Type).init()
        print(per)
        
    }

    func request(forLimited permissionGenre: Genre, completion: @escaping (_ status: Status) -> Void)  {
        
    }
    
    lazy var permissions: Dictionary<Genre, String> = {
        return [
            .location: "PermissionLocation"
        ]
    }()

}

extension Permission {
    
    @objc public enum Genre: Int {
        case net, location, camera, photos, notice, bluetooth, microphone, contacts, calendar, fulllocation
    }
    
    @objc public enum Status: Int {
        case notdetermined, denied, authorized, limited
    }
    
}
