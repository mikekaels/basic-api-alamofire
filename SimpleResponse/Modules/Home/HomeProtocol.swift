//
//  HomeProtocol.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.

public protocol HomeDelegate {
    
}

protocol HomeViewToPresenterProtocol: AnyObject {
    var view: HomePresenterToViewProtocol? { get set }
    var interactor: HomePresenterToInteractorProtocol? { get set }
    var router: HomePresenterToRouterProtocol? { get set }
    
    func goToResponse(response: Inventory, from: HomeVC)
    func fetchData()
}

protocol HomePresenterToRouterProtocol: AnyObject {
    func createModule() -> HomeVC
    func goToResponse(response: Inventory, from: HomeVC)
}

protocol HomePresenterToViewProtocol: AnyObject {
    func didSuccessFetchData(inventory: Inventory)
    func didFailedFetchData(error: CustomError)
}

protocol HomeInteractorToPresenterProtocol: AnyObject {
    func didFetchData(result: Result<Inventory, CustomError>)
}

protocol HomePresenterToInteractorProtocol: AnyObject {
    var presenter: HomeInteractorToPresenterProtocol? { get set }
    func fetchData()

}
