//
//  InfoType.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias InfoType = GIInfoType

public extension InfoType {
    /// Invalid type
    static let invalid = GI_INFO_TYPE_INVALID
    static let function = GI_INFO_TYPE_FUNCTION
    static let callback = GI_INFO_TYPE_CALLBACK
    static let `struct` = GI_INFO_TYPE_STRUCT
    static let boxed = GI_INFO_TYPE_BOXED
    static let `enum` = GI_INFO_TYPE_ENUM
    static let flags = GI_INFO_TYPE_FLAGS
    static let object = GI_INFO_TYPE_OBJECT
    static let interface = GI_INFO_TYPE_INTERFACE
    static let constant = GI_INFO_TYPE_CONSTANT
    static let invalid0 = GI_INFO_TYPE_INVALID_0
    static let union = GI_INFO_TYPE_UNION
    static let value = GI_INFO_TYPE_VALUE
    static let signal = GI_INFO_TYPE_SIGNAL
    static let vfunc = GI_INFO_TYPE_VFUNC
    static let property = GI_INFO_TYPE_PROPERTY
    static let field = GI_INFO_TYPE_FIELD
    static let arg = GI_INFO_TYPE_ARG
    /// type information, see `TypeInfo`
    static let type = GI_INFO_TYPE_TYPE
    /// Unresolved type
    ///
    /// A type which is not present in the typelib,
    /// or any of its dependencies.
    static let unresolved = GI_INFO_TYPE_UNRESOLVED
}

extension InfoType: CustomStringConvertible {
    /// Return the string representation of the receiver
    public var description: String { String(cString: g_info_type_to_string(self)) }
}
