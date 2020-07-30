//
//  BackEndTableViewCell.swift
//  FUNBOX
//
//  Created by Александр Осипов on 28.07.2020.
//  Copyright © 2020 Александр Осипов. All rights reserved.
//

import UIKit

class BackEndTableViewCell: UITableViewCell {
    
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var countLabel: UILabel!
    
    var modelCell: ModelRealm! {
        didSet { configurationCell(modelCell) }
    }
    
    func configurationCell(_ modelCell: ModelRealm) {
        nameLabel.text = modelCell.name
        countLabel.text = modelCell.count.description + " шт."
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
