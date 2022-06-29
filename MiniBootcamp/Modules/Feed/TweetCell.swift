//
//  TweetCell.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 14/06/22.
//

import UIKit

class TweetCell: UITableViewCell {
  @UsesLayout var userImageView: UIImageView = create {
    $0.layer.cornerRadius = 25
    $0.clipsToBounds = true
    $0.image = UIImage(.gato).withRenderingMode(.alwaysTemplate)
    $0.tintColor = .redMain
  }

  @UsesLayout var nameLabel: UILabel = create {
    $0.font = UIFont.bold(withSize: .name)
    $0.adjustsFontSizeToFitWidth = true
  }

  @UsesLayout var userNameLabel: UILabel = create {
    $0.font = UIFont.bold(withSize: .username)
    $0.textColor = UIColor.systemGray
  }

  @UsesLayout var contentLabel: UILabel = create {
    $0.font = UIFont.normal(withSize: .content)
    $0.textColor = UIColor.label
    $0.numberOfLines = 0
  }

  @UsesLayout var commentButton: UIButton = create {
    $0.setImage(UIImage(.comment).withRenderingMode(.alwaysTemplate), for: .normal)
    $0.tintColor = .redMain
  }

  @UsesLayout var retweetButton: UIButton = create {
    $0.setImage(UIImage(.ret).withRenderingMode(.alwaysTemplate), for: .normal)
    $0.tintColor = .redMain
  }

  @UsesLayout var favoriteButton: UIButton = create {
    $0.setImage(UIImage(.fav).withRenderingMode(.alwaysTemplate), for: .normal)
    $0.tintColor = .redMain
  }

  @UsesLayout var shareButton: UIButton = create {
    $0.setImage(UIImage(.share).withRenderingMode(.alwaysTemplate), for: .normal)
    $0.tintColor = .redMain
  }

  private let stackView = UIStackView()

  override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
    super.init(style: style, reuseIdentifier: reuseIdentifier)
    setupView()
  }

  required init?(coder: NSCoder) {
    fatalError("init(coder:) has not been implemented")
  }

  private func setTags() {
    stackView.tag = 4
  }

  // MARK: - Private methods
  private func setupView() {
    backgroundColor = .white
    addSubviews()
    userImageViewConstraints()
    nameLabelConstraints()
    userNameLabelConstraints()
    contentLabelConstraints()
    stackViewConstraints()
  }

  private func addSubviews() {
    addSubview(userImageView)
    addSubview(nameLabel)
    addSubview(userNameLabel)
    addSubview(contentLabel)
    addSubview(stackView)

    setTags()
    stackView.addArrangedSubview(commentButton)
    stackView.addArrangedSubview(retweetButton)
    stackView.addArrangedSubview(favoriteButton)
    stackView.addArrangedSubview(shareButton)
  }

  private func userImageViewConstraints() {
    userImageView.anchor(top: nil, leading: leadingAnchor, trailing: nil, bottom: nil,
                         padding: UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 0))
    userImageView.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor).isActive = true
    userImageView.heightAnchor.constraint(equalToConstant: 48).isActive = true
    userImageView.widthAnchor.constraint(equalToConstant: 48).isActive = true
  }

  private func nameLabelConstraints() {
    nameLabel.text = "WizeBot"
    nameLabel.textColor = .black
    nameLabel.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
    nameLabel.anchor(top: topAnchor, leading: userImageView.trailingAnchor, trailing: trailingAnchor, bottom: nil,
                     padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
  }

  private func userNameLabelConstraints() {
    userNameLabel.text = "@wizeservicebot"
    userNameLabel.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
    userNameLabel.anchor(top: nameLabel.bottomAnchor, leading: userImageView.trailingAnchor, trailing: trailingAnchor, bottom: nil,
                         padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))

  }

  private func contentLabelConstraints() {
    contentLabel.textColor = UIColor.black
    contentLabel.text = """
Content, this should increase in size, of course it increases,
Content, this should increase in size, of course it increases
"""
    contentLabel.anchor(top: userNameLabel.bottomAnchor, leading: userImageView.trailingAnchor, trailing: trailingAnchor, bottom: nil,
                        padding: UIEdgeInsets(top: 8, left: 8, bottom: 0, right: 8))
  }

  private func stackViewConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.alignment = .leading
    stackView.anchor(top: contentLabel.bottomAnchor, leading: userImageView.trailingAnchor, trailing: trailingAnchor, bottom: bottomAnchor,
                     padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 16))
  }
}
