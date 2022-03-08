//
//  ResponsePresenter.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.

class ResponsePresenter: ResponseViewToPresenterProtocol {
    weak var view: ResponsePresenterToViewProtocol?
    var router: ResponsePresenterToRouterProtocol?
    var interactor: ResponsePresenterToInteractorProtocol?
    
    func goBack(from: ResponseVC) {
        router?.goBack(from: from)
    }
}

extension ResponsePresenter: ResponseInteractorToPresenterProtocol {

}
