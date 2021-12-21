//
//  UnionInfo.swift
//  
//
//  Created by Rene Hexel on 21/12/2021.
//
import CGObjectIntrospection

// Subclass of `RegisteredTypeInfo` containing information about a `union`
public class UnionInfo: RegisteredTypeInfo {
    /// Fields  Collection  type
    public struct Fields: RandomAccessCollection {
        @usableFromInline var unionInfo: UnionInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { unionInfo.fieldCount }
        @usableFromInline init(_ unionInfo: UnionInfo) { self.unionInfo = unionInfo }
        /// Return the field at the given index
        @inlinable public subscript(position: Int) -> ValueInfo { unionInfo.field(at: position)! }
    }
    /// Method enumeration Collection  type
    public struct Methods: RandomAccessCollection {
        @usableFromInline var unionInfo: UnionInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { unionInfo.methodCount }
        @usableFromInline init(_ unionInfo: UnionInfo) { self.unionInfo = unionInfo }
        /// Return the field at the given index
        @inlinable public subscript(position: Int) -> FunctionInfo { unionInfo.method(at: position)! }
    }
    /// Return the number of cases this enumeration contains.
    @inlinable public var fieldCount: Int { Int(g_union_info_get_n_fields(baseInfo)) }
    /// Return the field at the given index
    @inlinable public func field(at index: Int) -> ValueInfo? { g_union_info_get_field(baseInfo, gint(index)).map { ValueInfo($0) } }
    /// Return the enumeration fields as a `RandomAccessCollection`.
    @inlinable public var fields: Fields { Fields(self) }
    /// Return the number of methods this enum type has.
    @inlinable public var methodCount: Int { Int(g_union_info_get_n_methods(baseInfo)) }
    /// Return the method at the given index
    @inlinable public func method(at index: Int) -> FunctionInfo? { g_union_info_get_method(baseInfo, gint(index)).map { FunctionInfo($0) } }
    /// Return the methods associated with this enumeration as a `RandomAccessCollection`.
    @inlinable public var methods: Methods { Methods(self) }
    /// Return `true` if this union contains a discriminator field.
    @inlinable public var isDiscriminated: Bool { g_union_info_is_discriminated(baseInfo) != 0 }
    /// Return the offset of the discriminator.
    /// - Note: This is only valid if `isDiscriminated` is `true`.
    @inlinable public var discriminatorOffset: Int { Int(g_union_info_get_discriminator_offset(baseInfo)) }
    /// Return the discriminator type.
    /// - Note: This is only valid if `isDiscriminated` is `true`.
    @inlinable public var discriminatorType: TypeInfo { TypeInfo(g_union_info_get_discriminator_type(baseInfo)) }
    /// Obtain discriminator value assigned for n-th union field,
    /// i.e. n-th union field is the active one if the discriminator
    /// contains this constant.
    /// - Note: This is only valid if `isDiscriminated` is `true`.
    /// - Parameter index: The constant at the given index
    /// - Returns: The discriminator value assigned for the union field at the given index.
    @inlinable public func getDiscriminator(at index: Int) -> ConstantInfo? { ConstantInfo(g_union_info_get_discriminator(baseInfo, gint(index))) }
    /// Return the total union size.
    @inlinable public var size: Int { Int(g_union_info_get_size(baseInfo)) }
    /// Return the alignment of the union.
    @inlinable public var alignment: Int { Int(g_union_info_get_alignment(baseInfo)) }
    /// Obtain the type information for the method associated with the given `name`.
    /// - Parameter name: Name of the method to search for
    /// - Returns: The `FunctionInfo` associated with the named method, or `nil`.
    @inlinable public func findMethod(named name: String) -> FunctionInfo? { g_union_info_find_method(baseInfo, name).map { FunctionInfo($0) } }
}

