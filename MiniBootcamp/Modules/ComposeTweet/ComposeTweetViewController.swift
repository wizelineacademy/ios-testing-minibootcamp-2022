//
//  ComposeTweetViewController.swift
//  MiniBootcamp
//
//  Created by Heber Raziel Alvarez Ruedas on 01/07/22.
//

import Foundation
import UIKit

final class ComposeTweetViewController: UIViewController {
  var viewModel: ComposeTweetViewModel = ComposeTweetViewModel(api: PostTweetAPI(session: .shared))
  @UsesLayout var textView: UITextView = create {
    $0.backgroundColor = .systemBackground
    $0.becomeFirstResponder()
  }
  @UsesLayout var tweetButtonView: UIView = create {
    $0.backgroundColor = .orange
    $0.layer.cornerRadius = 14
  }
  @UsesLayout var tweetLabel: UILabel = create {
    $0.text = "Tweet"
    $0.font = UIFont.normal(withSize: .name)
    $0.textColor = .white
    $0.textAlignment = .center
  }
  @UsesLayout var stackView: UIStackView = create  {
    $0.distribution = .fill
    $0.backgroundColor = .systemBackground
    $0.tag = Int.zero
  }
  var bottomSpace: CGFloat = 8

  // MARK: - Private properties
  private var updatedText: String = "" {
    didSet {}
  }

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTextView()
    setupNavigationBar()
    setupStackView()
  }

  override func viewWillAppear(_ animated: Bool) {
    addKeyboardWillChangeFrameNotification()
    view.reloadInputViews()
  }

  // MARK: - Private methods

  private func setupTextView() {
    view.addSubview(textView)
    textView.delegate = self
    textView.anchor(top: view.safeAreaLayoutGuide.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: nil, padding: UIEdgeInsets(top: 8, left: 8, bottom: 8, right: 8))
  }

  private func setupNavigationBar() {
    tweetButtonView.addSubview(tweetLabel)
    tweetButtonView.anchor(top: nil, leading: nil, trailing: nil, bottom: nil, size: CGSize(width: 64, height: 28))
    tweetLabel.anchor(top: tweetButtonView.topAnchor, leading: tweetButtonView.leadingAnchor, trailing: tweetButtonView.trailingAnchor, bottom: tweetButtonView.bottomAnchor)
    navigationItem.rightBarButtonItem = UIBarButtonItem(customView: tweetButtonView)

    let tapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(performTweet))
    tweetButtonView.isUserInteractionEnabled = true
    tweetButtonView.addGestureRecognizer(tapGestureRecognizer)
  }

  private func setupStackView() {
    view.addSubview(stackView)
    @UsesLayout var characterCounterLabel: UILabel = create {
      $0.backgroundColor = .orange
      $0.text = "Characters left: 140"
    }
    stackView.addArrangedSubview(characterCounterLabel)
    stackView.anchor(top: textView.bottomAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: bottomSpace, right: 8))
  }

  private func addKeyboardWillChangeFrameNotification() {
    NotificationCenter.default.addObserver(self, selector: #selector(onKeyboardWillChangeFrame(_:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
  }


  @objc func onKeyboardWillChangeFrame(_ notification: NSNotification) {
    let keyboardSize: CGRect = (notification.userInfo? [UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue ?? CGRect()
    bottomSpace = keyboardSize.height
    stackView.anchor(top: stackView.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor, padding: UIEdgeInsets(top: 8, left: 8, bottom: bottomSpace, right: 8))
  }

  @objc func performTweet() {
    viewModel.postTweet()
  }
}

extension ComposeTweetViewController: UITextViewDelegate {
  func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
    let currentText: String = textView.text ?? ""
    guard let stringRange: Range = Range(range, in: currentText) else { return false }
    updatedText = currentText.replacingCharacters(in: stringRange, with: text)
    if updatedText.count <= 140 {
      guard let charactersLeftLabel = stackView.arrangedSubviews[0] as? UILabel else { return false }
      charactersLeftLabel.text = "Characters left: \(String(140 - updatedText.count))"
    }
    return updatedText.count < 141
  }
}
