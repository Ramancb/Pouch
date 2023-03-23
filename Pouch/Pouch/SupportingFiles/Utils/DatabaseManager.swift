//
//  DatabaseManager.swift
//  Pouch
//
//  Created by Raman choudhary on 27/02/23.
//

import Foundation
import CouchbaseLiteSwift
import ObjectMapper

class DatabaseManager {
    
    // public
   
    
    var db:Database? {
        get {
            return _db
        }
    }
    var dbChangeListenerToken:ListenerToken?

    // db name
    static let kDBName:String = "cards"
    static let kTemplateDBName:String = "templates"
    static let kProfileDBName:String = "userProfile"
    fileprivate var _db:Database?
    
    
    static let shared:DatabaseManager = {
        
        let instance = DatabaseManager()
        instance.initialize()
        return instance
    }()
    
    func initialize() {
        //  enableCrazyLevelLogging()
    }
    // Don't allow instantiation . Enforce singleton
    private init() {
        
    }
    
    deinit {
        // Stop observing changes to the database that affect the query
        do {
            try self._db?.close()
        }
        catch  {
        }
    }
}

// MARK: Public
extension DatabaseManager {
    // fetch OverallRecord
    func fetchOverAllData(dbName:String,handler:(_ data: [[String:Any]]?,_ error:Error?)->Void){
        self.openOrCreateDatabase(db_name: dbName) { error in
            if error == nil{
                guard let dataBase = db else{return}
                let query = QueryBuilder
                    .select(SelectResult.all())
                    .from(DataSource.database(dataBase))
                do {
                    let result = try query.execute()
                    let dic = result.map({$0.dictionary(forKey: dbName)?.toDictionary() ?? [:]})
//                    let data:[CardsData] = Mapper<CardsData>().mapArray(JSONArray: dic)
                    handler(dic,nil)
                    
                } catch {
                    handler(nil,error)
                    fatalError("Error running the query")
                }
            }
        }
        
    }
    
    
    // // Create a new document (i.e. a record) in the database.
    
    func createOrUpdateDocumentForDb(_id:String,dbName:String,json:[String:Any]){
        self.openOrCreateDatabase(db_name: dbName) { error in
            if error == nil{
                if let mutableDoc = db?.document(withID: _id)?.toMutable() {
                    mutableDoc.setData(json)
                    self.saveDocToDb(document: mutableDoc)
                }else{
                    let mutableDoc = MutableDocument(id: _id, data: json)
                    // Save it to the database.
                    self.saveDocToDb(document: mutableDoc)
                }
            }
        }
    }
    
    func isDbDocumentExist(dbName:String,templateName:String,handler:(_ data: TemplatesData?,_ error:Error?)->Void){
        self.openOrCreateDatabase(db_name: dbName) { error in
            if error == nil{
                guard let dataBase = db else{return}
                let query = QueryBuilder
                    .select(SelectResult.all())
                    .from(DataSource.database(dataBase)).where(Expression.property("name") .equalTo(Expression.string(templateName)))
                do {
                    let result = try query.execute()
                    let dic = result.map({$0.dictionary(forKey: dbName)?.toDictionary() ?? [:]})
                    guard let dic_data = dic.first else{
                        handler(nil,NSError(domain: "No document found", code: 1))
                        return
                    }
                    if let data:TemplatesData = Mapper<TemplatesData>().map(JSON: dic_data) {
                        handler(data,nil)
                    }
                } catch {
                    handler(nil,error)
                    fatalError("Error running the query")
                }
            }
        }
    }
    
    func saveDocToDb(document:MutableDocument){
        do {
            try db?.saveDocument(document)
        } catch {
            fatalError("Error saving document")
        }
    }
    
    func deleteDocFromDb(document:MutableDocument){
        do {
            try db?.deleteDocument(document)
        } catch {
            fatalError("Error saving document")
        }
    }
    
    func deleteDocFromDb(document_id:String,dbName:String,completion:(_ succeed:Bool)->Void){
        self.openOrCreateDatabase(db_name: dbName) { error in
            if error == nil{
                guard let dataBase = db else{return}
                if let doc = dataBase.document(withID: document_id)?.toMutable(){
                    do {
                        try db?.deleteDocument(doc)
                        completion(true)
                    } catch {
                        completion(false)
                    }
                }
            }
        }
    }
    
    
    func openOrCreateDatabase(db_name:String,handler:(_ error:Error?)->Void) {
        do {
            
            // Create a new DB or get handle to existing DB at specified path
            _db = try Database(name: db_name)
            handler(nil)
        }catch {
            handler(error)
        }
    }

    
    func closeDatabase(db_name:String) -> Bool {
        do {
            print(#function)
            // Get handle to DB  specified path
             let db = try Database(name: db_name)
                deregisterForDatabaseChanges()
                try db.close()
                try db.delete()
                _db = nil
            
            return true
        }
        catch {
            return false
        }
    }
    
    fileprivate func registerForDatabaseChanges() {
        
        // Add database change listener
        dbChangeListenerToken = db?.addChangeListener({ [weak self](change) in
            guard let `self` = self else {
                return
            }
            for docId in change.documentIDs   {
                if let docString = docId as String? {
                    let doc = self._db?.document(withID: docString)
                    if doc == nil {
                        print("Document was deleted")
                    }
                    else {
                        print("Document was added/updated")
                    }
                }
            }
        })
    }
    
    fileprivate func deregisterForDatabaseChanges() {
        
        // Add database change listener
        if let dbChangeListenerToken = self.dbChangeListenerToken {
            db?.removeChangeListener(withToken: dbChangeListenerToken)
        }
    }
}

// MARK: Utils
extension DatabaseManager {
    
    fileprivate func enableCrazyLevelLogging() {
        Database.log.console.domains = .all
        Database.log.console.level = .debug
    }
}
