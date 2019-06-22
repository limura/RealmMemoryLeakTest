//
//  Models.swift
//  RealmLeakTest
//
//  Created by 飯村卓司 on 2019/06/18.
//  Copyright © 2019 limura products. All rights reserved.
//

import Foundation
import RealmSwift

@objc final class Model1 : Object {
    @objc dynamic var id : String = UUID().uuidString
    @objc dynamic var boolKey : Bool = false
    @objc dynamic var stringKey: String = "a"
    @objc dynamic var intKey: Int = 0
    @objc dynamic var dateKey: Date = Date(timeIntervalSince1970: 0)

    override class func primaryKey() -> String? {
        return "id"
    }
    
    override static func indexedProperties() -> [String] {
        return ["boolKey", "stringKey", "intKey", "dateKey"]
    }
}
