//
//  RxHelpers.swift
//  RxASDataSources
//
//  Created by Dang Thai Son on 7/15/17.
//  Copyright (c) 2017 RxSwiftCommunity. All rights reserved.
//

import Foundation
import RxCocoa
// MARK: Error binding policies

internal func bindingErrorToInterface(_ error: Swift.Error) {
    let error = "Binding error to UI: \(error)"
    #if DEBUG
        rxFatalError(error)
    #else
        print(error)
    #endif
}

// MARK: Cast or Fatal error

/// Swift does not implement abstract methods. This method is used as a runtime check to ensure that methods which intended to be abstract (i.e., they should be implemented in subclasses) are not called directly on the superclass.
internal func rxAbstractMethod(message: String = "Abstract method", file: StaticString = #file, line: UInt = #line) -> Swift.Never {
    rxFatalError(message, file: file, line: line)
}

internal func rxFatalError(_ lastMessage: @autoclosure () -> String, file: StaticString = #file, line: UInt = #line) -> Swift.Never  {
    // The temptation to comment this line is great, but please don't, it's for your own good. The choice is yours.
    fatalError(lastMessage(), file: file, line: line)
}

internal func castOrThrow<T>(_ resultType: T.Type, _ object: Any) throws -> T {
    guard let returnValue = object as? T else {
        throw RxCocoaError.castingError(object: object, targetType: resultType)
    }

    return returnValue
}

internal func castOrFatalError<T>(_ value: AnyObject!, message: String) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        rxFatalError(message)
    }

    return result
}

internal func castOrFatalError<T>(_ value: Any!) -> T {
    let maybeResult: T? = value as? T
    guard let result = maybeResult else {
        rxFatalError("Failure converting from \(value) to \(T.self)")
    }

    return result
}

// MARK: Shared with RxSwift

internal func rxDebugFatalError(_ message: String) {
    #if DEBUG
        fatalError(message)
    #else
        print(message)
    #endif
}
