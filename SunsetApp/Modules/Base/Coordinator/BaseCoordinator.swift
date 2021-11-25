//
//  BaseCoordinator.swift
//  Sunset
//
//  Created by Carlos Monfort Gómez on 24/11/21.
//

import UIKit

protocol BaseCoordinatorProtocol: AnyObject {
    func goToHome()
}

final class BaseCoordinator {
    private let dependenciesEngine: DependenciesContainer
    
    public init(dependenciesResolver: DependenciesContainer) {
        self.dependenciesEngine = dependenciesResolver
        self.setupDependencies()
    }
    
    func start() -> BaseViewController? {
        guard let baseViewController = self.dependenciesEngine.resolve(type: BaseViewController.self) else { return nil }
        return baseViewController
    }
}

private extension BaseCoordinator {
    func setupDependencies() {
        self.dependenciesEngine.register(type: BaseCoordinatorProtocol.self, service: self)
        self.dependenciesEngine.register(type: BasePresenterProtocol.self, service: BasePresenter(dependenciesResolver: self.dependenciesEngine))
        if let presenter = self.dependenciesEngine.resolve(type: BasePresenterProtocol.self) {
            let viewController = BaseViewController(presenter: presenter)
            presenter.view = viewController as BaseView
            self.dependenciesEngine.register(type: BaseViewController.self, service: viewController)
        }
    }
}

extension BaseCoordinator: BaseCoordinatorProtocol {
    func goToHome() {
        let homeCoordinator = HomeCoordinator(dependenciesResolver: self.dependenciesEngine)
        homeCoordinator.start()
    }
}
