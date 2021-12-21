//
//  File.swift
//  
//
//  Created by Rene Hexel on 21/12/2021.
//
import CGObjectIntrospection

// Subclass containing type information
public class TypeInfo: BaseInfo {
    /// Return whether the type is passed by reference
    /// - Note: The types of `GI_DIRECTION_OUT` and `GI_DIRECTION_INOUT` parameters will only be pointers if the underlying type being transferred is a pointer (i.e. only if the type of the C function’s formal parameter is a pointer to a pointer).
    @inlinable public var isPointer: Bool { g_type_info_is_pointer(baseInfo) != 0 }
    /// Return the type tag for the type
    @inlinable public var tag: TypeTag { g_type_info_get_tag(baseInfo) }
    /// Return the length of the array if the type is an array, `nil` otherwise
    @inlinable public var arrayLength: Int? {
        let length = g_type_info_get_array_length(baseInfo)
        return length == -1 ? nil : Int(length)
    }
    /// Return the fixed size of the array if the type is an array, `nil` otherwise
    @inlinable public var arrayFixedSize: Int? {
        let length = g_type_info_get_array_fixed_size(baseInfo)
        return length == -1 ? nil : Int(length)
    }
    /// Return whether the last element of the array is zero-terminated.
    /// - Note: This is only valid for arrays, otherwise `false` will be returned.
    @inlinable public var isZeroTerminatedArray: Bool { g_type_info_is_zero_terminated(baseInfo) != 0 }
    /// Return the array type for this type.
    /// - Note: This is only valid for arrays, otherwise `nil` will be returned.
    @inlinable public var arrayType: GIArrayType? {
        let type = g_type_info_get_array_type(baseInfo)
        return type.rawValue == UInt32.max ? nil : type
    }
    /// return the parameter type `n`
    /// - Parameter n: index of the parameter
    /// - Returns: type information about the parameter or `nil`
    @inlinable public func getParameterType(atIndex n: Int) -> TypeInfo? { g_type_info_get_param_type(baseInfo, gint(n)).map { TypeInfo($0) } }
}

