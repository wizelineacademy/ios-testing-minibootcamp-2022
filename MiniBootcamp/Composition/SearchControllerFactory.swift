//
//  SearchControllerFactory.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 03/07/22.
//

import UIKit

struct SearchViewControllerFactory {
    
    func makeSearchController() -> UIViewController {
        let api = TweetTimelineAPI(session: .shared)
        let viewModel = SearchViewModel(api: api)
        return SearchViewController(viewModel: viewModel)
    }
}
