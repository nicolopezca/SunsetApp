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
    static let cellReuseIdentifier = "SunsetTableViewCell"

    
    override func awakeFromNib() {
        super.awakeFromNib()
        setStyleTitle()
        setStyleHour()
    }
    
    func setViewModel(_ viewModel: SunsetTableViewModel) {
        self.titleLabel.text = viewModel.title
        self.hourLabel.text = viewModel.hour
    }
    
    private func setStyleTitle() {
        titleLabel.textAlignment = .center
        titleLabel.font = UIFont.boldSystemFont(ofSize: 24)
    }
    
    private func setStyleHour() {
        hourLabel.textAlignment = .center
        hourLabel.font = UIFont.systemFont(ofSize: 16)
    }
}
