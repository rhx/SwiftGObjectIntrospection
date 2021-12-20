//
//  File.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias FunctionInfoFlags = GIFunctionInfoFlags
extension FunctionInfoFlags: OptionSet {}
public extension FunctionInfoFlags {
    /// Return `true` iff this function is a method
    @inlinable var isMethod: Bool { self.contains(.method) }
    /// Return `true` iff this function is a constructor
    /// (i.e. a function with a `self` parameter)
    @inlinable var isConstructor: Bool { self.contains(.constructor) }
    /// Return `true` iff this function is a getter
    @inlinable var isGetter: Bool { self.contains(.getter) }
    /// Return `true` iff this function is a setter
    @inlinable var isSetter: Bool { self.contains(.setter) }
    /// Return `true` iff this function wraps a virtual function
    @inlinable var isVirtual: Bool { self.contains(.virtual) }
    /// Return `true` iff this function can throw
    @inlinable var canThrow: Bool { self.contains(.throws) }

    /// This function is a method
    static let method = GI_FUNCTION_IS_METHOD
    /// This function is a constructor
    /// - Note: This flag is only valid for methods
    static let constructor = GI_FUNCTION_IS_CONSTRUCTOR
    /// This function is a getter
    /// - Note: This flag is only valid for methods
    static let getter = GI_FUNCTION_IS_GETTER
    /// This function is a setter
    /// - Note: This flag is only valid for methods
    static let setter = GI_FUNCTION_IS_SETTER
    /// This function wraps a virtual function
    static let virtual = GI_FUNCTION_WRAPS_VFUNC
    /// This function throws
    static let `throws` = GI_FUNCTION_THROWS
}

/// Subclass of `BaseInfo`  containing function information
public class FunctionInfo: BaseInfo {
    /// Return the flags for the receiver
    @inlinable public var flags: FunctionInfoFlags {
        g_function_info_get_flags(baseInfo)
    }
    /// Return the symbol name of the receiver
    @inlinable public var symbol: String {
        String(cString: g_function_info_get_symbol(baseInfo))
    }
    /// Obtain the property associated with this GIFunctionInfo.
    /// Only GIFunctionInfo with the flag `.getter` or `.setter`
    /// have a property set.For other cases,
    /// `nil` will be returned.
    @inlinable public var property: PropertyInfo? {
        g_function_info_get_property(baseInfo).map { PropertyInfo($0) }
    }
    /// Obtain the virtual function associated with this `FunctionInfo`.
    /// Only GIFunctionInfo with the flag `.virtual` have a virtual function set.
    /// For other cases, `nil` will be returned.
    @inlinable public var virtual: VFuncInfo? {
        g_function_info_get_vfunc(baseInfo).map { VFuncInfo($0) }
    }
    /// Quark for invoke errors
    public static let invokeErrorQuark: GQuark = g_invoke_error_quark()
    /// Invoke the function described by the receiver with the given arguments.
    /// - Note: `.inout` parameters must appear in both argument lists.
    /// This function uses `dlsym()` to obtain the function pointer,
    /// so the library or shared object containing the described function
    /// must be either linked to the caller or must have been `g_module_symbol()`ed
    /// before calling this function.
    /// - Parameters:
    ///   - inputs: Array of input arguments
    ///   - outputs: Array of output arguments
    ///   - returnValue: Location for the return value of the function
    @inlinable public func invoke(withInputs inputs: [GIArgument] = [], outputs: [GIArgument] = [], returnValue: inout GIArgument) throws {
        var error: GIError?
        var rv = returnValue
        guard g_function_info_invoke(baseInfo, inputs, CInt(inputs.count), outputs, CInt(outputs.count), &rv, &error) != 0 else {
            throw error ?? unknownError
        }
        returnValue = rv
    }
    /// Invoke the function described by the receiver with the given arguments.
    /// - Note: `.inout` parameters must appear in both argument lists.
    /// This function uses `dlsym()` to obtain the function pointer,
    /// so the library or shared object containing the described function
    /// must be either linked to the caller or must have been `g_module_symbol()`ed
    /// before calling this function.
    /// - Parameters:
    ///   - inputs: Array of input arguments
    ///   - outputs: Array of output arguments
    @inlinable public func invoke(withInputs inputs: [GIArgument] = [], outputs: [GIArgument] = []) throws {
        var error: GIError?
        guard g_function_info_invoke(baseInfo, inputs, CInt(inputs.count), outputs, CInt(outputs.count), nil, &error) != 0 else {
            throw error ?? unknownError
        }
    }
}

