//
//  SearchResultsViewModel.swift
//  ComicList
//
//  Created by Guille Gonzalez on 09/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import RxSwift
import Networking

// FIXME: This is a fake implementation

extension VolumeViewModel {
    
    init(volume: Volume){
        self.identifier = volume.id!
        self.title = volume.title
        self.coverURL = volume.coverURL
        self.publisherName = ""
    }
    
}

final class SearchResultsViewModel {

	let query: String
	var didLoadPage: () -> Void = {}
    let client = WebClient()

	public var numberOfItems: Int {
		return items.count
	}

	public func item(at position: Int) -> VolumeViewModel {
		precondition(position < numberOfItems)
		return items[position]
	}

	public func load(autoloadNextOn trigger: Observable<Void>) -> Observable<Int> {
		return doLoad(page: 1, nextPage: trigger)
	}

	private var items: [VolumeViewModel] = []

	init(query: String) {
		self.query = query
	}

	private func doLoad(page current: Int, nextPage trigger: Observable<Void>) -> Observable<Int> {
        let resources = Volume.search(query: self.query, page: current)
        return client.load(resource: resources)
            .map { response in
                return response.results.map (VolumeViewModel.init(volume:))
            }
            .observeOn(MainScheduler.instance)
            .do(onNext: { viewModels in
                self.items.append(contentsOf: viewModels)
                self.didLoadPage()
            })
            .flatMap { _ -> Observable<Int> in
                return Observable.concat([Observable.just(current),
                                          Observable.never().takeUntil(trigger),
                                          self.doLoad(page: current + 1, nextPage: trigger)])
            }
	}
}
