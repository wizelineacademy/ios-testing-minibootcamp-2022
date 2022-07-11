//
//  DetailViewController.swift
//  MiniBootcamp
//
//  Created by Juan David Torres on 08/07/22.
//

import UIKit

class DetailViewController: UIViewController {

    var tweetViewModel: TweetViewModel?
    var userViewModel: UserViewModel?
    var userImage: UIImage?
    
    
    let userImageView: UIImageView = create {
        $0.image = UIImage(.gato)
        $0.layer.cornerRadius = 25
        $0.clipsToBounds = true
        $0.contentMode = .scaleAspectFit
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let nameLabel: UILabel = create {
        $0.font = UIFont.bold(withSize: .name)
        $0.adjustsFontSizeToFitWidth = true
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let usernameLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .username)
        $0.textColor = UIColor.systemGray
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let contentLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .content)
        $0.textColor = UIColor.label
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let dateLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .date)
        $0.textColor = UIColor.systemGray
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let likeLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .date)
        $0.textColor = UIColor.systemGray
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let retweetLabel: UILabel = create {
        $0.font = UIFont.normal(withSize: .date)
        $0.textColor = UIColor.systemGray
        $0.numberOfLines = 0
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let buttonComment: UIButton = create {
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(.comment).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .redMain
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let buttonRetweet: UIButton = create {
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(.ret).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .redMain
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let buttonFavorite: UIButton = create {
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(.fav).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .redMain
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let buttonShare: UIButton = create {
        $0.contentMode = .scaleAspectFit
        $0.setImage(UIImage(.share).withRenderingMode(.alwaysTemplate), for: .normal)
        $0.imageView?.tintColor = .redMain
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let iconStackHorizontalView: UIStackView = create {
        $0.axis = .horizontal
        $0.distribution = .equalSpacing
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    let infoStackHorizontalView: UIStackView = create {
        $0.axis = .horizontal
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let cellStackHorizontalView: UIStackView = create {
        $0.axis = .horizontal
        $0.distribution = .fill
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    let cellStackVerticalView: UIStackView = create {
        $0.axis = .vertical
        $0.distribution = .fillProportionally
        $0.spacing = 10
        $0.translatesAutoresizingMaskIntoConstraints = false
    }
    
    override func viewWillAppear(_ animated: Bool) {
        
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    init(_ tweetViewModel: TweetViewModel, _ userViewModel:UserViewModel, _ userImage: UIImage) {
        super.init(nibName: nil, bundle: nil)
        self.tweetViewModel = tweetViewModel
        self.userViewModel = userViewModel
        self.userImage = userImage
        configureUI()
        configureViewModels()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configureUI() {
        view.backgroundColor = .systemBackground
        iconStackHorizontalView.addArrangedSubview(buttonComment)
        iconStackHorizontalView.addArrangedSubview(buttonRetweet)
        iconStackHorizontalView.addArrangedSubview(buttonFavorite)
        iconStackHorizontalView.addArrangedSubview(buttonShare)
        
        infoStackHorizontalView.addArrangedSubview(likeLabel)
        infoStackHorizontalView.addArrangedSubview(retweetLabel)
        
        cellStackVerticalView.addArrangedSubview(nameLabel)
        cellStackVerticalView.addArrangedSubview(usernameLabel)
        cellStackVerticalView.addArrangedSubview(contentLabel)
        cellStackVerticalView.addArrangedSubview(dateLabel)
        cellStackVerticalView.addArrangedSubview(infoStackHorizontalView)
        cellStackVerticalView.addArrangedSubview(iconStackHorizontalView)
                
        cellStackHorizontalView.addArrangedSubview(userImageView)
        cellStackHorizontalView.addArrangedSubview(cellStackVerticalView)
        
        view.addSubview(cellStackVerticalView)
        view.addSubview(userImageView)
        
        configureConstraints()
        configureNavigation()
    }
    
    private func configureNavigation() {
        self.navigationItem.title = "Tweet"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.redMain
        navigationController?.navigationBar.tintColor = UIColor.systemBackground
        navigationController?.navigationBar.backgroundColor = UIColor.redMain
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func configureConstraints() {
        NSLayoutConstraint.activate([
            userImageView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 20),
            userImageView.topAnchor.constraint(equalTo: view.topAnchor,constant: 30),
//            userImageView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -40),
            userImageView.widthAnchor.constraint(equalToConstant: 60),
            

            cellStackVerticalView.topAnchor.constraint(equalTo: view.topAnchor,constant: 20),
            cellStackVerticalView.leadingAnchor.constraint(equalTo: userImageView.trailingAnchor,constant: 10),
            cellStackVerticalView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -20),
//            cellStackVerticalView.bottomAnchor.constraint(equalTo: view.bottomAnchor,constant: -20)
//            cellStackVerticalView.heightAnchor.constraint(equalToConstant: 60)
//            contentView.heightAnchor.constraint(equalToConstant: 100)
                        
        ])
    }
    
    private func configureViewModels() {
        if tweetViewModel != nil && userViewModel != nil {
            contentLabel.text = tweetViewModel?.text
            usernameLabel.text = "@\(userViewModel?.nickname ?? " ")"
            dateLabel.text = tweetViewModel?.creation
            userImageView.image = self.userImage
            nameLabel.text = userViewModel?.name
            likeLabel.text = "\(tweetViewModel?.favs ?? 0) Likes"
            retweetLabel.text = "\(tweetViewModel?.retweets ?? 0) Retweets"
        }
        
        userImageView.image = self.userImage
    }
    

}
