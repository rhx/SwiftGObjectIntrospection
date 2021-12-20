//
//  VFuncInfo.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias VFuncInfoFlags = GIVFuncInfoFlags

extension VFuncInfoFlags: OptionSet {}

public extension VFuncInfoFlags {
    /// This virtual function chains up to the parent type
    @inlinable var mustChainUp: Bool { self.contains(.mustChainUp) }
    /// This virtual function overrides a virtual function in the parent type
    @inlinable var mustOverride: Bool { self.contains(.mustOverride) }
    /// This virtual function does not override
    @inlinable var mustNotOverride: Bool { self.contains(.mustNotOverride) }
    /// This virtual function throws
    @inlinable var isThrowing: Bool { self.contains(.throws) }
    /// No flags
    static let none: VFuncInfoFlags = []
    /// The virtual function must chain up to the parent type
    static let mustChainUp = GI_VFUNC_MUST_CHAIN_UP
    /// This virtual function must override a virtual function in the parent type
    static let mustOverride = GI_VFUNC_MUST_OVERRIDE
    /// This virtual function must not override a virtual function in the parent type
    static let mustNotOverride = GI_VFUNC_MUST_NOT_OVERRIDE
    /// This virtual function throws a `GError`
    static let `throws` = GI_VFUNC_THROWS
}

/// Subclass of `BaseInfo` containing virtual function information
public class VFuncInfo: BaseInfo {
    /// Return the flags for the receiver
    @inlinable public var flags: VFuncInfoFlags { g_vfunc_info_get_flags(baseInfo) }
    /// Return the offset of the virtual function
    @inlinable public var offset: Int { Int(g_vfunc_info_get_offset(baseInfo)) }
    /// Return the signal for the virtual function if set
    @inlinable public var signal: SignalInfo? { g_vfunc_info_get_signal(baseInfo).map { SignalInfo($0) } }
    /// Return the invoker if this virtual function has an associated invoker method.
    /// - Note: An invoker method is a C entry point.
    @inlinable public var invoker: FunctionInfo? { g_vfunc_info_get_invoker(baseInfo).map { FunctionInfo($0) } }
    /// Look up where inside the implementor this virtual function is implemented
    @inlinable public func getAddress(for implementorType: GType) throws -> gpointer {
        var error: GIError?
        guard let pointer = g_vfunc_info_get_address(baseInfo, implementorType, &error),
            error == nil else {
                throw error ?? unknownError
        }
        return pointer
    }
    /// Invoke the function described by the receiver with the given arguments.
    /// - Note: `.inout` parameters must appear in both argument lists.
    /// This function uses `dlsym()` to obtain the function pointer,
    /// so the library or shared object containing the described function
    /// must be either linked to the caller or must have been `g_module_symbol()`ed
    /// before calling this function.
    /// - Parameters:
    ///   - implementor: The type that implements the virtual function
    ///   - inputs: Array of input arguments
    ///   - outputs: Array of output arguments
    ///   - returnValue: Location for the return value of the function
    @inlinable public func invoke(for implementor: GType, withInputs inputs: [GIArgument] = [], outputs: [GIArgument] = [], returnValue: inout GIArgument) throws {
        var error: GIError?
        var rv = returnValue
        guard g_vfunc_info_invoke(baseInfo, implementor, inputs, CInt(inputs.count), outputs, CInt(outputs.count), &rv, &error) != 0 else {
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
    ///   - implementor: The type that implements the virtual function
    ///   - inputs: Array of input arguments
    ///   - outputs: Array of output arguments
    @inlinable public func invoke(for implementor: GType, withInputs inputs: [GIArgument] = [], outputs: [GIArgument] = []) throws {
        var error: GIError?
        guard g_vfunc_info_invoke(baseInfo, implementor, inputs, CInt(inputs.count), outputs, CInt(outputs.count), nil, &error) != 0 else {
            throw error ?? unknownError
        }
    }

}

