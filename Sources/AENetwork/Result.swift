/**
 *  https://github.com/tadija/AENetwork
 *  Copyright (c) Marko Tadić 2017-2018
 *  Licensed under the MIT license. See LICENSE file.
 */

import Foundation

public enum Result<T> {
    case success(T)
    case failure(Error)
}

public typealias ResultCallback<T> = (Result<T>) -> Void

public extension Result {
    init(value: T) {
        self = .success(value)
    }
    init(error: Error) {
        self = .failure(error)
    }
    init(value: T?, error: Error?) {
        switch (value, error) {
        case (let v?, _):
            self = .success(v)
        case (nil, let e?):
            self = .failure(e)
        case (nil, nil):
            let error = NSError(domain: "AENetwork.Result", code: 1,
                             userInfo: [NSLocalizedDescriptionKey : "Invalid result: both value and error are nil."])
            self = .failure(error)
        }
    }
    
    var value: T? {
        switch self {
        case let .success(value): return value
        case .failure: return nil
        }
    }
    var error: Error? {
        switch self {
        case .success: return nil
        case let .failure(error): return error
        }
    }
    
    var isSuccess: Bool {
        switch self {
        case .success: return true
        case .failure: return false
        }
    }
    var isFailure: Bool {
        return !isSuccess
    }
    
    func throwValue() throws -> T {
        switch self {
        case let .success(value):
            return value
        case let .failure(error):
            throw error
        }
    }
}
