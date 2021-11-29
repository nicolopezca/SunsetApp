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
        addStyleTitle(Label: titleLabel)
        addStyleSubtitle(Label: hourLabel)
    }
    
    func setViewModel(_ viewModel: SunsetTableViewModel) {
        self.titleLabel.text = viewModel.title
        self.hourLabel.text = viewModel.hour
    }
    func addStyleTitle(Label: UILabel) {
        Label.textAlignment = .center
        Label.font = UIFont.boldSystemFont(ofSize: 24)
    }
    func addStyleSubtitle(Label: UILabel) {
        Label.textAlignment = .center
        Label.font = UIFont.systemFont(ofSize: 16)
    }
    
}
