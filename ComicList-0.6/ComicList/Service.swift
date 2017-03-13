//
//  Service+VolumeDescription.swift
//  ComicList
//
//  Created by Guille Gonzalez on 13/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import Foundation
import RxSwift

import ComicVine

extension Service {

	func description(forVolumeWithIdentifier identifier: Int64) -> Observable<String?> {
		return results(for: Volume.detail(withIdentifier: identifier))
			.map { volumes in
				guard let rawDescription = volumes.first?.description else {
					return nil
				}

				return rawDescription.replacingOccurrences(
					of: "<[^>]+>",
					with: "",
					options: .regularExpression,
					range: nil
				)
			}
	}
    
    func issues(forVolumeWithIdentifier identifier: Int64) -> Observable<[IssueViewModel]> {
        return results(for: Issue.issues(fromVolume: identifier))
            .map { issues in
                return issues
                    .map { issue in
                        let issueView = IssueViewModel(title: issue.volume.title, coverURL: issue.volume.coverURL)
                        return issueView
                    }
            }
                
    }
}
