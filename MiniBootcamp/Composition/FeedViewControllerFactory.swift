//
//  FeedViewControllerFactory.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 03/07/22.
//

import UIKit

struct FeedViewControllerFactory {
    
    func makeFeedController() -> UIViewController {
        let viewModel = FeedViewModel(api: TweetTimelineAPI(session: .shared))
        return FeedViewController(viewModel: viewModel)
    }
}
