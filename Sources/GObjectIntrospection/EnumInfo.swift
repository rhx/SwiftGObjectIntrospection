//
//  EnumInfo.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias TypeTag = GITypeTag

public extension TypeTag {
    /// The `void` type
    static let void = GI_TYPE_TAG_VOID
    /// The `boolean` type
    static let boolean = GI_TYPE_TAG_BOOLEAN
    /// The 8-bit signed integer type
    static let int8 = GI_TYPE_TAG_INT8
    /// The 8-bit unsigned integer type
    static let uint8 = GI_TYPE_TAG_UINT8
    /// The 16-bit signed integer type
    static let int16 = GI_TYPE_TAG_INT16
    /// The 16-bit unsigned integer type
    static let uint16 = GI_TYPE_TAG_UINT16
    /// The 32-bit signed integer type
    static let int32 = GI_TYPE_TAG_INT32
    /// The 32-bit unsigned integer type
    static let uint32 = GI_TYPE_TAG_UINT32
    /// The 64-bit signed integer type
    static let int64 = GI_TYPE_TAG_INT64
    /// The 64-bit unsigned integer type
    static let uint64 = GI_TYPE_TAG_UINT64
    /// The 32-bit floating point type
    static let float = GI_TYPE_TAG_FLOAT
    /// The 64-bit floating point type
    static let double = GI_TYPE_TAG_DOUBLE
    /// A `GType`
    static let gtype = GI_TYPE_TAG_GTYPE
    /// A `utf8` string
    static let utf8 = GI_TYPE_TAG_UTF8
    /// A file name
    static let filename = GI_TYPE_TAG_FILENAME
    /// An array
    static let array = GI_TYPE_TAG_ARRAY
    /// An extended interface object
    static let interface = GI_TYPE_TAG_INTERFACE
    /// A `GList`
    static let glist = GI_TYPE_TAG_GLIST
    /// A `GSList`
    static let gslist = GI_TYPE_TAG_GSLIST
    /// A `GHashTable`
    static let ghash = GI_TYPE_TAG_GHASH
    /// A `GError`
    static let error = GI_TYPE_TAG_ERROR
    /// A Unicode character
    static let unichar = GI_TYPE_TAG_UNICHAR
}

// Subclass of `RegisteredTypeInfo` containing enum information
public class EnumInfo: RegisteredTypeInfo {
    /// Enumeration Value  Collection  type
    public struct Values: RandomAccessCollection {
        @usableFromInline var enumInfo: EnumInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { enumInfo.valueCount }
        @usableFromInline init(_ enumInfo: EnumInfo) { self.enumInfo = enumInfo }
        /// Return the value at the given index
        @inlinable public subscript(position: Int) -> ValueInfo { enumInfo.value(at: position)! }
    }
    /// Method enumeration Collection  type
    public struct Methods: RandomAccessCollection {
        @usableFromInline var enumInfo: EnumInfo
        public let startIndex = 0
        @inlinable public var endIndex: Int { enumInfo.methodCount }
        @usableFromInline init(_ enumInfo: EnumInfo) { self.enumInfo = enumInfo }
        /// Return the value at the given index
        @inlinable public subscript(position: Int) -> FunctionInfo { enumInfo.method(at: position)! }
    }
    /// Return the number of cases this enumeration contains.
    @inlinable public var valueCount: Int { Int(g_enum_info_get_n_values(baseInfo)) }
    /// Return the value at the given index
    /// - Parameter index: The index of the value to return.
    /// - Returns: The `ValueInfo` associated with the value at the given index, or `nil`.
    @inlinable public func value(at index: Int) -> ValueInfo? { g_enum_info_get_value(baseInfo, gint(index)).map { ValueInfo($0) } }
    /// Return the enumeration values as a `RandomAccessCollection`.
    @inlinable public var values: Values { Values(self) }
    /// Return the number of methods this enum type has.
    @inlinable public var methodCount: Int { Int(g_enum_info_get_n_methods(baseInfo)) }
    /// Return the method at the given index
    /// - Parameter index: The index of the method to return.
    /// - Returns: The `FunctionInfo` associated with the method at the given index, or `nil`.
    @inlinable public func method(at index: Int) -> FunctionInfo? { g_enum_info_get_method(baseInfo, gint(index)).map { FunctionInfo($0) } }
    /// Return the methods associated with this enumeration as a `RandomAccessCollection`.
    @inlinable public var methods: Methods { Methods(self) }
    /// Return the tag of the type used for the enum in the C ABI.
    /// This will be a signed or unsigned integral type.
    /// - Note:  in the current implementation the width of the type is computed correctly, but the signed or unsigned nature of the type may not match the sign of the type used by the C compiler.
    @inlinable public var storageType: TypeTag { g_enum_info_get_storage_type(baseInfo) }
    /// String form of the quark for the error domain associated with this enum, if any.
    @inlinable public var errorDomain: String? { g_enum_info_get_error_domain(baseInfo).map { String(cString: $0) } }
}

