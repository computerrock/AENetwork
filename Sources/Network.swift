/**
 *  https://github.com/tadija/AENetwork
 *  Copyright (c) Marko Tadić 2017
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

public protocol NetworkDelegate: class {
    func didSendRequest(_ request: URLRequest, sender: Network)
    func interceptResult(_ result: () throws -> Fetcher.Result, from request: URLRequest,
                         completion: Fetcher.Completion.ThrowableResult, sender: Network)

    func isValidCache(_ cache: CachedURLResponse, sender: Network) -> Bool
    func shouldCacheResponse(from request: URLRequest, sender: Network) -> Bool
}

public extension NetworkDelegate {
    public func didSendRequest(_ request: URLRequest, sender: Network) {}
    public func interceptResult(_ result: () throws -> Fetcher.Result, from request: URLRequest,
                                completion: Fetcher.Completion.ThrowableResult, sender: Network) {
        do {
            let interceptedResult = try result()
            completion {
                return interceptedResult
            }
        } catch {
            completion {
                throw error
            }
        }
    }

    public func isValidCache(_ cache: CachedURLResponse, sender: Network) -> Bool {
        return true
    }
    public func shouldCacheResponse(from request: URLRequest, sender: Network) -> Bool {
        return false
    }
}

open class Network {
    
    // MARK: Singleton
    
    public static let shared = Network(fetcher: .shared, downloader: .shared)

    // MARK: Properties

    public weak var delegate: NetworkDelegate?

    public let fetcher: Fetcher
    public let downloader: Downloader
    public let cache: URLCache

    // MARK: Init
    
    public init(fetcher: Fetcher = .shared, downloader: Downloader = .shared, cache: URLCache = .shared) {
        self.fetcher = fetcher
        self.downloader = downloader
        self.cache = cache
    }

    // MARK: API

    public func sendRequest(_ request: URLRequest, completion: @escaping Fetcher.Completion.ThrowableResult) {
        if let cachedResponse = loadCachedResponse(for: request) {
            completion {
                let httpResponse = cachedResponse.response as! HTTPURLResponse
                return Fetcher.Result(response: httpResponse, data: cachedResponse.data)
            }
        } else {
            performNetworkRequest(request, completion: completion)
        }
    }

    // MARK: Helpers

    private func loadCachedResponse(for request: URLRequest) -> CachedURLResponse? {
        guard
            let cachedResponse = cache.cachedResponse(for: request),
            let delegate = delegate, delegate.isValidCache(cachedResponse, sender: self)
        else {
            cache.removeCachedResponse(for: request)
            return nil
        }
        return cachedResponse
    }

    private func performNetworkRequest(_ request: URLRequest, completion: @escaping Fetcher.Completion.ThrowableResult) {
        fetcher.sendRequest(request, completion: { [weak self] (result) in
//            do {
//                let result = try result()
//                self?.handleNetworkResponse(from: request, with: result)
//                completion {
//                    return result
//                }
//            } catch {
//                completion {
//                    throw error
//                }
//            }

            if let weakSelf = self {
                if let delegate = weakSelf.delegate {
                    delegate.interceptResult(result, from: request, completion: completion, sender: weakSelf)
                } else {
                    completion {
                        return try result()
                    }
                }
            } else {
                completion {
                    return try result()
                }
            }

        })
        delegate?.didSendRequest(request, sender: self)
    }

    private func handleNetworkResponse(from request: URLRequest, with result: Fetcher.Result) {
        tryCachingResponse(result.response, with: result.data, from: request)
    }

    private func tryCachingResponse(_ response: HTTPURLResponse, with data: Data, from request: URLRequest) {
        guard let delegate = delegate, delegate.shouldCacheResponse(from: request, sender: self) else {
            return
        }
        let cachedResponse = CachedURLResponse(response: response, data: data, storagePolicy: .allowed)
        cache.storeCachedResponse(cachedResponse, for: request)
    }

}
