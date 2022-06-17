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
    backgroundColor = .systemBackground
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
    NSLayoutConstraint.activate([
      userImageView.centerYAnchor.constraint(equalTo: userNameLabel.centerYAnchor),
      userImageView.leftAnchor.constraint(equalTo: contentView.leftAnchor, constant: 16),
      userImageView.heightAnchor.constraint(equalToConstant: 48),
      userImageView.widthAnchor.constraint(equalToConstant: 48)
    ])
  }

  private func nameLabelConstraints() {
    nameLabel.text = "WizeBot"
    nameLabel.textColor = .black
    nameLabel.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
    NSLayoutConstraint.activate([
      nameLabel.topAnchor.constraint(equalTo: topAnchor, constant: 8),
      nameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 8),
      nameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
    ])
  }

  private func userNameLabelConstraints() {
    userNameLabel.text = "@wizeservicebot"
    userNameLabel.setContentHuggingPriority(UILayoutPriority(999), for: .vertical)
    NSLayoutConstraint.activate([
      userNameLabel.topAnchor.constraint(equalTo: nameLabel.bottomAnchor, constant: 8),
      userNameLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 8),
      userNameLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
    ])
  }

  private func contentLabelConstraints() {
    contentLabel.textColor = UIColor.black
    contentLabel.text = """
Content, this should increase in size, of course it increases, but
and-group.enter()group.enter()group.enter()group.enter()
group.enter()group.enter()group.enter()group.enter()group.enter()
group.enter()group.enter()
group.enter()group.enter()group.enter()
group.enter()group.enter()group.enter()group.enter()
group.enter()group.enter()group.enter()
"""
    NSLayoutConstraint.activate([
      contentLabel.topAnchor.constraint(equalTo: userNameLabel.bottomAnchor, constant: 8),
      contentLabel.leftAnchor.constraint(equalTo: userImageView.rightAnchor, constant: 8),
      contentLabel.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
    ])
  }

  private func stackViewConstraints() {
    stackView.translatesAutoresizingMaskIntoConstraints = false
    stackView.axis = .horizontal
    stackView.distribution = .equalSpacing
    stackView.alignment = .leading
    NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: contentLabel.bottomAnchor, constant: 8),
      stackView.leftAnchor.constraint(equalTo: userImageView.rightAnchor),
      stackView.bottomAnchor.constraint(equalTo: bottomAnchor, constant: -8),
      stackView.rightAnchor.constraint(equalTo: rightAnchor, constant: -8)
    ])
  }
}
