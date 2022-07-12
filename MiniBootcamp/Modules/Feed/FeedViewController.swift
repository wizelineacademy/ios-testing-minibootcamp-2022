//
//  FeedViewController.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import UIKit
import SwiftUI

class FeedViewController: UIViewController, UITableViewDataSource, UITableViewDelegate{
  
    
    private var tweetsViewModel: TweetListViewModel?
    let tableView: UITableView = UITableView()
    let group = DispatchGroup()
    var fetchedImages:[URL:UIImage] = [:]
    private var listTweets: [TweetViewModel] = []
    let activityIndicator = UIActivityIndicatorView(style: .large)
    var coordinator: MainCoordinator?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
        fetchTweets()
    }
    
    
    private func configureUI() {
        view.backgroundColor = .systemBackground

        configureNavigation()
        configureMenuButton()
        configureTableView()
        configureActivityIndicatorView()
    }
    
    @objc func addTapped() {
        
    }
    
    private func configureNavigation() {
        self.navigationItem.title = "WizeTweet"
        navigationController?.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
        navigationController?.navigationBar.barTintColor = UIColor.redMain
        navigationController?.navigationBar.backgroundColor = UIColor.redMain
        navigationController?.setStatusBar(backgroundColor: UIColor.redMain)
        navigationController?.navigationBar.isTranslucent = false
    }
    
    private func configureMenuButton(){
        // Initialization
        let menuBtn = UIButton(type: .custom)
        menuBtn.frame = CGRect(x: 0.0, y: 0.0, width: 20, height: 20)
        menuBtn.setImage(UIImage(named:"plus-2"), for: .normal)
        menuBtn.addTarget(self, action: #selector(addTapped), for: UIControl.Event.touchUpInside)
        //Configuration
        let menuBarItem = UIBarButtonItem(customView: menuBtn)
        let currWidth = menuBarItem.customView?.widthAnchor.constraint(equalToConstant: 24)
        currWidth?.isActive = true
        let currHeight = menuBarItem.customView?.heightAnchor.constraint(equalToConstant: 24)
        currHeight?.isActive = true
        self.navigationItem.rightBarButtonItem = menuBarItem
    }
    
    
    private func configureTableView() {
        
        
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TweetTableViewCell.self, forCellReuseIdentifier: TweetTableViewCell.identifier)
//        tableView.rowHeight = UITableView.automaticDimension
//        tableView.estimatedRowHeight = 44
        tableView.translatesAutoresizingMaskIntoConstraints = false
        self.view.addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalTo: view.topAnchor),
            tableView.bottomAnchor.constraint(equalTo: view.bottomAnchor),
            tableView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
        ])
    }
    
    private func configureActivityIndicatorView() {
        
        self.view.addSubview(activityIndicator)
        activityIndicator.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            activityIndicator.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            activityIndicator.centerYAnchor.constraint(equalTo: view.centerYAnchor)
        ])
        activityIndicator.startAnimating()
    }
    
    func fetchTweets() {
        TweetTimelineAPI().load(.timeline) { result in
            switch(result) {
            case .success(let _tweets):
                self.tweetsViewModel = TweetListViewModel(_tweets)
                DispatchQueue.main.async {
                    self.waitDownload()
                }
            case .failure(_):
                print("Couldn't fetch")
            }
        }
    }
    private func waitDownload() {
        
        for tweet in self.tweetsViewModel!.getListTweets() {
            let url = URL(string: tweet.user.profileImageURL!)!
            self.group.enter()
            TweetTimelineAPI().fethImage(url: url, completion: { image in
                self.fetchedImages[url] = image
                self.group.leave()
            })
        }
        group.notify(queue: .main) {
            print(self.fetchedImages)
            self.tableView.reloadData()
            self.activityIndicator.stopAnimating()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let tweetViewModel = tweetsViewModel?.tweetAtIndex(index: indexPath.row)
        let userViewModel = UserViewModel(tweetViewModel!.user)
        coordinator?.showDetail(tweetViewModel: tweetViewModel!, userViewModel: userViewModel, userImage: fetchedImages[userViewModel.profileImageURL!] ?? UIImage(named: "gato")!)
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetsViewModel?.numberOfRows ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: TweetTableViewCell.identifier, for: indexPath as IndexPath) as! TweetTableViewCell
//        let cell = UITableViewCell(style: .default, reuseIdentifier: "Cell")

        
        let tweetViewModel = tweetsViewModel?.tweetAtIndex(index: indexPath.row)
        let userViewModel = UserViewModel(tweetViewModel!.user)
        
        cell.configure(tweetViewModel: tweetViewModel!, userViewModel: userViewModel,userImage: fetchedImages[userViewModel.profileImageURL!] ?? UIImage(named: "gato")! )
        
        return cell
        
        
    }
}


