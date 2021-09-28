//
//  NetworkBreadcrumbsScenario.swift
//  iOSTestApp
//
//  Created by Steve Kirkland-Walton on 10/09/2021.
//  Copyright © 2021 Bugsnag. All rights reserved.
//

import Foundation

class NetworkBreadcrumbsScenario : Scenario {

    override func startBugsnag() {
        self.config.autoTrackSessions = false;
        if #available(iOS 10.0, macOS 10.12, *) {
            self.config.add(BugsnagNetworkRequestPlugin())
        } else {
            fatalError("Cannot test BugsnagNetworkRequestPlugin on iOS versions < 10, macOS < 10.12")
        }

        super.startBugsnag()
    }

    override func run() {

        // Make some network requests so that automatic network breadcrumbs are left
        query(address: "http://bs-local.com:9340/reflect/?status=444")
        query(address: "http://bs-local.com:9340/reflect/?delay_ms=3000")

        // Send a handled error
        let error = NSError(domain: "NetworkBreadcrumbsScenario", code: 100, userInfo: nil)
        Bugsnag.notifyError(error)
    }

    func query(address: String) {
        let url = URL(string: address)!
        let semaphore = DispatchSemaphore(value: 0)

        let task = URLSession.shared.dataTask(with: url) {(data, response, error) in
            semaphore.signal()
        }
        task.resume()
        semaphore.wait()
    }
}
