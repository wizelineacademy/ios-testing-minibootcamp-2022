//
//  TweetTableViewCell.swift
//  MiniBootcamp
//
//  Created by Juan David Torres on 14/06/22.
//

import UIKit
import SwiftUI

class TweetTableViewCell: UITableViewCell {

    static let identifier = "TweetTableViewCell"
    var tweetViewModel: TweetViewModel?
    var userViewModel: UserViewModel?
    var userImage: UIImage?
    //View Pragmatically
    let userImageView: UIImageView = create {
        $0.image = UIImage(.gato)
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
    }
    
    let nameLabel: UILabel = create {
        $0.font = UIFont.bold(withSize: .name)
        $0.adjustsFontSizeToFitWidth = true
    }
    
    let usernameLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .username)
        $0.textColor = UIColor.label
        $0.numberOfLines = 1
    }
    
    let contentLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .content)
        $0.textColor = UIColor.label
        $0.numberOfLines = 0
    }
    
    let buttonComment: UIButton = create {
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(.comment).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .redMain
    }
    
    let buttonRetweet: UIButton = create {
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(.ret).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .redMain
    }
    
    let buttonFavorite: UIButton = create {
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(.fav).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .redMain
    }
    
    let buttonShare: UIButton = create {
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(.share).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .redMain
    }
    
    let iconStackHorizontalView: UIStackView = create {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
    }
    
    let cellStackHorizontalView: UIStackView = create {
        $0.axis = .horizontal
        $0.distribution = .fill
    }
    
    let cellStackVerticalView: UIStackView = create {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 10
    }
    
    
//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    
    
    func configure(tweetViewModel: TweetViewModel, userViewModel: UserViewModel, userImage: UIImage) {
        self.tweetViewModel = tweetViewModel
        self.userViewModel = userViewModel
        self.userImage = userImage
        configureViewModels()
        
    }
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        configureUI()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func configureUI() {
        self.backgroundColor = .systemBackground
        
        
        
        configureAutoResizing()
        
        iconStackHorizontalView.addArrangedSubview(buttonComment)
        iconStackHorizontalView.addArrangedSubview(buttonRetweet)
        iconStackHorizontalView.addArrangedSubview(buttonFavorite)
        iconStackHorizontalView.addArrangedSubview(buttonShare)
        
        cellStackVerticalView.addArrangedSubview(nameLabel)
        cellStackVerticalView.addArrangedSubview(usernameLabel)
        cellStackVerticalView.addArrangedSubview(contentLabel)
        cellStackVerticalView.addArrangedSubview(iconStackHorizontalView)
        
        cellStackHorizontalView.addArrangedSubview(userImageView)
        cellStackHorizontalView.addArrangedSubview(cellStackVerticalView)
        contentView.addSubview(cellStackVerticalView)
        contentView.addSubview(userImageView)
        
        configureConstraints()
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 20),
            userImageView.topAnchor.constraint(equalTo: contentView.topAnchor),
            userImageView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -40),
            userImageView.widthAnchor.constraint(equalToConstant: 60),
            

            cellStackVerticalView.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 20),
            cellStackVerticalView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor,constant: 10),
            cellStackVerticalView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -20),
            cellStackVerticalView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: -20)
//            cellStackVerticalView.heightAnchor.constraint(equalToConstant: 60)
//            contentView.heightAnchor.constraint(equalToConstant: 100)
                        
        ])
    }
    
    private func configureViewModels() {
        if tweetViewModel != nil && userViewModel != nil {
            contentLabel.text = tweetViewModel?.text
            usernameLabel.text = userViewModel?.nickname
            
            userImageView.image = self.userImage
            nameLabel.text = userViewModel?.name
        }
    }
    
    private func configureAutoResizing() {
        //Labels
        nameLabel.translatesAutoresizingMaskIntoConstraints = false
        contentLabel.translatesAutoresizingMaskIntoConstraints = false
        usernameLabel.translatesAutoresizingMaskIntoConstraints = false
        
        //Images
        userImageView.translatesAutoresizingMaskIntoConstraints = false
        
        //Buttons
        buttonShare.translatesAutoresizingMaskIntoConstraints = false
        buttonComment.translatesAutoresizingMaskIntoConstraints = false
        buttonFavorite.translatesAutoresizingMaskIntoConstraints = false
        buttonRetweet.translatesAutoresizingMaskIntoConstraints = false
    }

}

