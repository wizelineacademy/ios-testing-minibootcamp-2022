//
//  TweetCell.swift
//  MiniBootcamp
//
//  Created by Abner Castro on 14/06/22.
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
        $0.text = "Holaaaa"
        $0.font = UIFont.bold(withSize: .name)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let usernameLabel: UILabel = create {
        $0.text = "@hellowizeline_"
        $0.font = UIFont.bold(withSize: .username)
        $0.textColor = UIColor.systemGray
    }
    
    let contentLabel: UILabel = create {
        $0.text = "This is a test on showing about how a tweet content can be displayed on the TweetCell ✌🏼😎"
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
        addConstraints()
    }
    
    private func addConstraints() {
        userImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil, padding: .init(top: 12, left: 12, bottom: 0, right: 0), size: .init(width: 50, height: 50))
        nameLabel.anchor(top: userImageView.topAnchor, leading: userImageView.trailingAnchor, trailing: trailingAnchor, bottom: nil, padding: .init(top: 0, left: 4, bottom: 0, right: 12), size: .init(width: 0, height: 20))
        usernameLabel.anchor(top: nameLabel.bottomAnchor, leading: nameLabel.leadingAnchor, trailing: nameLabel.trailingAnchor, bottom: nil, padding: .init(top: 0, left: 0, bottom: 0, right: 0), size: .init(width: 0, height: 20))
        contentLabel.anchor(top: usernameLabel.bottomAnchor, leading: usernameLabel.leadingAnchor, trailing: usernameLabel.trailingAnchor, bottom: bottomAnchor, padding: .init(top: 16, left: 0, bottom: 16, right: 0))
    }
    
    
}
