//
//  UserTableViewCell.swift
//  SimpleResponse
//
//  Created by Santo Michael Sihombing on 08/03/22.
//

import UIKit
import SnapKit

class UserTableViewCell: UITableViewCell {
    
    let viewbackground = UIView()
        .configure { v in
            v.backgroundColor = .systemBrown
            v.layer.cornerRadius = 20
            v.layer.masksToBounds = true
        }
    
    let lblUser = UILabel()
        .configure { v in
            v.font = UIFont.systemFont(ofSize: 12)
            v.textColor = Colors.white
            v.numberOfLines = 1
            v.text = "Main User"
            v.adjustsFontSizeToFitWidth = true
            v.textAlignment = .center
        }

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        setupUI()
        // Configure the view for the selected state
    }

}

extension UserTableViewCell {
    func setupUI() {
        contentView.backgroundColor = .clear
        contentView.addSubview(viewbackground)
        viewbackground.snp.makeConstraints { make in
            make.leading.trailing.equalTo(contentView).offset(20).inset(20)
            make.top.bottom.equalTo(contentView).offset(5).inset(5)
        }
        
        viewbackground.addSubview(lblUser)
        lblUser.snp.makeConstraints { make in
            make.centerX.centerY.equalTo(viewbackground)
        }
    }
}
