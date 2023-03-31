//
//  ChartsTableViewCell.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 30/03/23.
//

import UIKit
import Charts

class ChartsTableViewCell: UITableViewCell {

    
    @IBOutlet weak var CategoriaLbl: UILabel!
    @IBOutlet weak var ChartViews: PieChartView!
    
    
    
    var expense = 0
    var Income = 0
    var valoresData = [PieChartDataEntry]()
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        loadData()
        // Configure the view for the selected state
    }
    
    func loadData(){
        
        DispatchQueue.main.async { [self] in
            var expenseChart = PieChartDataEntry(value: Double(expense))
            var incomeChart = PieChartDataEntry(value: Double(Income))
            
            ChartViews.chartDescription.text = ""
            valoresData = [expenseChart, incomeChart]
            expenseChart.label = "Expense"
            incomeChart.label = "Income"
            let chartSet = PieChartDataSet(entries: valoresData, label: "")
            let chartData = PieChartData(dataSet: chartSet)
            let colors = [UIColor(named: "Expense"), UIColor(named: "Income")]
            
            chartSet.colors = colors as! [NSUIColor]
            ChartViews.data = chartData
            
        }
    }
}



















