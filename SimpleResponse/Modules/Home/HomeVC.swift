//
//  HomeVC.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.

import UIKit
import SnapKit

class HomeVC: UIViewController {
    var presentor: HomeViewToPresenterProtocol?
    public var delegate: HomeDelegate?
    
    private let btnResponse = LoadingButton()
        .configure { v in
            v.setTitle("Fetch", for: .normal)
            v.addTarget(self, action: #selector(responseBtnTapped), for: .touchUpInside)
            v.setTitleColor(Colors.white, for: .normal)
            v.backgroundColor = Colors.accent
            v.layer.cornerRadius = 25
            v.snp.makeConstraints { make in
                make.width.equalTo(100)
                make.height.equalTo(50)
            }
        }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        
        setupUI()
    }
    
    @objc func responseBtnTapped() {
        fetchData()
    }
    
    func fetchData() {
        btnResponse.showLoading()
        presentor?.fetchData()
    }

}

extension HomeVC: HomePresenterToViewProtocol {
    func didSuccessFetchData(inventory: Inventory) {
        btnResponse.hideLoading()
        presentor?.goToResponse(response: inventory, from: self)
    }
    
    func didFailedFetchData(error: CustomError) {
        if error == .noInternetConnection {
            btnResponse.hideLoading()
            self.noInternetConnection(true) { [weak self] in
                self?.fetchData()
            }
        }
    }
    
    
}

extension HomeVC {
    func setupUI() {
        view.backgroundColor = Colors.background
        view.addSubview(btnResponse)
        btnResponse.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(view)
        }
    }
}
