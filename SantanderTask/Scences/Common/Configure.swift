//
//  Configure.swift
//  SantanderTask
//
//  Created by Farid Ullah on 18/12/2020.
//

import Foundation

func configure<T>(
    _ value: T,
    using closure: (inout T) throws -> Void
) rethrows -> T {
    var value = value
    try closure(&value)
    return value
}
