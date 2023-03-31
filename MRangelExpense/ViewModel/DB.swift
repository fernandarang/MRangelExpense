//
//  DB.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 28/03/23.
//

import Foundation
import SQLite3

class DB{
    let path : String = "Documents.Expense.sql"
    var db : OpaquePointer? = nil
    
    init(){
        db = OpenConexion()
    }
    func OpenConexion() -> OpaquePointer? {
        let filePath = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0].appendingPathExtension(self.path)
        var db : OpaquePointer? = nil
        
        if sqlite3_open(filePath.path, &db) == SQLITE_OK{
            //print("Conexión Correcta")
            //print(filePath)
            return db
        }else{
            print("Error")
            return nil
        }
    }
}
