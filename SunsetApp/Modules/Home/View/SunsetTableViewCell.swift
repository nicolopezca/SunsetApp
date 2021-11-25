//
//  SunsetTableViewCell.swift
//  SunsetApp
//
//  Created by Nicolás López Cano on 25/11/21.
//
import UIKit

class SunsetTableViewCell: UITableViewCell {
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var hourLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setViewModel(_ viewModel: SunsetTableViewModel) {
        self.titleLabel.text = viewModel.title
        self.hourLabel.text = viewModel.hour
    }

    struct SunsetTableViewModel {
        let title: String
        let hour: String
    }
}
