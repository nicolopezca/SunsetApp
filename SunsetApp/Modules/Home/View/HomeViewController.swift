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
        setupTable()
        getSunsetInfo { results in
            if let sunrise = results?.sunrise {
                self.viewModels.append(SunsetTableViewModel(title: "sunrise", hour: sunrise))
            }
            if let sunset = results?.sunset {
                self.viewModels.append(SunsetTableViewModel(title: "sunset", hour: sunset))
            }
            if let civil_twilight_begin = results?.civil_twilight_begin {
                self.viewModels.append(SunsetTableViewModel(title: "civil_twilight_begin", hour: civil_twilight_begin))
            }
            if let civil_twilight_end = results?.civil_twilight_end {
                self.viewModels.append(SunsetTableViewModel(title: "civil_twilight_end", hour: civil_twilight_end))
            }
            
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        }
    }

    func getSunsetInfo(completion: @escaping (((Results?) -> Void))) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        let url = URL(string: "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=today")
        urlSession.dataTask(with: url!) { data, response, error in
            if error != nil || data == nil {
                print("Client error!")
                return
            }
            
            guard let response = response as? HTTPURLResponse, (200...299).contains(response.statusCode) else {
                print("Server error!")
                return
            }
            
            guard let mime = response.mimeType, mime == "application/json" else {
                print("Wrong MIME type!")
                return
            }
            
            if let jsonPetitions = try? JSONDecoder().decode(SunsetReponse.self, from: data!) {
                completion(jsonPetitions.results)
            }
        }.resume()
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
    
}
