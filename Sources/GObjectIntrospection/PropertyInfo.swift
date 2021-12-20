//
//  PropertyInfo.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias ParamFlags = GParamFlags

extension ParamFlags: OptionSet {}

public extension ParamFlags {
    /// The property is readable
    @inlinable var isReadable: Bool { contains(.readable) }
    /// The property is writable
    @inlinable var isWritable: Bool { contains(.writable) }
    /// The property is construct only
    @inlinable var isConstructOnly: Bool { contains(.constructOnly) }
    /// The property is a constructor parameter
    @inlinable var isConstruct: Bool { contains(.construct) }
    /// The property has lax validation
    @inlinable var isLaxValidation: Bool { contains(.laxValidation) }
    /// The property is a static name
    @inlinable var isStaticName: Bool { contains(.staticName) }
    /// The property is a nick name
    @inlinable var isStaticNick: Bool { contains(.staticNick) }
    /// The property is a blurb
    @inlinable var isStaticBlurb: Bool { contains(.staticBlurb) }
    /// The property requires an explicit notification
    @inlinable var isExplicitNotify: Bool { contains(.explicitNotify) }
    /// The property is  deprecated
    @inlinable var isDeprecated: Bool { contains(.deprecated) }
    /// No flags
    static let none: ParamFlags = []
    /// This parameter/property is readable
    static let readable = G_PARAM_READABLE
    /// This parameter/property is writable
    static let writable = G_PARAM_WRITABLE
    /// This parameter/property is construct only
    static let constructOnly = G_PARAM_CONSTRUCT_ONLY
    /// This parameter/property is a constructor parameter
    static let construct = G_PARAM_CONSTRUCT
    /// This parameter/property has lax validation
    static let laxValidation = G_PARAM_LAX_VALIDATION
    /// This parameter/property is a static name
    static let staticName = G_PARAM_STATIC_NAME
    /// This parameter/property is a static nick name
    static let staticNick = G_PARAM_STATIC_NICK
    /// This parameter/property is a static blurb
    static let staticBlurb = G_PARAM_STATIC_BLURB
    /// This parameter/property requires explicit notification
    static let explicitNotify = G_PARAM_EXPLICIT_NOTIFY
    /// This parameter/property is deprecated
    static let deprecated = G_PARAM_DEPRECATED
}
/// Subclass of `BaseInfo` representing a property
public class PropertyInfo: BaseInfo {
    /// Return the flags for this property info
    @inlinable public var flags: ParamFlags { g_property_info_get_flags(baseInfo) }
    /// Obtain the ownership transfer information for this property
    @inlinable public var ownership: Transfer { g_property_info_get_ownership_transfer(baseInfo) }
    /// The type of the property.
    @inlinable public var typeInfo: TypeInfo { TypeInfo(g_property_info_get_type(baseInfo)) }
    /// The getter for this property
    @inlinable public var getter: FunctionInfo { FunctionInfo(g_property_info_get_getter(baseInfo)) }
    /// The setter for this property
    @inlinable public var setter: FunctionInfo { FunctionInfo(g_property_info_get_setter(baseInfo)) }
}
