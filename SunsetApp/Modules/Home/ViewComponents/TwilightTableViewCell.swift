//
//  TwilightTableViewCell.swift
//  SunsetApp
//
//  Created by Nicolás López Cano on 25/11/21.
//

import UIKit

class TwilightTableViewCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        titleLabel.textAlignment = .center
        hourLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
        hourLabel.font = UIFont.systemFont(ofSize: 16)
    }
    
    func setViewModel(_ viewModel: SunsetTableViewModel) {
        self.titleLabel.text = viewModel.title
        self.hourLabel.text = viewModel.hour
    }
    
}
