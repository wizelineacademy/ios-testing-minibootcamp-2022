//
//  TweetCell.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 14/06/22.
//

import UIKit

class TweetCell: UITableViewCell {
  let userImageView: UIImageView = create {
    $0.layer.cornerRadius = 25
    $0.clipsToBounds = true
    $0.image = UIImage(.gato)
  }

  let nameLabel: UILabel = create {
    $0.font = UIFont.bold(withSize: .name)
    $0.adjustsFontSizeToFitWidth = true
  }

  let userNameLabel: UILabel = create {
    $0.font = UIFont.bold(withSize: .username)
    $0.textColor = UIColor.systemGray
  }

  let contentLabel: UILabel = create {
    $0.font = UIFont.bold(withSize: .content)
    $0.textColor = UIColor.label
    $0.numberOfLines = 0
  }

  let commentButton: UIButton = create {
    $0.setImage(UIImage(.comment), for: .normal)
    $0.tintColor = .redMain
  }

  let retweetButton: UIButton = create {
    $0.setImage(UIImage(.ret), for: .normal)
    $0.tintColor = .redMain
  }

  let favoriteButton: UIButton = create {
    $0.setImage(UIImage(.fav), for: .normal)
    $0.tintColor = .redMain
  }

  let shareButton: UIButton = create {
    $0.setImage(UIImage(.share), for: .normal)
    $0.tintColor = .redMain
  }

  private let stackView = UIStackView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setTags()
    backgroundColor = .systemBackground
    addSubview(nameLabel)
    addSubview(userNameLabel)
    addSubview(userImageView)
    addSubview(contentLabel)
    addSubview(stackView)

    stackView.addArrangedSubview(commentButton)
    stackView.addArrangedSubview(retweetButton)
    stackView.addArrangedSubview(favoriteButton)
    stackView.addArrangedSubview(shareButton)
  }

  func setTags() {
    stackView.tag = 4
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

}
