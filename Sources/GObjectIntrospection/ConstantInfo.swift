//
//  File.swift
//  
//
//  Created by Rene Hexel on 21/12/2021.
//
import CGObjectIntrospection

// Subclass containing constant information
public class ConstantInfo: BaseInfo {
    // Type of the constant
    @inlinable public var typeInfo: TypeInfo { TypeInfo(g_constant_info_get_type(baseInfo)) }
    /// Returns the value associated with the `ConstantInfo`
    /// and store it in the returned value.
    ///
    /// The size of the constant value stored in argument will be returned. Free the value with `freeValue()`.
    /// - Parameter argument: The `GIArgument` to fill
    /// - Returns: The size of the constant
    @inlinable public func getValue(into argument: inout GIArgument) -> Int {
        var arg = argument
        let size = g_constant_info_get_value(baseInfo, &arg)
        argument = arg
        return Int(size)
    }
    /// Free the value returned by `getValue()`
    /// - Parameter argument: The `GIArgument` to free
    @inlinable public func freeValue(argument: GIArgument) {
        var arg = argument
        g_constant_info_free_value(baseInfo, &arg)
    }
}
