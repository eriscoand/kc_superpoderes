//
//  SuggestionsViewModel.swift
//  ComicList
//
//  Created by Guille Gonzalez on 08/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import RxSwift
import Networking

// FIXME: This is a fake implementation

final class SuggestionsViewModel {

	/// The search query
	let query = Variable("")
    private let client = WebClient()

	/// The search suggestions
	private(set) lazy var suggestions: Observable<[String]> = self.query.asObservable()
        .filter { $0.characters.count > 2 }
        .throttle(0.3, scheduler: MainScheduler.instance)
        .debug()
        .flatMap { query -> Observable<Response<Volume>> in
            let resource = Volume.titles(query: query)
            return self.client.load(resource: resource)
        }
        .map { response -> [String] in
            return response.results.map { $0.title }
        }
        .observeOn(MainScheduler.instance)
}
