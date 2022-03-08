//
//  HomeRouter.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.

import UIKit

public class HomeRouter: HomePresenterToRouterProtocol{
    public static let shared = HomeRouter()
    
    func initialize() -> HomeVC {
        return createModule()
    }
    
    func createModule() -> HomeVC {
        let view = HomeVC()
        
        let presenter: HomeViewToPresenterProtocol & HomeInteractorToPresenterProtocol = HomePresenter()
        
        let interactor: HomePresenterToInteractorProtocol = HomeInteractor()
        
        let router: HomePresenterToRouterProtocol = HomeRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func goToResponse(response: Inventory, from: HomeVC) {
        let vc = ResponseRouter().createModule()
        vc.configureData(inventory: response)
        
        vc.modalTransitionStyle = .crossDissolve
        
        vc.modalPresentationStyle = .fullScreen
        
        from.present(vc, animated: true, completion: nil)
//        from.navigationController?.pushViewController(vc, animated: true)
    }
}
