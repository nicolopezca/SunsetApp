//
//  Coordinator.swift
//  Sunset
//
//  Created by Carlos Monfort Gómez on 24/11/21.
//

import UIKit

public protocol Coordinator {
    var navigationController: UINavigationController? { get set }
    func start()
}
