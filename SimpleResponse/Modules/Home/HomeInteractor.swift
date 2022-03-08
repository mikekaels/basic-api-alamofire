//
//  HomeInteractor.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.

class HomeInteractor: HomePresenterToInteractorProtocol {
    weak var presenter: HomeInteractorToPresenterProtocol?
}

extension HomeInteractor {
    func fetchData() {
        APIManager.shared.fetchAllPost { [weak self] result in
            self?.presenter?.didFetchData(result: result)
        }
    }
}
