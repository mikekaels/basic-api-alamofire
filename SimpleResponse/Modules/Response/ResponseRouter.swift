//
//  ResponseRouter.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.

import UIKit

public class ResponseRouter: ResponsePresenterToRouterProtocol{
    public static let shared = ResponseRouter()
    
    func initialize() -> ResponseVC {
        return createModule()
    }
    
    func createModule() -> ResponseVC {
        let view = ResponseVC()
        
        let presenter: ResponseViewToPresenterProtocol & ResponseInteractorToPresenterProtocol = ResponsePresenter()
        
        let interactor: ResponsePresenterToInteractorProtocol = ResponseInteractor()
        
        let router: ResponsePresenterToRouterProtocol = ResponseRouter()
        
        view.presentor = presenter
        presenter.view = view
        presenter.router = router
        presenter.interactor = interactor
        
        interactor.presenter = presenter
        
        return view
    }
    
    func goBack(from: ResponseVC) {
        from.dismiss(animated: true, completion: nil)
    }
}
