//
//  ResponseProtocol.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.

public protocol ResponseDelegate {
    
}

protocol ResponseViewToPresenterProtocol: AnyObject {
    var view: ResponsePresenterToViewProtocol? { get set }
    var interactor: ResponsePresenterToInteractorProtocol? { get set }
    var router: ResponsePresenterToRouterProtocol? { get set }
    
    func goBack(from: ResponseVC)
}

protocol ResponsePresenterToRouterProtocol: AnyObject {
    func createModule() -> ResponseVC
    func goBack(from: ResponseVC)
}

protocol ResponsePresenterToViewProtocol: AnyObject {

}

protocol ResponseInteractorToPresenterProtocol: AnyObject {

}

protocol ResponsePresenterToInteractorProtocol: AnyObject {
    var presenter: ResponseInteractorToPresenterProtocol? { get set }

}
