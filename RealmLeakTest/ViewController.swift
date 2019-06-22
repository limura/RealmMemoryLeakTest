//
//  ViewController.swift
//  RealmLeakTest
//
//  Created by 飯村卓司 on 2019/06/18.
//  Copyright © 2019 limura products. All rights reserved.
//

import UIKit
import RealmSwift

class ViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        startTest()
    }
    
    var modelObserveTokenArray:[NotificationToken?] = []
    func observeModel() throws {
        try autoreleasepool {
            let realm = try Realm()
            let modelObserveToken = realm.objects(Model1.self).filter("boolKey = false").observe({ (change) in
                // nothing to do.
            })
            modelObserveTokenArray.append(modelObserveToken)
        }
    }
    
    func CreateNewModel() throws {
        try autoreleasepool {
            let realm = try Realm()
            try realm.write {
                let model = Model1()
                realm.add(model)
            }
        }
    }
    
    func process(min:Double, max:Double) {
        DispatchQueue.global(qos: .utility).asyncAfter(deadline: .now() + Double.random(in: min..<max)) {
            try! self.CreateNewModel()
            self.process(min:min, max:max)
        }
    }
    
    func startTest() {
        for _ in 0..<20 {
            try! observeModel()
        }
        for _ in 0..<5 {
            process(min:0.4, max:0.5)
        }
    }
}

