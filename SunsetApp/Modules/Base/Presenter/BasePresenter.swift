//
//  BasePresenter.swift
//  Sunset
//
//  Created by Carlos Monfort Gómez on 24/11/21.
//

import Foundation

protocol BasePresenterProtocol: AnyObject {
    var view: BaseView? { get set }
    func viewDidLoad()
}

final class BasePresenter {
    weak var view: BaseView?
    let dependenciesResolver: DependenciesContainer
    
    init(dependenciesResolver: DependenciesContainer) {
        self.dependenciesResolver = dependenciesResolver
    }
    
    var coordinator: BaseCoordinatorProtocol? {
        return self.dependenciesResolver.resolve(type: BaseCoordinatorProtocol.self)
    }
}

extension BasePresenter: BasePresenterProtocol {
    func viewDidLoad() {
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0) {
            self.coordinator?.goToHome()
        }
    }
}
