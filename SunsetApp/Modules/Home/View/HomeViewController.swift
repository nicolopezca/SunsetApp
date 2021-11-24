//
//  HomeViewController.swift
//  Sunset
//
//  Created by Carlos Monfort Gómez on 24/11/21.
//

import UIKit

protocol HomeView: AnyObject {
    
}

final class HomeViewController: UIViewController {
    var presenter: HomePresenterProtocol
    
    init(presenter: HomePresenterProtocol) {
        self.presenter = presenter
        super.init(nibName: "HomeViewController", bundle: .main)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
}

private extension HomeViewController {
    
}

extension HomeViewController: HomeView {
    
}
