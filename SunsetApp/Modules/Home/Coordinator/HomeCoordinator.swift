//
//  HomeCoordinator.swift
//  Sunset
//
//  Created by Carlos Monfort Gómez on 24/11/21.
//

import UIKit

protocol HomeCoordinatorProtocol: AnyObject {
    
}

final class HomeCoordinator: Coordinator {
    private let dependenciesEngine: DependenciesContainer
    weak var navigationController: UINavigationController?
    
    public init(dependenciesResolver: DependenciesContainer) {
        self.dependenciesEngine = dependenciesResolver
        self.setupDependencies()
    }
    
    func start() {
        guard let homeViewController = self.dependenciesEngine.resolve(type: HomeViewController.self),
              let topMostViewController = self.getTopMostViewController() else { return }
        let navigationController = UINavigationController(rootViewController: homeViewController)
        navigationController.modalPresentationStyle = .overFullScreen
        self.navigationController = navigationController
        topMostViewController.present(navigationController, animated: true, completion: nil)
    }
}

private extension HomeCoordinator {
    func setupDependencies() {
        self.dependenciesEngine.register(type: HomeCoordinatorProtocol.self, service: self)
        self.dependenciesEngine.register(type: HomeInputInteractorProtocol.self, service: HomeInteractor(dependenciesResolver: self.dependenciesEngine))
        self.dependenciesEngine.register(type: HomePresenterProtocol.self, service: HomePresenter(dependenciesResolver: self.dependenciesEngine))
        if let presenter = self.dependenciesEngine.resolve(type: HomePresenterProtocol.self) {
            let viewController = HomeViewController(presenter: presenter)
            presenter.view = viewController as HomeView
            self.dependenciesEngine.register(type: HomeViewController.self, service: viewController)
            self.dependenciesEngine.register(type: HomeOutputInteractorProtocol.self, service: presenter)
        }
    }
    
    func getTopMostViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter { $0.isKeyWindow }.first
        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}

extension HomeCoordinator: HomeCoordinatorProtocol {
    
}

