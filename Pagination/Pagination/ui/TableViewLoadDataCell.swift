//
//  TableViewLoadDataCell.swift
//  Pagination
//
//  Created by cemal tüysüz on 30.03.2022.
//

import UIKit

class TableViewLoadDataCell: UITableViewCell {

    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
