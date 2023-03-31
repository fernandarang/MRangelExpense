//
//  AddViewController.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 29/03/23.
//

import UIKit
import iOSDropDown

class AddViewController: UIViewController, UITextFieldDelegate {

    
    @IBOutlet weak var IncomeOExpense: UITextField!
    @IBOutlet weak var BalanceLbl: UILabel!
    @IBOutlet weak var TipoSegment: UISegmentedControl!
    @IBOutlet weak var MontoField: UITextField!
    @IBOutlet weak var Categoria: DropDown!
    @IBOutlet weak var SubCategoria: DropDown!
    @IBOutlet weak var Date: UIDatePicker!
    
    let modelExpenses : Expense? = nil
    let categoriasviewmodel = CategoriasViewModel()
    let expensesViewModel = ExpensesViewModel()
    var db = DB()
    var idCategory = 0
    var idsubcategory = 0
    let defaults = UserDefaults.standard
    var idTipo = 1
    var currentbalance = 0.0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        SubCategoria.selectedRowColor = UIColor(named: "AccentColor")!
        SubCategoria.arrowSize = 10
        SubCategoria.arrowColor = .systemIndigo
        Categoria.selectedRowColor = UIColor(named: "AccentColor")!
        Categoria.arrowSize = 10
        Categoria.arrowColor = .systemIndigo
        Categoria.isSearchEnable = false
        SubCategoria.isSearchEnable = false

        MontoField.delegate = self
        //db.OpenConexion()
        TipoSegment.selectedSegmentIndex = 0
    }
    
    func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
                if textField == MontoField{
                let allowingChars = "0123456789."
                let numberOnly = NSCharacterSet.init(charactersIn: allowingChars).inverted
                let validString = string.rangeOfCharacter(from: numberOnly) == nil
                       return validString
        }
        return true
    }
    override func viewWillAppear(_ animated: Bool) {
        getbalance()
        loadCategory()
        Categoria.didSelect{ selectedText, index, id in self.loadsubcategorias(idcategoria: id)
        }

    }
        func getbalance(){
            let currentbalancedefault = defaults.double(forKey: "CurrentBalance")
            currentbalance = currentbalancedefault
            BalanceLbl.text = "$\(currentbalance)"

        }
        func loadsubcategorias(idcategoria : Int){
            SubCategoria.optionIds = []
            SubCategoria.optionArray = []
            let result = categoriasviewmodel.getsubcategoriesbyIdCategory(idCategory: idcategoria)
            if result.Correct == true{
                for subcategories in result.Objects! as! [SubCategorias]{
                    SubCategoria.optionIds?.append(subcategories.IdSubcategorias)
                    SubCategoria.optionArray.append(subcategories.nameSubCategoria)
                    SubCategoria.didSelect{[self](selectedText, index, id) in
                        SubCategoria.selectedRowColor = UIColor(named: "AccentColor")!
                        SubCategoria.arrowSize = 10
                        SubCategoria.arrowColor = .systemIndigo
                        self.SubCategoria.text = String(selectedText)
                        self.idsubcategory = id
                    }
                }
            }
            else{

            }
        }
        func loadCategory(){
            Categoria.optionIds = []
            Categoria.optionArray = []
            let result = categoriasviewmodel.getall()
            if result.Correct == true{
                for categories in result.Objects! as! [categorias]{
                    Categoria.optionIds?.append(categories.IdCategorias)
                    Categoria.optionArray.append(categories.NameCategorias)
                }
                Categoria.didSelect{ [self](selectedText , index ,id) in
                    Categoria.selectedRowColor = UIColor(named: "AccentColor")!
                    Categoria.arrowSize = 10
                    Categoria.arrowColor = .systemIndigo
                    self.Categoria.text = String(selectedText)
                    self.idCategory = id
                }
            }
        }

                                  
        func addExpenses(){
            var result = Result()
            guard let name = IncomeOExpense.text, IncomeOExpense.text != nil, IncomeOExpense.text != "" else{
                IncomeOExpense.backgroundColor = UIColor(named: "red")!
                return
            }
            guard let amount = Double(MontoField.text!), MontoField.text != nil, MontoField.text != "" else{
                MontoField.backgroundColor = UIColor(named: "red")!
                return
            }
            let IdSubcategoria = Int(SubCategoria.text!)
            let idtipobalance = Int()
            let iduser = 1
            let dateFormater: DateFormatter = DateFormatter()
            dateFormater.dateFormat =  "dd/MM/yyyy HH:mm"
            let stringFromDate: String = dateFormater.string(from: self.Date.date) as String
            
                    if currentbalance <= 0, idTipo == 1 ||  amount > currentbalance, idTipo == 1{
                let alert  = UIAlertController(title: nil, message: "No tienes los fondos necesarios ", preferredStyle: .alert)
                        alert.addAction(UIAlertAction(title: "Ok", style: .default))
                        self.present(alert, animated: true)
            }
            else{
                result.Object  = Expense(idValance: 0, Name: name, cantidad: amount, IdTipoBalance: idTipo, IdSubCategorie: idsubcategory , IdUser: iduser, fecha: stringFromDate)
            result = expensesViewModel.AddExpense(expense: result.Object as! Expense)
                if idTipo == 1{
                    currentbalance -= amount
                    BalanceLbl.text = String(currentbalance)
                }
                else{
                    currentbalance += amount
                    BalanceLbl.text = String(currentbalance)

                }
                if result.Correct == true {
                    let alert = UIAlertController(title: "Confirmación", message: "Agregado Correctamente", preferredStyle: .alert)
                    let Aceptar = UIAlertAction(title: "Aceptar", style: .default,handler:
                                                    { action in
                        self.IncomeOExpense.text = ""
                        self.MontoField.text = ""
                        self.Categoria.text = ""
                        self.SubCategoria.text = ""
                        self.TipoSegment.selectedSegmentIndex = 0
                    })
                    
                    alert.addAction(Aceptar)
                    self.present(alert, animated: true)
                    
                }else{
                    let alertError = UIAlertController(title: "Error", message: "No se pudo agregar "+result.ErrorMessage, preferredStyle: .alert)
                    let ok = UIAlertAction(title: "OK", style: .default)
                    alertError.addAction(ok)
                    self.present(alertError, animated: true)
                }
            }
    }
                
        func validacion(){
            addExpenses()
        }
    
    @IBAction func TipoSegment(_ sender: Any) {
        if TipoSegment.selectedSegmentIndex == 0{
            viewWillAppear(true)
            idTipo = 1
        }
        else {
            viewWillAppear(true)
            idTipo = 2
        }
    }
    
    @IBAction func AddBtn(_ sender: UIButton) {
        let amount = Double(MontoField.text!)
            if amount! > currentbalance, idTipo == 1{
                
                let alertError = UIAlertController(title: "Error", message: "No tienes fondos suficientes", preferredStyle: .alert)
                let ok = UIAlertAction(title: "OK", style: .default)
                alertError.addAction(ok)
                self.present(alertError, animated: true)
                MontoField.text = nil
                IncomeOExpense.text = nil
                Categoria.text = nil
                SubCategoria.text = nil
            }
            else{
                addExpenses()
            }
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
