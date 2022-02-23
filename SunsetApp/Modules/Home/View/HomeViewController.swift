//
//  HomeViewController.swift
//  Sunset
//
//  Created by Carlos Monfort Gómez on 24/11/21.
//

import UIKit

protocol HomeView: AnyObject {
    func kk() 
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
        setupTable()
        presenter.viewDidLoad() 
        presenter.getSunsetInfo { results in
            self.obtainResults(results: results)
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }
    
    func obtainResults(results: Results?) {
        if let sunrise = results?.sunrise {
            self.viewModels.append(SunsetTableViewModel(title: "Salida de sol", hour: sunrise))
        }
        if let sunset = results?.sunset {
            self.viewModels.append(SunsetTableViewModel(title: "Puesta de sol", hour: sunset))
        }
        if let civilTwilightBegin = results?.civilTwilightBegin {
            self.viewModels.append(SunsetTableViewModel(title: "Duración del crepúsculo civil", hour: civilTwilightBegin))
        }
        if let civilTwilightEnd = results?.civilTwilightEnd {
            self.viewModels.append(SunsetTableViewModel(title: "Duración del crepúsculo náutico", hour: civilTwilightEnd))
        }
    }

    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModels.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell: SunsetTableViewCell = self.tableView.dequeueReusableCell(withIdentifier: SunsetTableViewCell.cellReuseIdentifier) as? SunsetTableViewCell else {
            return UITableViewCell()
        }
        cell.setViewModel(viewModels[indexPath.row])
        return cell
    }
}

private extension HomeViewController {
  
    func getHourSun() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH:mm"
        let dateSun = formatter.string(from: date)
        return dateSun
    }
    
    func getHourTwilight() -> String {
        let date = Date()
        let formatter = DateFormatter()
        formatter.dateFormat = "HH"
        let dateTwilight = formatter.string(from: date)
        return dateTwilight
    }
    
    func setupTable() {
        let nib = UINib(nibName: "SunsetTableViewCell", bundle: nil)
        tableView.register(nib, forCellReuseIdentifier: SunsetTableViewCell.cellReuseIdentifier)
        tableView.delegate = self
        tableView.dataSource = self
    }
}

extension HomeViewController: HomeView {
    func kk() {
        print("HomeView-ViewController")
    }
}
