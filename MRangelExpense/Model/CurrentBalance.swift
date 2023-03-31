//
//  CurrentBalance.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 28/03/23.
//

import Foundation
struct  CurentBalance{
    var IdSubcategoria: Int
    var SubCategoria : String
    var Expense : Int
    var Income : Int
    
    init(IdSubcategoria: Int, SubCategoria: String, Expense: Int, Income: Int) {
        self.IdSubcategoria = IdSubcategoria
        self.SubCategoria = SubCategoria
        self.Expense = Expense
        self.Income = Income
    }
    
    init(){
        self.IdSubcategoria = 0
        self.SubCategoria = ""
        self.Expense = 0
        self.Income = 0
    }
}
