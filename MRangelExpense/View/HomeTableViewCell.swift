//
//  HomeTableViewCell.swift
//  MRangelExpense
//
//  Created by MacBookMBA5 on 28/03/23.
//

import UIKit

class HomeTableViewCell: UITableViewCell {

    @IBOutlet weak var IconoImagen: UIImageView!
    @IBOutlet weak var nombreLbl: UILabel!
    @IBOutlet weak var fechaLbl: UILabel!
    @IBOutlet weak var costoLbl: UILabel!
    @IBOutlet weak var ViewCell: UIView!
    @IBOutlet weak var ViewSpace: UIView!
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        
        ViewSpace.backgroundColor = nil
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
