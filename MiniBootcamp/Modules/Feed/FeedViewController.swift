//
//  FeedViewController.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import UIKit

final class FeedViewController: UITableViewController {
    

    var viewModel: FeedViewModel
    
    private let dispatchQueueGlobal = DispatchQueue.global()
    
    
    init(viewModel: FeedViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configBarButtons()
        configBinding()
        viewModel.fetchTweetTimeLine()
    }
    
    private func configUI(){
        title = MBConstants.appName
        view.backgroundColor = .systemBackground
        tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
    }
    
    private func configBarButtons() {
        let rightButton = UIBarButtonItem(barButtonSystemItem: .add, target: nil, action: nil)
        navigationItem.rightBarButtonItem = rightButton
        
        let leftButton = UIBarButtonItem(image: UIImage(systemName: "person"), style: .plain, target: nil, action: nil)
        navigationItem.leftBarButtonItem = leftButton
    }
    
    private func configBinding() {
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
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.timeline.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard viewModel.timeline.count > 0, let cell: TweetCell = tableView.dequeueReusableCell(withIdentifier: "TweetCell") as? TweetCell else { return TweetCell() }
        let viewModel = viewModel.timeline[indexPath.row]
        cell.configData(viewModel: viewModel)
        
        if let url = viewModel.url {
            dispatchQueueGlobal.async {
                if let data = try? Data(contentsOf: url ) {
                    if let image = UIImage(data: data) {
                        DispatchQueue.main.async {
                            cell.configImage(userImage: image)
                        }
                    }
                }
            }
        }
        

        return cell
    }
    

}
