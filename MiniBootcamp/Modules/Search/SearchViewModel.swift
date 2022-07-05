//
//  SearchViewModel.swift
//  MiniBootcamp
//
//  Created by Javier Cueto on 04/07/22.
//

final class SearchViewModel {
    private var api: TweetTimelineAPI
    
    var title: String {
        return MBConstants.search
    }
    
    var timeline: [TweetViewModel] = []
    
    var state: Observer<State> = Observer<State>()
    
    init(api: TweetTimelineAPI) {
        self.api = api
    }
    
    func search(_ text: String) {
        guard !text.isEmpty else { return }
        state.onNext(.loading)
        api.load(.search(text))  { [weak self] result in
            switch result {
            case .success(let tweets):
                self?.timeline = tweets.map { TweetViewModel(tweet: $0) }
                self?.state.onNext(.success)
            case .failure(_):
                self?.state.onNext(.failure)
            }
        }
    }
}
