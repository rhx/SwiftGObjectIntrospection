//
//  File.swift
//  
//
//  Created by Rene Hexel on 21/12/2021.
//
import CGObjectIntrospection

// Subclass containing interface information
public class InterfaceInfo: RegisteredTypeInfo {
    /// Interface Prerequisite Collection type
    public struct Prerequisites: RandomAccessCollection {
        @usableFromInline var interfaceInfo: InterfaceInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { interfaceInfo.prerequisiteCount }
        @usableFromInline init(_ interfaceInfo: InterfaceInfo) { self.interfaceInfo = interfaceInfo }
        /// Return the prerequisite at the given index
        @inlinable public subscript(position: Int) -> BaseInfo { interfaceInfo.prerequisite(at: position)! }
    }
    /// Method enumeration Collection type
    public struct Methods: RandomAccessCollection {
        @usableFromInline var interfaceInfo: InterfaceInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { interfaceInfo.methodCount }
        @usableFromInline init(_ interfaceInfo: InterfaceInfo) { self.interfaceInfo = interfaceInfo }
        /// Return the method at the given index
        @inlinable public subscript(position: Int) -> FunctionInfo { interfaceInfo.method(at: position)! }
    }
    /// Properties Collection type
    public struct Properties: RandomAccessCollection {
        @usableFromInline var interfaceInfo: InterfaceInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { interfaceInfo.propertyCount }
        @usableFromInline init(_ interfaceInfo: InterfaceInfo) { self.interfaceInfo = interfaceInfo }
        /// Return the property at the given index
        @inlinable public subscript(position: Int) -> PropertyInfo { interfaceInfo.property(at: position)! }
    }
    /// Signal enumeration Collection type
    public struct Signals: RandomAccessCollection {
        @usableFromInline var interfaceInfo: InterfaceInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { interfaceInfo.signalCount }
        @usableFromInline init(_ interfaceInfo: InterfaceInfo) { self.interfaceInfo = interfaceInfo }
        /// Return the signal at the given index
        @inlinable public subscript(position: Int) -> SignalInfo { interfaceInfo.signal(at: position)! }
    }
    /// VFunc enumeration Collection type
    public struct VFuncs: RandomAccessCollection {
        @usableFromInline var interfaceInfo: InterfaceInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { interfaceInfo.vfuncCount }
        @usableFromInline init(_ interfaceInfo: InterfaceInfo) { self.interfaceInfo = interfaceInfo }
        /// Return the vfunc at the given index
        @inlinable public subscript(position: Int) -> VFuncInfo { interfaceInfo.vfunc(at: position)! }
    }
    /// Enumeration Constant Collection type
    public struct Constants: RandomAccessCollection {
        @usableFromInline var interfaceInfo: InterfaceInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { interfaceInfo.constantCount }
        @usableFromInline init(_ interfaceInfo: InterfaceInfo) { self.interfaceInfo = interfaceInfo }
        /// Return the constant at the given index
        @inlinable public subscript(position: Int) -> ConstantInfo { interfaceInfo.constant(at: position)! }
    }
    /// Return the number of cases this interface contains.
    @inlinable public var prerequisiteCount: Int { Int(g_interface_info_get_n_prerequisites(baseInfo)) }
    /// Return the prerequisite at the given index
    /// - Parameter index: The index of the prerequisite to return.
    /// - Returns: The `SignalInfo` associated with the prerequisite at the given index, or `nil`.
    @inlinable public func prerequisite(at index: Int) -> BaseInfo? { g_interface_info_get_prerequisite(baseInfo, gint(index)).map { SignalInfo($0) } }
    /// Return the interface prerequisites as a `RandomAccessCollection`.
    @inlinable public var prerequisites: Prerequisites { Prerequisites(self) }
    /// Return the number of methods this interface type has.
    @inlinable public var methodCount: Int { Int(g_interface_info_get_n_methods(baseInfo)) }
    /// Return the method at the given index
    /// - Parameter index: The index of the method to return.
    /// - Returns: The `FunctionInfo` associated with the method at the given index, or `nil`.
    @inlinable public func method(at index: Int) -> FunctionInfo? { g_interface_info_get_method(baseInfo, gint(index)).map { FunctionInfo($0) } }
    /// Return the methods associated with this enumeration as a `RandomAccessCollection`.
    @inlinable public var methods: Methods { Methods(self) }
    /// Find the method with the given name.
    /// - Parameter name: The name of the method to find.
    /// - Returns: The `FunctionInfo` associated with the method with the given name, or `nil`.
    /// - Note: This method is case sensitive.
    @inlinable public func method(named name: String) -> FunctionInfo? { g_interface_info_find_method(baseInfo, name).map { FunctionInfo($0) } }
    /// Return the properties this interface type has.
    @inlinable public var properties: Properties { Properties(self) }
    /// Return the number of methods this enum type has.
    @inlinable public var propertyCount: Int { Int(g_interface_info_get_n_properties(baseInfo)) }
    /// Return the method at the given index
    /// - Parameter index: The index of the method to return.
    /// - Returns: The `FunctionInfo` associated with the method at the given index, or `nil`.
    @inlinable public func property(at index: Int) -> PropertyInfo? { g_interface_info_get_property(baseInfo, gint(index)).map { PropertyInfo($0) } }
    /// Return the number of cases this enumeration contains.
    @inlinable public var signalCount: Int { Int(g_interface_info_get_n_signals(baseInfo)) }
    /// Return the signal at the given index
    /// - Parameter index: The index of the signal to return.
    /// - Returns: The `SignalInfo` associated with the signal at the given index, or `nil`.
    @inlinable public func signal(at index: Int) -> SignalInfo? { g_interface_info_get_signal(baseInfo, gint(index)).map { SignalInfo($0) } }
    /// Return the enumeration signals as a `RandomAccessCollection`.
    @inlinable public var signals: Signals { Signals(self) }
    /// Find the signal with the given name.
    /// - Parameter name: The name of the signal to find.
    /// - Returns: The `SignalInfo` associated with the signal with the given name, or `nil`.
    /// - Note: This method is case sensitive.
    @inlinable public func signal(named name: String) -> SignalInfo? { g_interface_info_find_signal(baseInfo, name).map { SignalInfo($0) } }
    /// Return the number of cases this enumeration contains.
    @inlinable public var vfuncCount: Int { Int(g_interface_info_get_n_vfuncs(baseInfo)) }
    /// Return the vfunc at the given index
    /// - Parameter index: The index of the vfunc to return.
    /// - Returns: The `VFuncInfo` associated with the vfunc at the given index, or `nil`.
    @inlinable public func vfunc(at index: Int) -> VFuncInfo? { g_interface_info_get_vfunc(baseInfo, gint(index)).map { VFuncInfo($0) } }
    /// Return the enumeration vfuncs as a `RandomAccessCollection`.
    @inlinable public var vfuncs: VFuncs { VFuncs(self) }
    /// Find the vfunc with the given name.
    /// - Parameter name: The name of the vfunc to find.
    /// - Returns: The `VFuncInfo` associated with the vfunc with the given name, or `nil`.
    /// - Note: This method is case sensitive.
    @inlinable public func vfunc(named name: String) -> VFuncInfo? { g_interface_info_find_vfunc(baseInfo, name).map { VFuncInfo($0) } }
    /// Return the number of cases this enumeration contains.
    @inlinable public var constantCount: Int { Int(g_interface_info_get_n_constants(baseInfo)) }
    /// Return the constant at the given index
    /// - Parameter index: The index of the constant to return.
    /// - Returns: The `ConstantInfo` associated with the constant at the given index, or `nil`.
    @inlinable public func constant(at index: Int) -> ConstantInfo? { g_interface_info_get_constant(baseInfo, gint(index)).map { ConstantInfo($0) } }
    /// Return the enumeration constants as a `RandomAccessCollection`.
    @inlinable public var constants: Constants { Constants(self) }
    /// Return the C layout structure associated with this interface, or `nil`.
    @inlinable public var ifaceStruct: StructInfo? { g_interface_info_get_iface_struct(baseInfo).map { StructInfo($0) } }
}

