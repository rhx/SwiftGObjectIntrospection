//
//  GIRepositoryLoadFlags.swift
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public extension GIRepositoryLoadFlags {
    /// No flags
    static let none = GIRepositoryLoadFlags(rawValue: 0)
    /// Load the repository lazily
    static let lazy = G_IREPOSITORY_LOAD_FLAG_LAZY
}
