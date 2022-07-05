//
//  SearchViewController.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 03/07/22.
//

import UIKit

final class SearchViewController: UITableViewController {
    
    private let viewModel: SearchViewModel
    private let dispatchQueueGlobal = DispatchQueue.global()
    private let searchController = UISearchController(searchResultsController: nil)
    init(viewModel: SearchViewModel) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        return nil
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configUI()
        configBinding()
    }
    
    private func configUI(){
        title = viewModel.title
        tableView.register(TweetCell.self, forCellReuseIdentifier: "TweetCell")
        searchController.searchResultsUpdater = self
        navigationItem.searchController = searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        view.backgroundColor = .systemBackground
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
    
    @objc
    func searchingText() {
        guard let text = searchController.searchBar.text else { return }
        viewModel.search(text)
    }
    
}


extension SearchViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        NSObject.cancelPreviousPerformRequests(withTarget: self, selector: #selector(self.searchingText), object: nil)
        self.perform(#selector(self.searchingText), with: nil, afterDelay: MBConstants.throttleTypeTime)
    }
}

