//
//  Expense.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 28/03/23.
//

import Foundation
struct Expense{
    var idValance : Int
    var Name : String?
    var cantidad : Double?
    var IdTipoBalance : Int?
    var IdSubCategorie : Int?
    var IdUser : Int?
    var fecha : String?
    
    init(idValance: Int, Name: String, cantidad: Double, IdTipoBalance: Int, IdSubCategorie: Int, IdUser: Int, fecha: String) {
        self.idValance = idValance
        self.Name = Name
        self.cantidad = cantidad
        self.IdTipoBalance = IdTipoBalance
        self.IdSubCategorie = IdSubCategorie
        self.IdUser = IdUser
        self.fecha = fecha
    }
    
    init(){
        self.idValance = 0
        self.Name = ""
        self.cantidad = 0
        self.IdTipoBalance = 0
        self.IdSubCategorie = 0
        self.IdUser = 0
        self.fecha = ""
    }
}
