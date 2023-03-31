//
//  ViewController.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 28/03/23.
//

import UIKit

class ViewController: UIViewController, UITableViewDelegate, UITableViewDataSource{
    
    @IBOutlet weak var BalanceLbl: UILabel!
    @IBOutlet weak var GetDateLbl: UILabel!
    @IBOutlet weak var IncomeLbl: UILabel!
    @IBOutlet weak var ExpenseLbl: UILabel!
    @IBOutlet weak var HomeTableView: UITableView!
    
    var Expenses = 0.0
    var Income = 0.0
    var Currentbalance = 0.0
    let expensesViewModel = ExpensesViewModel()
    var expense = [Expense]()
    let defaults = UserDefaults.standard
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        HomeTableView.delegate = self
        HomeTableView.dataSource = self
        HomeTableView.backgroundColor = nil
        HomeTableView.layer.cornerRadius = 16
        view.addSubview(HomeTableView)
        // Do any additional setup after loading the view.
        
        HomeTableView.register(UINib(nibName: "HomeTableViewCell", bundle: .main), forCellReuseIdentifier: "HomeCell")
        loadData()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        loadData()
        getDate()
        actualizarlbls()
    }
    
    func getDate(){
        let date = Date()
        let dateformatter = DateFormatter()
        dateformatter.dateFormat = "MMMM yyyy"
        let horamodificacion = dateformatter.string(from: date)
        GetDateLbl.text = horamodificacion.capitalized
    }
        
    func actualizarlbls(){
        Expenses = 0.0
        Income = 0.0
        Currentbalance = 0.0
        for suma in expense{
            if suma.IdTipoBalance == 1{
                Expenses +=  suma.cantidad!
            }
            else{
                Income += suma.cantidad!
            }
        }
            ExpenseLbl.text = "$\(Expenses)"
            IncomeLbl.text = "$\(Income)"
            Currentbalance = Income - Expenses
            BalanceLbl.text = "$\(Currentbalance)"
            defaults.set(Currentbalance, forKey: "CurrentBalance")
            //print(defaults)
    }
    
    func loadData(){
        let result = expensesViewModel.GetAll()
        if result.Correct{
                
            expense = result.Objects! as! [Expense]
            HomeTableView.reloadData()
        }
        else{
            let alertError = UIAlertController(title: "Error", message: "Error al mostrar las tareas "+result.ErrorMessage, preferredStyle: .alert)
            let ok = UIAlertAction(title: "OK", style: .default)
            alertError.addAction(ok)
            self.present(alertError, animated: false)
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return expense.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath) as! HomeTableViewCell
        cell.layer.cornerRadius = 16
        cell.ViewCell.layer.cornerRadius = 16
        cell.ViewSpace.layer.cornerRadius = 16
        cell.nombreLbl.text = expense[indexPath.row].Name
        cell.fechaLbl.text = expense[indexPath.row].fecha
        if expense[indexPath.row].IdTipoBalance == 1{
            cell.costoLbl.textColor = .red
            cell.costoLbl.text = "-\(expense[indexPath.row].cantidad!)"
        }
        else if expense[indexPath.row].IdTipoBalance == 2{
            cell.costoLbl.text = "+\(expense[indexPath.row].cantidad!)"
            cell.costoLbl.textColor = .green
            //print (Income)
        }
        cell.ViewSpace.backgroundColor = nil
        return cell
    }
}
//extension ViewController {
    
    
    
    
//}

