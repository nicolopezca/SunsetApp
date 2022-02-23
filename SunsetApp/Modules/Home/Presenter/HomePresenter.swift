//
//  HomePresenter.swift
//  Sunset
//
//  Created by Carlos Monfort Gómez on 24/11/21.
//

import Foundation

protocol HomePresenterProtocol: AnyObject {
    var view: HomeView? { get set }
    func viewDidLoad()
    func getSunsetInfo(completion: @escaping (((Results?) -> Void)))
}

final class HomePresenter {
    weak var view: HomeView?
    private let dependenciesResolver: DependenciesContainer
    var viewModels: [SunsetTableViewModel] = []
    
    init(dependenciesResolver: DependenciesContainer) {
        self.dependenciesResolver = dependenciesResolver
    }
    
    private var interactor: HomeInputInteractorProtocol? {
        self.dependenciesResolver.resolve(type: HomeInputInteractorProtocol.self)
    }
    
    private var coordinator: HomeCoordinatorProtocol? {
        self.dependenciesResolver.resolve(type: HomeCoordinatorProtocol.self)
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

    func getSunsetInfo(completion: @escaping (((Results?) -> Void))) {
        let urlSessionConfiguration = URLSessionConfiguration.default
        let urlSession = URLSession(configuration: urlSessionConfiguration)
        guard let url = URL(string: "https://api.sunrise-sunset.org/json?lat=36.7201600&lng=-4.4203400&date=today") else {
            completion(nil)
            return
        }
        urlSession.dataTask(with: url) { data, response, error in
            self.handleSunsetResponse(data: data, response: response, error: error, completion: completion)
        }.resume()
    }
    
    func handleSunsetResponse(data: Data?, response: URLResponse?, error: Error?, completion: @escaping (((Results?) -> Void))) {
        guard let data = data,
              let response = response as? HTTPURLResponse,
              (200...299).contains(response.statusCode),
              let sunsetResponse = try? JSONDecoder().decode(SunsetReponse.self, from: data)
        else {
            completion(nil)
            return
        }
        completion(sunsetResponse.results)
    }
}



extension HomePresenter: HomePresenterProtocol {
    func viewDidLoad() {
        print("ViewDidLoad-Presenter")
        view?.kk()
    }
}

extension HomePresenter: HomeOutputInteractorProtocol {
    
}

