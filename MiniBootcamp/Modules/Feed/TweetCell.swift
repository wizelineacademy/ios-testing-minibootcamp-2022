//
//  TableViewCell.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 14/06/22.
//

import UIKit

final class TweetCell: UITableViewCell {
    
    let userImageView: UIImageView = create {
        $0.image = UIImage(.gato)
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        
    }
    
    lazy var mainContainerStackView: UIStackView =  {
        let stackView = UIStackView(arrangedSubviews: [labelContainerStackView, optionsContainerStackView])
        stackView.axis = .vertical
        stackView.spacing = 10
        return stackView
    }()
    
    let nameLabel: UILabel = create {
        $0.font = UIFont.bold(withSize: .name)
        $0.text = "WizeBoot"
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let userLabel: UILabel = create {
        $0.font = UIFont.bold(withSize: .username)
        $0.text = "@wizeBootService"
        $0.textColor = UIColor.systemGray
    }
    
    let contentLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .content)
        $0.textColor = UIColor.label
        $0.text = "Welcome gadkfgnsdkjgnskdjfffffgnksj"
        $0.numberOfLines = 0
    }
    
    lazy var labelContainerStackView: UIStackView =  {
        let stackView = UIStackView(arrangedSubviews: [nameLabel, userLabel, contentLabel])
        stackView.axis = .vertical
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    lazy var optionsContainerStackView: UIStackView =  {
        let stackView = UIStackView(arrangedSubviews: [commentButton, retweetButton, favoriteButton, shareButton])
        stackView.distribution = .equalSpacing
        return stackView
    }()
    
    let commentButton: UIButton = create {
        $0.setImage(UIImage(.comment).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .redMain
    }
    
    let retweetButton: UIButton = create {
        $0.setImage(UIImage(.ret).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .redMain
    }
    
    let favoriteButton: UIButton = create {
        $0.setImage(UIImage(.fav).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .redMain
    }
    
    let shareButton: UIButton = create {
        $0.setImage(UIImage(.share).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.tintColor = .redMain
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configUI()

        
    }
    
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    private func configUI() {
        backgroundColor = .systemBackground
        addSubview(userImageView)
        userImageView.anchor(top: topAnchor, leading: leadingAnchor, trailing: nil, bottom: nil, padding: UIEdgeInsets(top: 10, left: 10, bottom: 0, right: 0), size: CGSize(width: 60, height: 60))
        
        addSubview(mainContainerStackView)
        mainContainerStackView.anchor(top: topAnchor, leading: userImageView.trailingAnchor, trailing: trailingAnchor, bottom: bottomAnchor, padding: UIEdgeInsets(top: 10, left: 15, bottom: 10, right: 15))
    }
    
    func configData(viewModel: TweetViewModel) {
        nameLabel.text = viewModel.name
        userLabel.text = viewModel.userName
        contentLabel.text = viewModel.content
    }
    
    func configImage(userImage: UIImage) {
        userImageView.image = userImage
    }
}


