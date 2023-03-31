//
//  CategoriasViewModel.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 29/03/23.
//

import Foundation
import SQLite3

class CategoriasViewModel {
    
    func addSubCategoria(subcategoria: SubCategorias)-> Result{
        var result = Result()
        let context = DB.init()
        let query = "INSERT INTO SubCategorias(nombreSubcategoria, idCategoria) VALUES(?,?)"
        var statement : OpaquePointer? = nil
            
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                    sqlite3_bind_text(statement, 1, (subcategoria.nameSubCategoria as NSString).utf8String, -1, nil)
                    sqlite3_bind_int(statement, 2, Int32(subcategoria.idCategoria))
                    
                    if sqlite3_step(statement) == SQLITE_DONE{
                        result.Correct = true
                    }
                    else{
                        result.Correct = false
                    }
                }
            }
            catch let error{
                result.Correct = false
                result.ErrorMessage = error.localizedDescription
                result.Ex = error
            }
            return result
        }
        
    func addCategoria(categoria: categorias)->Result{
           
        var result = Result()
        let context = DB.init()
        let query = "Insert INTO Categorias(nombreCategoria) VALUES(?)"
        var statement : OpaquePointer? = nil
            
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                    sqlite3_bind_text(statement, 1, (categoria.NameCategorias as NSString).utf8String, -1, nil)
                    
                    if sqlite3_step(statement) == SQLITE_DONE{
                        result.Correct = true
                    }
                    else{
                        result.Correct = false
                    }
                }
            }
            catch let error{
                result.Correct = false
                result.ErrorMessage = error.localizedDescription
                result.Ex = error
            }
            return result
    }
    
        func getallSubcategorias()->Result{
            var result = Result()
            let context = DB.init()
            let query = "SELECT idSubcategoria, nombreSubcategoria FROM SubCategorias"
            var statement : OpaquePointer? = nil
            do{
                if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK {
                           result.Objects = []
                           while sqlite3_step(statement) == SQLITE_ROW{
                              
                               var subcategorias = SubCategorias(IdSubcategorias: 0, nameSubCategoria: "", idCategoria: 0)
                               subcategorias.IdSubcategorias = Int(sqlite3_column_int(statement, 0))
                               subcategorias.nameSubCategoria = String(cString: sqlite3_column_text(statement, 1))
                             
                               result.Objects?.append(subcategorias)
                           }
                           result.Correct = true
                           
                       }
                     
                   }  catch let error {
                       result.Correct = false
                       result.Ex = error
                       result.ErrorMessage = error.localizedDescription
                   }
          
            return result
        }
        
        func getsubcategoriesbyIdCategory(idCategory : Int)->Result{
            
            var result = Result()
            let context = DB.init()
            let query = "SELECT idSubcategoria, nombreSubcategoria, idCategoria FROM SubCategorias WHERE (idCategoria = \(idCategory))"
            var statement : OpaquePointer? = nil
            do{
                if try sqlite3_prepare_v2(context.db
                                          , query, -1, &statement, nil) == SQLITE_OK{
                    result.Objects = []
                    while sqlite3_step(statement) == SQLITE_ROW{
                        var subcategorias = SubCategorias(IdSubcategorias: 0, nameSubCategoria: "", idCategoria: 0)
                         subcategorias.IdSubcategorias = Int(sqlite3_column_int(statement, 0))
                         subcategorias.nameSubCategoria = String(cString: sqlite3_column_text(statement, 1))
                       
                         result.Objects?.append(subcategorias)
                    }
                    result.Correct = true
                }
            }
            catch let error{
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
            return result
            
        }
        func getbyNombre(nombrecategoria: String)->Result{
            var result = Result()
            let context = DB.init()
            let query = "SELECT idSubcategoria, nombreSubcategoria, idCategoria FROM SubCategorias WHERE nombreSubcategoria LIKE LTRIM(RTRIM('\(nombrecategoria)')||'%')"
            var statement : OpaquePointer? = nil
            do{
                if try sqlite3_prepare_v2(context.db
                                          , query, -1, &statement, nil) == SQLITE_OK{
                    result.Objects = []
                    while sqlite3_step(statement) == SQLITE_ROW{
                        var subcategorias = SubCategorias(IdSubcategorias: 0, nameSubCategoria: "", idCategoria: 0)
                         subcategorias.IdSubcategorias = Int(sqlite3_column_int(statement, 0))
                         subcategorias.nameSubCategoria = String(cString: sqlite3_column_text(statement, 1))
                       
                         result.Objects?.append(subcategorias)
                    }
                    result.Correct = true
                }
            }
            catch let error{
                result.Correct = false
                result.Ex = error
                result.ErrorMessage = error.localizedDescription
            }
            return result
        }
    
    func getbyNombre2(nombrecategoria: String)->Result{
        var result = Result()
        let context = DB.init()
        let query = "SELECT idSubcategoria, nombreSubcategoria, idCategoria FROM SubCategorias WHERE nombreSubcategoria = '\(nombrecategoria)'"
        var statement : OpaquePointer? = nil
        do{
            if try sqlite3_prepare_v2(context.db
                                      , query, -1, &statement, nil) == SQLITE_OK{
                result.Objects = []
                while sqlite3_step(statement) == SQLITE_ROW{
                    var subcategorias = SubCategorias(IdSubcategorias: 0, nameSubCategoria: "", idCategoria: 0)
                     subcategorias.IdSubcategorias = Int(sqlite3_column_int(statement, 0))
                     subcategorias.nameSubCategoria = String(cString: sqlite3_column_text(statement, 1))
                   
                     result.Objects?.append(subcategorias)
                }
                result.Correct = true
            }
        }
        catch let error{
            result.Correct = false
            result.Ex = error
            result.ErrorMessage = error.localizedDescription
        }
        return result
    }
    
        func getall()->Result{
            var result = Result()
            let context = DB.init()
            let query = "SELECT idCategoria, nombreCategoria FROM Categorias"
            var statement : OpaquePointer? = nil
            do{
                       if try sqlite3_prepare_v2(context.db, query, -1, &statement, nil) == SQLITE_OK{
                           result.Objects = []
                           while sqlite3_step(statement) == SQLITE_ROW{
                               
                              var subcategorias = SubCategorias()
                              var categorias = categorias()
                               
                               categorias.IdCategorias = Int(sqlite3_column_int(statement, 0))
                               categorias.NameCategorias = String(cString: sqlite3_column_text(statement, 1))
                               var result2 =  getsubcategoriesbyIdCategory(idCategory: categorias.IdCategorias)
                                   categorias.subcategorias = result2.Objects as! [SubCategorias]
                               
                               result.Objects?.append(categorias)
                           }
                           result.Correct = true
                           
                       }
                     
                   }  catch let error {
                       result.Correct = false
                       result.Ex = error
                       result.ErrorMessage = error.localizedDescription
                   }
    //        sqlite3_finalize(statement)
    //                sqlite3_close(context.db)
            return result
            
        }
}
