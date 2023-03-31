//
//  MovimientosViewController.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 29/03/23.
//

import UIKit

class MovimientosViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
    
    @IBOutlet weak var SubCategoriaLbl: UILabel!
    @IBOutlet weak var MovimientosTableView: UITableView!
    
    var idSubcategory = 0
    var subcategorianame = ""
    var expensesviewmodel = ExpensesViewModel()
    var expenses = [Expense]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        MovimientosTableView.delegate = self
        MovimientosTableView.dataSource = self
        MovimientosTableView.backgroundColor = nil
        
        view.addSubview(MovimientosTableView)
                MovimientosTableView.register(UINib(nibName: "HomeTableViewCell", bundle: .main), forCellReuseIdentifier: "HomeCell")
        loadData()
        SubCategoriaLbl.text = subcategorianame

        // Do any additional setup after loading the view.
    }
    
    func loadData(){
        var result = expensesviewmodel.GetSubcategory(idSubcategory: idSubcategory)
            if result.Correct == true{
                expenses = result.Objects as! [Expense]
                MovimientosTableView.reloadData()
            }
            
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            expenses.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: "HomeCell", for: indexPath as! IndexPath) as! HomeTableViewCell
            cell.layer.cornerRadius = 16
            cell.ViewCell.layer.cornerRadius = 16
//            cell.StackView.layer.cornerRadius = 15
//            cell.costo.layer.cornerRadius = 15
//            cell.StackView.layer.shadowColor = UIColor.black.cgColor
//            cell.StackView.layer.shadowOpacity = 0.4
//            cell.StackView.layer.shadowOffset = .zero
//            cell.StackView.layer.shadowRadius = 0.4
            cell.fechaLbl.text = expenses[indexPath.row].fecha
            //print(expenses[indexPath.row].fecha)
            cell.nombreLbl.text = expenses[indexPath.row].Name
            if expenses[indexPath.row].IdTipoBalance == 1{
                cell.costoLbl.textColor = .red
                cell.costoLbl.text = "-\(expenses[indexPath.row].cantidad!)"
            }
            else if expenses[indexPath.row].IdTipoBalance == 2{
                cell.costoLbl.text = "+\(expenses[indexPath.row].cantidad!)"
                cell.costoLbl.textColor = .green
            }

            return cell
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
