//
//  BikePersistence.swift
//  CHTTPParser
//
//  Created by jonathan thornburg on 7/25/18.
//

import Foundation
import CouchDB
import SwiftyJSON

extension Bike {
    class Persistence {
        static func getAll(from database: Database, callback: @escaping (_ bikes: [Bike]?, _ error: NSError?) -> Void) {
            database.retrieveAll(includeDocuments: true) { documents, error in
                guard let documents = documents else {
                    callback(nil, error)
                    return
                }
                var bikes: [Bike] = []
                for doc in documents["rows"].arrayValue {
                    let id = doc["id"].stringValue
                    let make = doc["doc"]["make"].stringValue
                    let model = doc["doc"]["model"].stringValue
                    if let bike = Bike(id: id, make: make, model: model) {
                        bikes.append(bike)
                    }
                }
                callback(bikes, nil)
            }
        }
        
        static func save(_ bike: Bike, to database: Database, callback: @escaping (_ id: String?, _ error: NSError?) -> Void) {
            getAll(from: database) { (bikes, error) in
                guard let bikes = bikes else {
                    return callback(nil, error)
                }
                guard !bikes.contains(bike) else {
                    return callback(nil, NSError(domain: "Kitura-TIL",
                                                 code: 400,
                                                 userInfo: ["localizedDescription":"Duplicate entry"]))
                }
                database.create(["make":bike.make,"model":bike.model], callback: { (id, _, _, error) in
                    callback(id,error)
                })
            }
        }
        
        static func get(from database: Database, with id: String, callback: @escaping (_ bike: Bike?, _ error: NSError?) -> Void) {
            database.retrieve(id) { (document, error) in
                guard let document = document else {
                    return callback(nil, error)
                }
                guard let bike = Bike(id: id,
                                      make: document["make"].stringValue,
                    model: document["model"].stringValue) else {
                        return callback(nil,error)
                }
                callback(bike,nil)
            }
        }
        
        static func delete(with id: String, from database: Database, callback: @escaping (_ error: NSError?) -> Void) {
            database.retrieve(id) { (document, error) in
                guard let document = document else {
                    return callback(error)
                }
                let id = document["_id"].stringValue
                let revision = document["_rev"].stringValue
                database.delete(id, rev: revision, callback: { (error) in
                    callback(error)
                })
            }
        }
    }
}
