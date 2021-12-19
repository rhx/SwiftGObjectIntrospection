//
//  Typelib.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

/// A type library
public struct Typelib {
    /// Pointer to the underlying type lib
    @usableFromInline
    let typelib: UnsafeMutablePointer<GITypelib>

    /// Wrap a `GITypelib` pointer
    /// - Parameter ptr: The pointer to the `GITypeLib` instance to wrap
    @inlinable
    public init(_ ptr: UnsafeMutablePointer<GITypelib>) {
        typelib = ptr
    }
}
