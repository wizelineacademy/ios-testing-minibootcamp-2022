//
//  TweetCell.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 14/06/22.
//

import UIKit

class TweetCell: UITableViewCell {
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    let userImageView: UIImageView = create {
        $0.image = UIImage(.gato)
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
    }
    
    let nameLabel: UILabel = create {
        $0.font = UIFont.bold(withSize: .name)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let usernameLabel: UILabel = create {
        $0.font = UIFont.bold(withSize: .username)
        $0.textColor = UIColor.systemGray
    }
    
    let contentLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .content)
        $0.textColor = UIColor.label
        $0.numberOfLines = 0
    }

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        backgroundColor = .systemBackground
        addSubview(nameLabel)
        addSubview(usernameLabel)
        addSubview(userImageView)
        addSubview(contentLabel)
    }
    
    
    
}
