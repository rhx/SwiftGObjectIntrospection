//
//  Error.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias GIError = UnsafeMutablePointer<GError>

extension GIError: Error {}
extension GIError: CustomStringConvertible {
    /// Return the description of the error
    public var description: String { String(cString: pointee.message) }
}

@usableFromInline
var unknownError: GIError = {
    var error: GIError!
    g_set_error_literal(&error, g_quark_from_static_string("Unknown"), 0, "Unkown Error")
    return error
}()
