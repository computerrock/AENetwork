/**
 *  https://github.com/tadija/AENetwork
 *  Copyright © 2017-2020 Marko Tadić
 *  Licensed under the MIT license
 */

import Foundation

// MARK: - Network

open class Network {

    // MARK: Singleton

    public static let shared = Network()

    // MARK: Properties

    public let fetcher: Fetcher

    // MARK: Init

    public init(fetcher: Fetcher = Fetcher()) {
        self.fetcher = fetcher
    }

}

// MARK: - Facade

public extension URLRequest {
    func send(over network: Network = .shared, completion: @escaping Fetcher.Callback) {
        network.fetcher.send(self, completion: completion)
    }
}
