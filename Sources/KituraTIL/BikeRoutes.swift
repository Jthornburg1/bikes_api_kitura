//
//  BikeRoutes.swift
//  CHTTPParser
//
//  Created by jonathan thornburg on 7/25/18.
//

import Foundation
import CouchDB
import Kitura
import KituraContracts
import LoggerAPI

private var database: Database?

func initializeBikeRoutes(app: App) {
    database = app.database
    
    app.router.get("/bikes", handler: getBikes)
    app.router.post("/bikes", handler: addBike)
    app.router.delete("/bike", handler: deleteBike)
}

private func getBikes(completion: @escaping ([Bike]?, RequestError?) -> Void) {
    guard let database = database else {
        return completion(nil, .internalServerError)
    }
    Bike.Persistence.getAll(from: database) { (bikes, error) in
        return completion(bikes, error as? RequestError)
    }
}

private func addBike(bike: Bike, completion: @escaping (Bike?, RequestError?) -> Void) {
    guard let database = database else {
        return completion(nil, .internalServerError)
    }
    Bike.Persistence.save(bike, to: database) { (id, error) in
        guard let id = id else {
            return completion(nil,.notAcceptable)
        }
        Bike.Persistence.get(from: database, with: id, callback: { (newBike, error) in
            return completion(newBike, error as? RequestError)
        })
    }
}

private func deleteBike(id: String, completion: @escaping (RequestError?) -> Void) {
    guard let database = database else {
        return completion(.internalServerError)
    }
    Bike.Persistence.delete(with: id, from: database) { (error) in
        return completion(error as? RequestError)
    }
}
