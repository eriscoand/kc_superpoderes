//
//  VolumeDetailViewModel.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

import ComicVine
import Storage

// FIXME: This is a fake implementation

final class VolumeDetailViewModel {

	/// Determines if the volume is saved in the user's comic list
	var isSaved: Observable<Bool> {
		return saved.asObservable()
	}

	/// The volume information
	private(set) var volume: VolumeViewModel

	/// The volume description
	private(set) lazy var about: Observable<String?> = self.service
		.description(forVolumeWithIdentifier: self.volume.identifier)
		.catchErrorJustReturn(nil)
		.startWith(nil)
		.observeOn(MainScheduler.instance)
		.shareReplay(1)

	/// The issues for this volume
    private(set) lazy var issues: Observable<[IssueViewModel]> = self.service
        .issues(forVolumeWithIdentifier: self.volume.identifier)
        .catchErrorJustReturn([IssueViewModel]())
        .startWith([IssueViewModel]())
        .observeOn(MainScheduler.instance)
        .shareReplay(1)
    
    
	private let service = Service()
	private let store: DataStore
	private let saved: Variable<Bool>

	/// Adds or removes the volume from the user's comic list
	func addOrRemove() {
		do {
			try store.write { context in
				if saved.value {
					try context.delete(Volume.self, withIdentifier: volume.identifier)
				} else {
					let volume = Volume(writeContext: context)

					volume.identifier = self.volume.identifier
					volume.title = self.volume.title
					volume.coverURL = self.volume.coverURL?.absoluteString
					volume.publisher = self.volume.publisherName

					volume.insertionDate = NSDate()
				}
			}

			saved.value = !saved.value
		} catch {
			print(error)
		}
	}

	init(volume: VolumeViewModel, store: DataStore) {
		self.volume = volume
		self.store = store

		self.saved = Variable(store.contains(Volume.self, withIdentifier: volume.identifier))
	}
}
