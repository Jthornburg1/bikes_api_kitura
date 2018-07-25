//
//  Bike.swift
//  CHTTPParser
//
//  Created by jonathan thornburg on 7/25/18.
//

import Foundation

struct Bike: Codable {
    
    var id: String?
    var make: String
    var model: String
    
    init?(id:String?, make: String, model: String) {
        if make.isEmpty || model.isEmpty {
            return nil
        }
        self.id = id
        self.make = make
        self.model = model
    }
}

extension Bike: Equatable {
    
    public static func ==(lhs: Bike, rhs: Bike) -> Bool {
        return lhs.make == rhs.make && lhs.model == rhs.model
    }
}
