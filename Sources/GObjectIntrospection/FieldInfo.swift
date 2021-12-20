//
//  FieldInfo.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias FieldInfoFlags = GIFieldInfoFlags

extension FieldInfoFlags: OptionSet {}

public extension FieldInfoFlags {
    /// Field is readable
    @inlinable var isReadable: Bool { self.contains(.readable) }
    /// Field is writable
    @inlinable var isWritable: Bool { self.contains(.writable) }
    /// No flags
    static let none: FieldInfoFlags = []
    /// Indicates that this field is readable
    static let readable = GI_FIELD_IS_READABLE
    /// Indicates that this field is writable
    static let writable = GI_FIELD_IS_WRITABLE
}

/// Subclass of `BaseInfo`  containing field information
public class FieldInfo: BaseInfo {
    /// The flags for this GIFieldInfo.
    ///
    /// See `FieldInfoFlags` for possible flag values.
    @inlinable public var flags: FieldInfoFlags {
        g_field_info_get_flags(baseInfo)
    }
    /// Offset of the field within the structure.
    @inlinable public var offset: Int {
        Int(g_field_info_get_offset(baseInfo))
    }
    /// Size of the field.
    @inlinable public var size: Int {
        Int(g_field_info_get_size(baseInfo))
    }
    /// The type of the field.
    @inlinable public var typeInfo: TypeInfo {
        TypeInfo(g_field_info_get_type(baseInfo))
    }
    /// Reads a field identified by a GIFieldInfo from a C structure or union.
    ///
    /// This only handles fields of simple C types.
    /// It will fail for a field of a composite type like a nested structure
    /// or union even if that is actually readable.
    /// - Parameter memory: Pointer to a block of memory representing a C structure or union associated with the receiver.
    /// - Returns: A `GIArgument` storing the value retrieved, `nil` if unsuccessful
    @inlinable public func getField(from memory: gpointer) -> GIArgument? {
        var arg = GIArgument(v_pointer: nil)
        guard g_field_info_get_field(baseInfo, memory, &arg) != 0 else { return nil }
        return arg
    }
    /// Sets a field identified by a GIFieldInfo to a C structure or union.
    ///
    /// This only handles fields of simple C types.
    /// It will fail for a field of a composite type like a nested structure
    /// or union even if that is actually writable.
    /// - Note: This function will refuse to write fields where memory management would be required.
    /// A field with a type such as 'char *' must be set with a setter function.
    /// - Parameters:
    ///   - memory: The memory location to store the field data at
    ///   - value: The `GIArgument` value to store
    /// - Returns: `true` if successful
    @inlinable public func setField(to memory: gpointer, from value: GIArgument) -> Bool {
        var argument = value
        return g_field_info_set_field(baseInfo, memory, &argument) != 0
    }
}

