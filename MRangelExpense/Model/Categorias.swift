//
//  Categorias.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 28/03/23.
//

import Foundation
struct SubCategorias{
    var IdSubcategorias : Int
    var nameSubCategoria : String
    var idCategoria : Int
    
    init(IdSubcategorias: Int, nameSubCategoria: String, idCategoria: Int) {
        self.IdSubcategorias = IdSubcategorias
        self.nameSubCategoria = nameSubCategoria
        self.idCategoria = idCategoria
    }
    
    init(){
        self.IdSubcategorias = 0
        self.nameSubCategoria = ""
        self.idCategoria = 0
    }
}
struct categorias{
    var IdCategorias : Int
    var NameCategorias : String
    var subcategorias : [SubCategorias]?
    
    init(IdCategorias: Int, NameCategorias: String, subcategorias: [SubCategorias]? = nil) {
        self.IdCategorias = IdCategorias
        self.NameCategorias = NameCategorias
        self.subcategorias = subcategorias
    }
    
    init(){
        self.IdCategorias = 0
        self.NameCategorias = ""
        self.subcategorias = [SubCategorias]()
    }
}
