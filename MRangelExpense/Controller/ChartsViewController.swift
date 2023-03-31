//
//  ChartsViewController.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 30/03/23.
//

import UIKit

class ChartsViewController: UIViewController {
    
    
    @IBOutlet weak var ChartsTableView: UITableView!
    
    var chartViewModel = ChartViewModel()
    var balance = [CurentBalance]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        ChartsTableView.dataSource = self
        ChartsTableView.delegate = self
        view.addSubview(ChartsTableView)
        
        ChartsTableView.register(UINib(nibName: "ChartsTableViewCell", bundle: .main), forCellReuseIdentifier: "ChartCell")

        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        loadData()
    }
    
    func loadData(){
        var result = Result()
        result = chartViewModel.getCurrentBalance()
        if result.Correct == true {
            balance = result.Objects as! [CurentBalance]
            ChartsTableView.reloadData()
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
extension ChartsViewController : UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return balance.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ChartCell", for: indexPath) as! ChartsTableViewCell
        
        cell.CategoriaLbl.text = String(balance[indexPath.row].SubCategoria)
        cell.Income = balance[indexPath.row].Income
        cell.expense = balance[indexPath.row].Expense
        
        return cell
    }
    
    
}









