//
//  RegisteredTypeInfo.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public class RegisteredTypeInfo: BaseInfo {
    /// Return the type name of the registered type
    @inlinable public var registeredTypeName: String { String(cString: g_registered_type_info_get_type_name(baseInfo)) }
    /// Return the type initialization function name of the registered type
    @inlinable public var typeInit: String { String(cString: g_registered_type_info_get_type_init(baseInfo)) }
    /// Return the type of the registered type
    @inlinable public var registeredType: GType { g_registered_type_info_get_g_type(baseInfo) }
}

