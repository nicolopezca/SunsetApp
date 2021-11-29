//
//  HomeViewController.swift
//  Sunset
//
//  Created by Carlos Monfort Gómez on 24/11/21.
//

import UIKit

protocol HomeView: AnyObject {
    
}

final class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    var presenter: HomePresenterProtocol
    var viewModels: [SunsetTableViewModel] = []
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "HomeViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    @IBOutlet private weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let nib = UINib(nibName: "SunsetTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SunsetTableViewCell.cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
        createMockViewModels()
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SunsetTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: SunsetTableViewCell.cellReuseIdentifier) as! SunsetTableViewCell
        cell.setViewModel(viewModels[indexPath.row])
        return cell
    }
}

private extension HomeViewController {
    func createMockViewModels() {
        let date = Date()
        let mockViewModel1 = SunsetTableViewModel(title: "titulo1", hour: "hora1")
        let mockViewModel2 = SunsetTableViewModel(title: "titulo2", hour: "hora2")
        let mockViewModel3 = SunsetTableViewModel(title: "titulo3", hour: "hora3")
        let mockViewModel4 = SunsetTableViewModel(title: "titulo4", hour: "hora4")
        viewModels.append(mockViewModel1)
        viewModels.append(mockViewModel2)
        viewModels.append(mockViewModel3)
        viewModels.append(mockViewModel4)
    }
}

extension HomeViewController: HomeView {
    
}
