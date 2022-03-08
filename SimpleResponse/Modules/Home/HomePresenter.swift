//
//  HomePresenter.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.

class HomePresenter: HomeViewToPresenterProtocol {
    weak var view: HomePresenterToViewProtocol?
    var router: HomePresenterToRouterProtocol?
    var interactor: HomePresenterToInteractorProtocol?
    
    func goToResponse(response: Inventory, from: HomeVC) {
        router?.goToResponse(response: response, from: from)
    }
    
    func fetchData() {
        interactor?.fetchData()
    }
}

extension HomePresenter: HomeInteractorToPresenterProtocol {
    func didFetchData(result: Result<Inventory, CustomError>) {
        switch result {
        case .success(let inventory):
            view?.didSuccessFetchData(inventory: inventory)
        case .failure(let error):
            view?.didFailedFetchData(error: error)
        }
    }
}
