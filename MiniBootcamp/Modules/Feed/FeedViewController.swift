//
//  FeedViewController.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import UIKit

class FeedViewController: UIViewController {

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setNavigationBar()
    addTweetCell()
  }

  private func setNavigationBar() {
    navigationController?.navigationBar.prefersLargeTitles = false

    let appearance = UINavigationBarAppearance()
    let catImage = UIImage(named: FeedConstants.catImageName)
    
    appearance.backgroundColor = UIColor.redMain
    appearance.titleTextAttributes = [.foregroundColor: UIColor.white]
    appearance.largeTitleTextAttributes = [.foregroundColor: UIColor.white]

    navigationItem.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem: .add, target: self, action: #selector(addTapped))
    navigationItem.leftBarButtonItem = UIBarButtonItem(image: catImage?.imageResized(to: CGSize(width: 24, height: 24)), style: UIBarButtonItem.Style.plain, target: self, action: #selector(addTapped))
    navigationController?.navigationBar.tintColor = .white
    navigationController?.navigationBar.standardAppearance = appearance
    navigationController?.navigationBar.compactAppearance = appearance
    navigationController?.navigationBar.scrollEdgeAppearance = appearance
    self.title = FeedConstants.navigationBarTitle
  }

  @objc private func addTapped() {
    print("")
  }

  private func addTweetCell() {
    @UsesLayout var cell: TweetCell = TweetCell()
    cell.backgroundColor = .white
    view.addSubview(cell)
    NSLayoutConstraint.activate([
      cell.centerXAnchor.constraint(equalTo: view.centerXAnchor),
      cell.centerYAnchor.constraint(equalTo: view.centerYAnchor),
      cell.widthAnchor.constraint(equalTo: view.widthAnchor)
    ])
  }
}
