//
//  ObjectInfo.swift
//  
//
//  Created by Rene Hexel on 21/12/2021.
//
import CGObjectIntrospection

// Subclass containing object information
public class ObjectInfo: RegisteredTypeInfo {
    /// Interface Interface Collection type
    public struct Interfaces: RandomAccessCollection {
        @usableFromInline var objectInfo: ObjectInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { objectInfo.interfaceCount }
        @usableFromInline init(_ objectInfo: ObjectInfo) { self.objectInfo = objectInfo }
        /// Return the interface at the given index
        @inlinable public subscript(position: Int) -> BaseInfo { objectInfo.interface(at: position)! }
    }
    /// Method enumeration Collection type
    public struct Methods: RandomAccessCollection {
        @usableFromInline var objectInfo: ObjectInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { objectInfo.methodCount }
        @usableFromInline init(_ objectInfo: ObjectInfo) { self.objectInfo = objectInfo }
        /// Return the method at the given index
        @inlinable public subscript(position: Int) -> FunctionInfo { objectInfo.method(at: position)! }
    }
    /// Properties Collection type
    public struct Properties: RandomAccessCollection {
        @usableFromInline var objectInfo: ObjectInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { objectInfo.propertyCount }
        @usableFromInline init(_ objectInfo: ObjectInfo) { self.objectInfo = objectInfo }
        /// Return the property at the given index
        @inlinable public subscript(position: Int) -> PropertyInfo { objectInfo.property(at: position)! }
    }
    /// Signal enumeration Collection type
    public struct Signals: RandomAccessCollection {
        @usableFromInline var objectInfo: ObjectInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { objectInfo.signalCount }
        @usableFromInline init(_ objectInfo: ObjectInfo) { self.objectInfo = objectInfo }
        /// Return the signal at the given index
        @inlinable public subscript(position: Int) -> SignalInfo { objectInfo.signal(at: position)! }
    }
    /// VFunc enumeration Collection type
    public struct VFuncs: RandomAccessCollection {
        @usableFromInline var objectInfo: ObjectInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { objectInfo.vfuncCount }
        @usableFromInline init(_ objectInfo: ObjectInfo) { self.objectInfo = objectInfo }
        /// Return the vfunc at the given index
        @inlinable public subscript(position: Int) -> VFuncInfo { objectInfo.vfunc(at: position)! }
    }
    /// Enumeration Constant Collection type
    public struct Constants: RandomAccessCollection {
        @usableFromInline var objectInfo: ObjectInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { objectInfo.constantCount }
        @usableFromInline init(_ objectInfo: ObjectInfo) { self.objectInfo = objectInfo }
        /// Return the constant at the given index
        @inlinable public subscript(position: Int) -> ConstantInfo { objectInfo.constant(at: position)! }
    }
    /// Return whether this object type is an abstract type,
    /// i.e. if it cannot be instantiated
    @inlinable public var isAbstract: Bool { g_object_info_get_abstract(baseInfo) != 0 }
    /// Return if the object type is of a fundamental type
    /// which is not `G_TYPE_OBJECT`.
    /// - Note: this is mostly for supporting `GstMiniObject`
    @inlinable public var isFundamental: Bool { g_object_info_get_fundamental(baseInfo) != 0 }
    /// Return whether this object is a final type,
    /// i.e. if it cannot be subclassed
    @inlinable public var isFinal: Bool { g_object_info_get_final(baseInfo) != 0 }
    /// Return the parent type of this object type, or `nil`.
    @inlinable public var parentType: ObjectInfo? { g_object_info_get_parent(baseInfo).map { ObjectInfo($0) } }
    /// Return the name of the object's class/type
    @inlinable public var className: String { String(cString: g_object_info_get_type_name(baseInfo)) }
    /// Return the name of the type initialiser function for this type
    @inlinable public var typeInitName: String { String(cString: g_object_info_get_type_init(baseInfo)) }
    /// Obtain the symbol name of the function that should be called
    /// to increment the reference count for an object of this type.
    ///
    /// This is mainly used for fundamental types.
    /// The type signature for the symbol is `GIObjectInfoRefFunction`,
    /// to fetch the function pointer see `refFunctionPointer`.
    @inlinable public var refFunctionName: String? { g_object_info_get_ref_function(baseInfo).map { String(cString: $0) } }
    /// Obtain the symbol name of the function that should be called
    /// to decrement the reference count for an object of this type.
    ///
    /// This is mainly used for fundamental types.
    /// The type signature for the symbol is `GIObjectInfoUnrefFunction`,
    /// to fetch the function pointer see `unrefFunctionPointer`.
    @inlinable public var unrefFunctionName: String? { g_object_info_get_unref_function(baseInfo).map { String(cString: $0) } }
    /// Obtain the symbol name of the function that should be called
    /// to set a GValue containing an object instance pointer.
    ///
    /// This is mainly used for fundamental types.
    /// The type signature for the symbol is `GIObjectInfoSetValueFunction`,
    /// to fetch the function pointer see `setValueFunctionPointer`.
    @inlinable public var setValueFunctionName: String? { g_object_info_get_set_value_function(baseInfo).map { String(cString: $0) } }
    /// Obtain the symbol name of the function that should be called
    /// to convert an object instance pointer of this type to a `GValue`.
    ///
    /// This is mainly used for fundamental types.
    /// The type signature for the symbol is `GIObjectInfoGetValueFunction`,
    /// to fetch the function pointer see `getValueFunctionPointer`.
    @inlinable public var getValueFunctionName: String? { g_object_info_get_get_value_function(baseInfo).map { String(cString: $0) } }
    /// Return a pointer to the function used to increment the reference count
    /// for an instance of this type.
    @inlinable public var refFunctionPointer: GIObjectInfoRefFunction? { g_object_info_get_ref_function_pointer(baseInfo) }
    /// Return a pointer to the function used to decrement the reference count
    /// for an instance of this type.
    @inlinable public var unrefFunctionPointer: GIObjectInfoUnrefFunction? { g_object_info_get_unref_function_pointer(baseInfo) }
    /// Return a pointer to the function used to set a GValue containing an
    /// instance pointer for an instance of this type.
    @inlinable public var setValueFunctionPointer: GIObjectInfoSetValueFunction? { g_object_info_get_set_value_function_pointer(baseInfo) }
    /// Return a pointer to the function used to convert an instance pointer
    /// of this type to a GValue.
    @inlinable public var getValueFunctionPointer: GIObjectInfoGetValueFunction? { g_object_info_get_get_value_function_pointer(baseInfo) }
    /// Return the number of cases this interface contains.
    @inlinable public var interfaceCount: Int { Int(g_object_info_get_n_interfaces(baseInfo)) }
    /// Return the interface at the given index
    /// - Parameter index: The index of the interface to return.
    /// - Returns: The `SignalInfo` associated with the interface at the given index, or `nil`.
    @inlinable public func interface(at index: Int) -> BaseInfo? { g_object_info_get_interface(baseInfo, gint(index)).map { SignalInfo($0) } }
    /// Return the interface interfaces as a `RandomAccessCollection`.
    @inlinable public var interfaces: Interfaces { Interfaces(self) }
    /// Return the number of methods this interface type has.
    @inlinable public var methodCount: Int { Int(g_object_info_get_n_methods(baseInfo)) }
    /// Return the method at the given index
    /// - Parameter index: The index of the method to return.
    /// - Returns: The `FunctionInfo` associated with the method at the given index, or `nil`.
    @inlinable public func method(at index: Int) -> FunctionInfo? { g_object_info_get_method(baseInfo, gint(index)).map { FunctionInfo($0) } }
    /// Return the methods associated with this enumeration as a `RandomAccessCollection`.
    @inlinable public var methods: Methods { Methods(self) }
    /// Find the method with the given name.
    /// - Parameter name: The name of the method to find.
    /// - Returns: The `FunctionInfo` associated with the method with the given name, or `nil`.
    /// - Note: This method is case sensitive.
    @inlinable public func findMethod(named name: String) -> FunctionInfo? { g_object_info_find_method(baseInfo, name).map { FunctionInfo($0) } }
    /// Obtain a method of the object given a name,
    /// searching both the object info and any interfaces it implements.
    ///
    /// `nil` will be returned if there is no method available with that name.
    ///
    /// - Note: this function does *not* search parent classes; you will have to chain up if that is desired.
    /// - Parameter name: The name of the method to find.
    /// - Parameter implementor: The implementor of the interface.
    /// - Returns: A tuple containing the `FunctionInfo` associated with the method as well as an ObjectInfo referencing the implementor, or `nil`.
    @inlinable public func findMethodUsingInterface(forName name: String) -> (FunctionInfo, ObjectInfo?)? {
        var implementor: UnsafeMutablePointer<GIObjectInfo>?
        guard let method = g_object_info_find_method_using_interfaces(baseInfo, name, &implementor) else { return nil }
        return (FunctionInfo(method), implementor.map { ObjectInfo($0) })
    }
    /// Return the properties this interface type has.
    @inlinable public var properties: Properties { Properties(self) }
    /// Return the number of methods this enum type has.
    @inlinable public var propertyCount: Int { Int(g_object_info_get_n_properties(baseInfo)) }
    /// Return the method at the given index
    /// - Parameter index: The index of the method to return.
    /// - Returns: The `FunctionInfo` associated with the method at the given index, or `nil`.
    @inlinable public func property(at index: Int) -> PropertyInfo? { g_object_info_get_property(baseInfo, gint(index)).map { PropertyInfo($0) } }
    /// Return the number of cases this enumeration contains.
    @inlinable public var signalCount: Int { Int(g_object_info_get_n_signals(baseInfo)) }
    /// Return the signal at the given index
    /// - Parameter index: The index of the signal to return.
    /// - Returns: The `SignalInfo` associated with the signal at the given index, or `nil`.
    @inlinable public func signal(at index: Int) -> SignalInfo? { g_object_info_get_signal(baseInfo, gint(index)).map { SignalInfo($0) } }
    /// Return the enumeration signals as a `RandomAccessCollection`.
    @inlinable public var signals: Signals { Signals(self) }
    /// Find the signal with the given name.
    /// - Parameter name: The name of the signal to find.
    /// - Returns: The `SignalInfo` associated with the signal with the given name, or `nil`.
    /// - Note: This method is case sensitive.
    @inlinable public func findSignal(named name: String) -> SignalInfo? { g_object_info_find_signal(baseInfo, name).map { SignalInfo($0) } }
    /// Return the number of cases this enumeration contains.
    @inlinable public var vfuncCount: Int { Int(g_object_info_get_n_vfuncs(baseInfo)) }
    /// Return the vfunc at the given index
    /// - Parameter index: The index of the vfunc to return.
    /// - Returns: The `VFuncInfo` associated with the vfunc at the given index, or `nil`.
    @inlinable public func vfunc(at index: Int) -> VFuncInfo? { g_object_info_get_vfunc(baseInfo, gint(index)).map { VFuncInfo($0) } }
    /// Return the enumeration vfuncs as a `RandomAccessCollection`.
    @inlinable public var vfuncs: VFuncs { VFuncs(self) }
    /// Find the vfunc with the given name.
    /// - Parameter name: The name of the vfunc to find.
    /// - Returns: The `VFuncInfo` associated with the vfunc with the given name, or `nil`.
    /// - Note: This method is case sensitive.
    @inlinable public func findVFunc(named name: String) -> VFuncInfo? { g_object_info_find_vfunc(baseInfo, name).map { VFuncInfo($0) } }
    /// Locate a virtual function slot with name `name`,
    /// searching both the object info and any interfaces it implements.
    ///
    /// The namespace for virtuals is distinct from that of methods;
    /// there may or may not be a concrete method associated for a virtual.
    /// If there is one, it may be retrieved using `get_invoker()`,
    /// otherwise `nil` will be returned.
    /// - Note: this function does *not* search parent classes; you will have to chain up if that's desired.
    /// - Parameter name: The name of the virtual function to find
    /// - Returns: A tuple containing the `VFuncInfo` associated with the virtual function as well as an ObjectInfo referencing the implementor, or `nil`.
    @inlinable public func findVFuncUsingInterface(forName name: String) -> (VFuncInfo, ObjectInfo?)? {
        var implementor: UnsafeMutablePointer<GIObjectInfo>?
        guard let vfunc = g_object_info_find_vfunc_using_interfaces(baseInfo, name, &implementor) else { return nil }
        return (VFuncInfo(vfunc), implementor.map { ObjectInfo($0) })
    }
    /// Return the number of cases this enumeration contains.
    @inlinable public var constantCount: Int { Int(g_object_info_get_n_constants(baseInfo)) }
    /// Return the constant at the given index
    /// - Parameter index: The index of the constant to return.
    /// - Returns: The `ConstantInfo` associated with the constant at the given index, or `nil`.
    @inlinable public func constant(at index: Int) -> ConstantInfo? { g_object_info_get_constant(baseInfo, gint(index)).map { ConstantInfo($0) } }
    /// Return the enumeration constants as a `RandomAccessCollection`.
    @inlinable public var constants: Constants { Constants(self) }
    /// Return the C layout structure associated with this interface, or `nil`.
    @inlinable public var classStruct: StructInfo? { g_object_info_get_class_struct(baseInfo).map { StructInfo($0) } }
}

