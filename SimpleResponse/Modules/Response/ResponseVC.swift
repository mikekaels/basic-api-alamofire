//
//  ResponseVC.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 07/03/22.

import UIKit
import SnapKit

class ResponseVC: UIViewController {
    var presentor: ResponseViewToPresenterProtocol?
    public var delegate: ResponseDelegate?
    
    private let scrollView = UIScrollView()
        .configure { v in
            v.contentOffset.x = 0
        }
    
    private let contentView = UIView()
        .configure { v in
        }
    
    private let btnBack = UIButton()
        .configure { v in
            v.imageView?.contentMode = .scaleAspectFill
            v.setImage(UIImage(systemName: "xmark"), for: .normal)
            v.imageView?.snp.makeConstraints({ make in
                make.top.leading.trailing.bottom.equalTo(v)
            })
            v.addTarget(self, action: #selector(backTapped), for: .touchUpInside)
            v.tintColor = Colors.title
        }
    
    private let ivLogo = UIImageView()
        .configure { v in
            v.contentMode = .scaleAspectFill
        }
    
    private let lblMessage = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 20)
            v.textColor = Colors.title
            v.numberOfLines = 0
            v.textAlignment = .center
        }
    
    private let vBackground = UIView()
        .configure { v in
            v.backgroundColor = Colors.white
            v.layer.cornerRadius = 10
            v.dropShadow()
        }
    
    private let vChip = UIView()
        .configure { v in
            v.snp.makeConstraints { make in
                make.height.equalTo(40)
            }
            v.layer.cornerRadius = 20
            v.layer.borderWidth = 1
            v.layer.borderColor = Colors.title.cgColor
        }
    
    private let lblDataGroup = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 12)
            v.textColor = Colors.title
            v.numberOfLines = 1
            v.text = "Data Group"
            v.textAlignment = .center
        }
    
    private let svItems = UIStackView()
        .configure { v in
            v.spacing = 15
            v.axis = .vertical
            v.distribution = .fill
            v.alignment = .center
            v.contentMode = .scaleToFill
        }
    
    private let ivPersonIcon = UIImageView()
        .configure { v in
            v.image = UIImage(named: "artwork")
            v.snp.makeConstraints { make in
                make.width.height.equalTo(20)
            }
        }
    
    private let lblPersonAmount = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 12)
            v.textColor = Colors.title
            v.numberOfLines = 1
            v.text = "3 Anggota"
            v.textAlignment = .center
        }
    
    private let ivLocationIcon = UIImageView()
        .configure { v in
            v.image = UIImage(named: "location_on")
            v.snp.makeConstraints { make in
                make.width.height.equalTo(20)
            }
        }
    
    private let lblLocation = UILabel()
        .configure { v in
            v.font = UIFont.boldSystemFont(ofSize: 20)
            v.textColor = Colors.title
            v.numberOfLines = 1
            v.text = "Telkom STO Kalibata"
            v.adjustsFontSizeToFitWidth = true
            v.textAlignment = .center
        }
    
    private let lblTotalData = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 12)
            v.textColor = Colors.title
            v.numberOfLines = 1
            v.text = "Total data: 3 / 1000"
            v.adjustsFontSizeToFitWidth = true
            v.textAlignment = .center
        }
    
    private let ivDateIcon = UIImageView()
        .configure { v in
            v.image = UIImage(named: "calendar_today")
            v.snp.makeConstraints { make in
                make.width.height.equalTo(20)
            }
        }
    
    private let lblDate = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 12)
            v.textColor = Colors.title
            v.numberOfLines = 1
            v.text = "31 May 2022"
            v.adjustsFontSizeToFitWidth = true
            v.textAlignment = .center
        }
    
    private let ivTimeIcon = UIImageView()
        .configure { v in
            v.image = UIImage(named: "watch_later")
            v.snp.makeConstraints { make in
                make.width.height.equalTo(20)
            }
        }
    
    private let lblTime = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 12)
            v.textColor = Colors.title
            v.numberOfLines = 1
            v.text = "16:00"
            v.adjustsFontSizeToFitWidth = true
            v.textAlignment = .center
        }
    
    let table = UsersTableViewController(items: [], configure: { (cell: UserTableViewCell, item: ListUser) in
        cell.selectionStyle = .none
        cell.lblUser.text = item.fullname
        cell.viewbackground.backgroundColor = UIColor.colorWith(name: item.colorBackgroud!)
        cell.lblUser.textColor = UIColor.colorWith(name: item.colorText!)
    }) { (item) in
        print(item)
    }.configure { v in
        v.tableView.isScrollEnabled = false
        v.tableView.backgroundColor = .red
    }
    
    //MARK: - Properties
    var tableHeight: CGFloat = 0

    override func viewDidLoad() {
        super.viewDidLoad()
        title = ""
        setupUI()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
        
        self.table.tableView.addObserver(self, forKeyPath: "contentSize", options: .new, context: nil)
        self.table.tableView.reloadData()
    }

    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    @objc func backTapped() {
        presentor?.goBack(from: self)
    }
    
    func configureData(inventory: Inventory) {
        
        DispatchQueue.main.async { [weak self] in
            
            if inventory.isSuccess! {
                self?.ivLogo.image = UIImage(named: "logo_telkom")
                self?.lblMessage.text = ""
            } else {
                self?.ivLogo.image = UIImage(named: "warning")
                self?.lblMessage.text = "Data group yang anda miliki belum sesuai dengan ketentuan"
            }
            
            var users: [ListUser] = [ListUser]()
            users.append(contentsOf: inventory.listUser ?? [])
            
            users.insert(ListUser(fullname: inventory.fullname, colorBackgroud: inventory.colorBackgroud, colorText: inventory.colorText), at: 0)
            
            self?.lblPersonAmount.text = String(users.count) + " " + "Anggota"
            self?.lblLocation.text = inventory.location
            self?.lblTotalData.text = "Total data:" + " " + String(users.count) + " / " + "1000"
            self?.lblDate.text = inventory.time?.formatDateAndTime().0
            self?.lblTime.text = inventory.time?.formatDateAndTime().1
            self?.table.items = users
        }
    }

}

extension ResponseVC: ResponsePresenterToViewProtocol {
    
}

extension ResponseVC {
    func setupUI() {
        view.backgroundColor = Colors.background
        
        view.addSubview(scrollView)
        scrollView.snp.makeConstraints { make in
            make.top.bottom.leading.trailing.equalTo(view)
        }
        
        scrollView.addSubview(contentView)
        contentView.snp.makeConstraints { make in
            make.top.equalTo(scrollView)
            make.width.equalTo(scrollView)
            make.centerX.equalTo(scrollView)
            make.bottom.equalTo(scrollView)
        }
        
        contentView.addSubview(btnBack)
        btnBack.snp.makeConstraints { make in
            make.height.width.equalTo(25)
            make.top.equalTo(contentView.safeAreaLayoutGuide).offset(15)
            make.leading.equalTo(contentView).offset(15)
        }
        
        contentView.addSubview(ivLogo)
        ivLogo.snp.makeConstraints { make in
            make.width.height.equalTo(150)
            make.centerX.equalTo(contentView)
            make.top.equalTo(btnBack.snp_bottomMargin).offset(20)
        }
        
        contentView.addSubview(lblMessage)
        lblMessage.snp.makeConstraints { make in
            make.top.equalTo(ivLogo.snp_bottomMargin).offset(20)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView).inset(30)
        }
        
        contentView.addSubview(vBackground)
        vBackground.snp.makeConstraints { make in
            make.top.equalTo(lblMessage.snp_bottomMargin).offset(20)
            make.centerX.equalTo(contentView)
            make.width.equalTo(contentView).inset(30)
            make.bottom.equalTo(contentView)
        }
        
        vBackground.addSubview(svItems)
        svItems.snp.makeConstraints { make in
            make.top.equalTo(vBackground).offset(10)
            make.leading.trailing.equalTo(vBackground).offset(5).inset(5)
            
        }
        
        let svPeople = UIStackView().configure { v in
            v.spacing = 10
        }
        let svLocation = UIStackView().configure { v in
            v.snp.makeConstraints { make in
                make.leading.trailing.equalTo(v)
            }
        }
        
        let svDateAndTime = UIStackView().configure { v in
            v.spacing = 30
        }
        
        [vChip, svPeople, svLocation, lblTotalData, svDateAndTime].forEach { svItems.addArrangedSubview($0)}
        
        vChip.configure(completion: { v in
            v.addSubview(lblDataGroup)
            lblDataGroup.snp.makeConstraints { make in
                make.centerX.equalTo(v)
                make.centerY.equalTo(v)
            }
        })

        vChip.snp.makeConstraints { make in
            make.centerX.equalTo(vBackground)
            make.top.equalTo(vBackground).offset(20)
            make.width.equalTo(150)
        }
        
        [ivPersonIcon, lblPersonAmount].forEach { svPeople.addArrangedSubview($0)}
        
        [ivLocationIcon, lblLocation].forEach { svLocation.addArrangedSubview($0)}
        
        [UIStackView(arrangedSubviews: [ivDateIcon, lblDate]).configure(completion: { v in
            v.spacing = 10
        }),
         UIStackView(arrangedSubviews: [ivTimeIcon, lblTime]).configure(completion: { v in
            v.spacing = 10
        })]
            .forEach { svDateAndTime.addArrangedSubview($0)}
        
        vBackground.addSubview(table.view)
        table.view.snp.makeConstraints { make in
            make.top.equalTo(svItems.snp_bottomMargin).offset(15)
            make.leading.trailing.equalTo(vBackground).offset(15).inset(15)
            make.bottom.equalTo(vBackground).inset(10)
        }
    }
    
    //MARK: - OBSERVER TABLE HEIGHT
    override func observeValue(forKeyPath keyPath: String?, of object: Any?, change: [NSKeyValueChangeKey : Any]?, context: UnsafeMutableRawPointer?) {
        if keyPath == "contentSize" {
            if let newValue = change?[.newKey] {
                let newSize = newValue as! CGSize
                self.tableHeight = newSize.height + (CGFloat(table.items.count) * CGFloat(6))
                DispatchQueue.main.async {
                    self.table.view.snp.makeConstraints { make in
                        make.height.equalTo(self.tableHeight)
                    }
                }
            }
        }
    }
}
