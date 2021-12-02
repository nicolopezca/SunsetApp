//
//  HomeInteractor.swift
//  Sunset
//
//  Created by Carlos Monfort Gómez on 24/11/21.
//

import Foundation

protocol HomeInputInteractorProtocol: AnyObject {
    
}

protocol HomeOutputInteractorProtocol: AnyObject {
    
}

final class HomeInteractor {
    private let dependenciesResolver: DependenciesContainer
    
    init(dependenciesResolver: DependenciesContainer) {
        self.dependenciesResolver = dependenciesResolver
    }
    
    private var presenter: HomeOutputInteractorProtocol? {
        return self.dependenciesResolver.resolve(type: HomeOutputInteractorProtocol.self)
    }
}

extension HomeInteractor: HomeInputInteractorProtocol {
    
}

private extension HomeInteractor {
    
}


