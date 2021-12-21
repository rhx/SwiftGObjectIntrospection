//
//  File.swift
//  
//
//  Created by Rene Hexel on 21/12/2021.
//
import CGObjectIntrospection

// Subclass containing struct information
public class StructInfo: RegisteredTypeInfo {
    /// Fields  Collection  type
    public struct Fields: RandomAccessCollection {
        @usableFromInline var structInfo: StructInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { structInfo.fieldCount }
        @usableFromInline init(_ structInfo: StructInfo) { self.structInfo = structInfo }
        /// Return the field at the given index
        @inlinable public subscript(position: Int) -> ValueInfo { structInfo.field(at: position)! }
    }
    /// Method enumeration Collection  type
    public struct Methods: RandomAccessCollection {
        @usableFromInline var structInfo: StructInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { structInfo.methodCount }
        @usableFromInline init(_ structInfo: StructInfo) { self.structInfo = structInfo }
        /// Return the field at the given index
        @inlinable public subscript(position: Int) -> FunctionInfo { structInfo.method(at: position)! }
    }
    /// Return the alignment of the struct
    public var alignment: Int { Int(g_struct_info_get_alignment(baseInfo)) }
    /// Return the size of the struct
    public var size: Int { Int(g_struct_info_get_size(baseInfo)) }
    /// Return true if this structure represents the "class structure"
    /// for some `GObject` or `GInterface`.
    ///
    /// This function is mainly useful to hide this kind of structure from generated public APIs.
    public var isGTypeStruct: Bool { g_struct_info_is_gtype_struct(baseInfo) != 0 }
    /// Return whether the struct info is foreign
    public var isForeign: Bool { g_struct_info_is_foreign(baseInfo) != 0 }
    /// Return the number of cases this enumeration contains.
    @inlinable public var fieldCount: Int { Int(g_struct_info_get_n_fields(baseInfo)) }
    /// Return the field at the given index
    @inlinable public func field(at index: Int) -> ValueInfo? { g_struct_info_get_field(baseInfo, gint(index)).map { ValueInfo($0) } }
    /// Return the enumeration fields as a `RandomAccessCollection`.
    @inlinable public var fields: Fields { Fields(self) }
    /// Obtain the type information for the method associated with the given `name`.
    /// - Parameter name: Name of the field to search for
    /// - Returns: The `FieldInfo` associated with the named field, or `nil`.
    @inlinable public func findField(named name: String) -> FieldInfo? { g_struct_info_find_field(baseInfo, name).map { FieldInfo($0) } }
    /// Return the number of methods this enum type has.
    @inlinable public var methodCount: Int { Int(g_struct_info_get_n_methods(baseInfo)) }
    /// Return the method at the given index
    @inlinable public func method(at index: Int) -> FunctionInfo? { g_struct_info_get_method(baseInfo, gint(index)).map { FunctionInfo($0) } }
    /// Return the methods associated with this enumeration as a `RandomAccessCollection`.
    @inlinable public var methods: Methods { Methods(self) }
    /// Obtain the type information for the method associated with the given `name`.
    /// - Parameter name: Name of the method to search for
    /// - Returns: The `FunctionInfo` associated with the named method, or `nil`.
    @inlinable public func findMethod(named name: String) -> FunctionInfo? { g_struct_info_find_method(baseInfo, name).map { FunctionInfo($0) } }
}

