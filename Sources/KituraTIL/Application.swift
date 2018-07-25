//
//  Application.swift
//  CHTTPParser
//
//  Created by jonathan thornburg on 7/25/18.
//

import CouchDB
import Foundation
import Kitura
import LoggerAPI

public class App {
    
    var client: CouchDBClient?
    var database: Database?
    
    let router = Router()
    
    private func postInit() {
        let connectionProperties = ConnectionProperties(host: "localhost", port: 5984, secured: false)
        client = CouchDBClient(connectionProperties: connectionProperties)
        client!.dbExists("bikes") { exists, _ in
            guard exists else {
                self.createNewDatabase()
                return
            }
            Log.info("Bikes database located = loading...")
            self.finalizeRoutes(with: Database(connProperties: connectionProperties, dbName: "bikes"))
        }
    }
    
    private func createNewDatabase() {
        Log.info("Database does not exist - creating new database")
        client!.createDB("bikes") { (database, error) in
            guard let database = database else {
                let errorReason = String(describing: error?.localizedDescription)
                Log.error("Could not create new database: (\(errorReason) = bike routes new created")
                return
            }
            self.finalizeRoutes(with: database)
        }
    }
    
    private func finalizeRoutes(with database: Database) {
        self.database = database
        initializeBikeRoutes(app: self)
        Log.info("Bikes routes created")
    }
    
    public func run() {
        postInit()
        Kitura.addHTTPServer(onPort: 8080, with: router)
        Kitura.run()
    }
}


