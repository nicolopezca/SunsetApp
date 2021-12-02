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
        createMockViewModels()
        
        
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
            do {
               let json = try JSONSerialization.jsonObject(with: data!, options: [])
                print(json)
            } catch {
                print("JSON error: \(error.localizedDescription)")
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
    func createMockViewModels() {
        let dateSun = getHourSun()
        let dateTwilight = getHourTwilight()
        let mockViewModel1 = SunsetTableViewModel(title: "Salida de sol", hour: dateSun)
        let mockViewModel2 = SunsetTableViewModel(title: "Puesta de sol", hour: dateSun)
        let mockViewModel3 = SunsetTableViewModel(title: "Duración del crepúsculo civil", hour: "\(dateTwilight) horas")
        let mockViewModel4 = SunsetTableViewModel(title: "Duración del crepúsculo náutico", hour: "\(dateTwilight) horas")
        viewModels.append(mockViewModel1)
        viewModels.append(mockViewModel2)
        viewModels.append(mockViewModel3)
        viewModels.append(mockViewModel4)
    }
    
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
