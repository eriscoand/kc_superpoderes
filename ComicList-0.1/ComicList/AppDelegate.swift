//
//  AppDelegate.swift
//  ComicList
//
//  Created by Guille Gonzalez on 06/02/2017.
//  Copyright © 2017 Guille Gonzalez. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

	var coordinator: AppCoordinator?

	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

		let window = UIWindow(frame: UIScreen.main.bounds)
        
        //testResources()
        //testJSON()

		coordinator = AppCoordinator(window: window)
		coordinator?.start()

		return true
	}
}

import Networking
import RxSwift

func testResources(){
    
    let client = WebClient()
    let resource = Volume.titles(query: "Bat")
    let _ = resource.request
    
    client.load(resource: resource)
        .map {
            return $0.results.map { $0.title }
        }
        .subscribe(onNext: { titles in
            print(titles)
        }).dispose()
    
    let _ = resource.request
    
}

func testJSON(){
    
    let json: JSONDictionary = [
        "error": "OK",
        "status_code": 1,
        "message": "Como viviras Johny?",
        "results": [
            [
                "id" : 1,
                "name": "Bacon Ipsum",
                "image": [
                    "small_url": "https://s-media-cache-ak0.pinimg.com/originals/22/83/85/2283858ad720296c180b9eff4c722545.jpg"
                ],
                "description": "LOL 1"
            ],
            [
                "id" : 2,
                "name": "Bacon Ipsum 2",
                "image": [
                    "small_url": "https://s-media-cache-ak0.pinimg.com/originals/15/05/d7/1505d72d3265c9054ef33b99432b53a9.jpg"
                ],
                "description": "LOL 2"
            ],
            [
                "id" : 3,
                "name": "Bacon Ipsum 3",
                "image": [
                    "small_url": "https://s-media-cache-ak0.pinimg.com/736x/0f/ee/88/0fee881dd397f191539e57e82b7a93ff.jpg"
                ],
                "description": "LOL 3"
            ]
        ]
    ]
    
    do {
        let response: Response<Volume> = try decode(jsonDictionary: json)
        
        print(response)
    }catch{
        print(error)
    }
    
}
