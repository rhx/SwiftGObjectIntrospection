//
//  GIRepositoryLoadFlags.swift
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias RepositoryLoadFlags = GIRepositoryLoadFlags

extension RepositoryLoadFlags: OptionSet {}

public extension RepositoryLoadFlags {
    /// Return whether the repository is loaded lazily
    @inlinable var isLazy: Bool { self.contains(.lazy) }
    /// No flags
    static let none: RepositoryLoadFlags = []
    /// Load the repository lazily
    static let lazy = G_IREPOSITORY_LOAD_FLAG_LAZY
}
