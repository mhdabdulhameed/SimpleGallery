//
//  Result.swift
//  SimpleGallery
//
//  Created by Mohamed Abdul-Hameed on 9/19/18.
//  Copyright © 2018 Mohamed Abdul-Hameed. All rights reserved.
//

/// An enum to represent an API call response.
///
/// - success: Successful result with an associated value of type `T` that implements `Codable` protocl.
/// - failure: Failure result with an associated value of any type that implements `Error` protocol.
enum Result<T: Codable> {
    case success(T)
    case failure(Error)
}
