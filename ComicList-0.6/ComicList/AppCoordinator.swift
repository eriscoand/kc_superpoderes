//
//  AppCoordinator.swift
//  ComicList
//
//  Created by Guille Gonzalez on 07/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit
import Storage

final class AppCoordinator: Coordinator {

	private let window: UIWindow
	private let navigationController = UINavigationController()
	private let store = DataStore(name: "My Comics")

	init(window: UIWindow) {
		self.window = window
	}

	override func start() {
		customizeAppearance()

		window.rootViewController = navigationController

		// The volume list is the initial screen
		let coordinator = VolumeListCoordinator(store: store, navigationController: navigationController)

		add(child: coordinator)
		coordinator.start()

		window.makeKeyAndVisible()
	}

	private func customizeAppearance() {
		let navigationBarAppearance = UINavigationBar.appearance()
		let barTintColor = UIColor(named: .bar)

		navigationBarAppearance.barStyle = .black // This will make the status bar white by default
		navigationBarAppearance.barTintColor = barTintColor
		navigationBarAppearance.tintColor = UIColor.white
		navigationBarAppearance.titleTextAttributes = [
			NSForegroundColorAttributeName: UIColor.white
		]
	}
}
