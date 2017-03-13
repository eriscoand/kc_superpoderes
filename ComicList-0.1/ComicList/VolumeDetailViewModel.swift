//
//  VolumeDetailViewModel.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import RxSwift
import Networking

// FIXME: This is a fake implementation

final class VolumeDetailViewModel {

	/// Determines if the volume is saved in the user's comic list
	var isSaved: Observable<Bool> {
		return Observable.just(true)
	}

	/// The volume information
	private(set) var volume: VolumeViewModel
    
    private let client = WebClient()

	/// The volume description
	private(set) lazy var about: Observable<String?> = self.client
        .load(resource: Volume.detail(id: self.volume.identifier))
        .map { $0.results[0].description }
        .map { description in
            description?.replacingOccurrences(of: "<[^>]+>", with: "", options: .regularExpression, range: nil)
        }
        .startWith(nil)
        .catchErrorJustReturn("Error!!!")
        .observeOn(MainScheduler.instance)
        .shareReplay(1)
    
	/// The issues for this volume
	private(set) lazy var issues: Observable<[IssueViewModel]> = self.client
        .load(resource: Issue.issues(fromVolume: self.volume.identifier))
        .map { response in
            return response.results.map { issue in
                return IssueViewModel(title: issue.volume.title, coverURL: issue.volume.coverURL)
            }
        }
        .startWith([IssueViewModel]())
        .catchErrorJustReturn([IssueViewModel]())
        .observeOn(MainScheduler.instance)
        .shareReplay(1)
    
    

	/// Adds or removes the volume from the user's comic list
	func addOrRemove(){
		// TODO: implement
	}

	init(volume: VolumeViewModel) {
		self.volume = volume
	}
}
