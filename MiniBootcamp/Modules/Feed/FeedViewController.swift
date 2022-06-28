//
//  FeedViewController.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import UIKit

class FeedViewController: UIViewController {
  @UsesLayout var tableView: UITableView = UITableView()
  var viewModel: ViewModel = ViewModel(api: TweetTimelineAPI(session: .shared))

  override func viewDidLoad() {
    super.viewDidLoad()
    view.backgroundColor = .white
    setupTableView()
    viewModel.fetchTweetTimeLine()
    setNavigationBar()

    viewModel.state.bind { [weak self] state in
      DispatchQueue.main.async {
        guard let stateNotNil = state else { return }
        switch stateNotNil {
        case .loading:
          print("loading")
        case .success:
          // dismissLoader
          self?.tableView.reloadData()
          print("success")
        case .failure:
          print("failure")
        }
      }
    }
  }

  // MARK: - Private methods

  private func setupTableView() {
    view.addSubview(tableView)
    tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
    tableView.dataSource = self
    tableView.delegate = self
    tableView.anchor(top: view.topAnchor, leading: view.leadingAnchor, trailing: view.trailingAnchor, bottom: view.bottomAnchor)
    tableView.backgroundColor = .clear
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
}

extension FeedViewController: UITableViewDelegate {

}

extension FeedViewController: UITableViewDataSource {
  func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    viewModel.timeline.count
  }

  func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    guard let cell: TweetCell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as? TweetCell else { return TweetCell() }
    cell.contentLabel.text = viewModel.timeline[indexPath.row].content
    return cell
  }
}
