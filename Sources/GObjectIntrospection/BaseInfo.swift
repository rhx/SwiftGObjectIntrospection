//
//  BaseInfo.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

/// Base class containing information about a `Repository` entry.
public class BaseInfo: CustomStringConvertible, Equatable {
    @usableFromInline
    let baseInfo: UnsafeMutablePointer<GIBaseInfo>
    
    /// Attribute iterator type
    public struct AttributeIterator: IteratorProtocol {
        @usableFromInline var iterator = GIAttributeIter(data: nil, data2: nil, data3: nil, data4: nil)
        @usableFromInline var baseInfo: BaseInfo
        @usableFromInline init(_ info: BaseInfo) { baseInfo = info }
        @inlinable mutating public func next() -> (name: String, value: String)? {
            var name: UnsafeMutablePointer<CChar>?
            var value: UnsafeMutablePointer<CChar>?
            guard g_base_info_iterate_attributes(baseInfo.baseInfo, &iterator, &name, &value) != 0,
                  let key = name, let content = value else { return nil }
            return (name: String(cString: key), value: String(cString: content))
        }
    }

    public struct AttributeSequence: Sequence {
        @usableFromInline var baseInfo: BaseInfo
        @usableFromInline init(baseInfo: BaseInfo) { self.baseInfo = baseInfo }
        @inlinable public func makeIterator() -> AttributeIterator {
            AttributeIterator(baseInfo)
        }
    }
    
    /// A textual description of the receiver
    @inlinable public var description: String { "\(namespace).\(name)" }

    /// Sequence of attributes
    @inlinable public var attributes: AttributeSequence { AttributeSequence(baseInfo: self) }

    /// Container of the receiver.
    ///
    /// The container is the parent `BaseInfo`.
    /// For instance, the parent of a `GIFunctionInfo` is an `GIObjectInfo` or `GIInterfaceInfo`.
    @inlinable public var container: BaseInfo? { g_base_info_get_container(baseInfo).map { BaseInfo($0) } }
    
    /// Return whether the receiver represents a deprecated entry
    @inlinable public var isDeprecated: Bool { g_base_info_is_deprecated(baseInfo) != 0 }

    /// The name associated with the receiver
    @inlinable public var name: String { String(cString: g_base_info_get_name(baseInfo)) }

    /// The namespace associated with the receiver
    @inlinable public var namespace: String { String(cString: g_base_info_get_namespace(baseInfo)) }

    /// Type info
    @inlinable public var type: InfoType { g_base_info_get_type(baseInfo) }

    /// Type name
    @inlinable public var typeName: String { type.description }

    /// Typeilib the receiver belongs to
    @inlinable public var typelib: Typelib { Typelib(g_base_info_get_typelib(baseInfo)) }

    /// Wrap a retained `GIBaseInfo` pointer
    /// - Parameter ptr: The pointer to wrap
    @inlinable
    public init(_ ptr: UnsafeMutablePointer<GIBaseInfo>) {
        baseInfo = ptr
    }

    /// Wrap and retain a `GIBaseInfo` pointer
    /// - Parameter ptr: The pointer to wrap
    @inlinable
    public init(retaining ptr: UnsafeMutablePointer<GIBaseInfo>) {
        baseInfo = ptr
        g_base_info_ref(baseInfo)
    }

    deinit {
        g_base_info_unref(baseInfo)
    }

    /// Return the value of the given attribute
    @inlinable public subscript(attribute: String) -> String? {
        g_base_info_get_attribute(baseInfo, attribute).map(String.init(cString:))
    }

    /// Compare two `BaseInfo`s for equality.
    ///
    /// Using pointer comparison is not practical since many functions
    /// return different instances of GIBaseInfo that refer to the same part
    /// of the TypeLib;
    /// use this operator instead to do `BaseInfo` comparisons.
    /// - Returns: `true` if equal
    @inlinable public static func == (lhs: BaseInfo, rhs: BaseInfo) -> Bool {
        g_base_info_equal(lhs.baseInfo, rhs.baseInfo) != 0
    }
    
    /// Create the relevant typed subclass for the given pointer
    /// - Parameter ptr: Pointer to the underlying info structure
    /// - Returns: a typed `BaseInfo` subclass, referencing the underlying info
    @inlinable public static func typedInfo(for ptr: UnsafeMutablePointer<GIBaseInfo>) -> BaseInfo {
        switch g_base_info_get_type(ptr) {
        case .callback: return CallbackInfo(ptr)
        case .function: return FunctionInfo(ptr)
        case .struct: return StructInfo(ptr)
        case .boxed: return BoxedInfo(ptr)
        case .enum: return EnumInfo(ptr)
        case .flags: return FlagsInfo(ptr)
        case .object: return ObjectInfo(ptr)
        case .interface: return InterfaceInfo(ptr)
        case .constant: return ConstantInfo(ptr)
        case .union: return UnionInfo(ptr)
        case .value: return ValueInfo(ptr)
        case .signal: return SignalInfo(ptr)
        case .vfunc: return VFuncInfo(ptr)
        case .property: return PropertyInfo(ptr)
        case .field: return FieldInfo(ptr)
        case .arg: return ArgInfo(ptr)
        case .type: return TypeInfo(ptr)
        default: return UnresolvedInfo(ptr)
        }
    }
}

// Subclass containing enum information
public class EnumInfo: BaseInfo {}

// Subclass containing flags information
public class FlagsInfo: EnumInfo {}

// Subclass containing function information
public class FunctionInfo: BaseInfo {}

// Subclass containing callback information
public class CallbackInfo: FunctionInfo {}

// Subclass containing boxed information
public class BoxedInfo: BaseInfo {}

// Subclass containing struct information
public class StructInfo: BoxedInfo {}

// Subclass containing union information
public class UnionInfo: BoxedInfo {}

// Subclass containing object information
public class ObjectInfo: BaseInfo {}

// Subclass containing interface information
public class InterfaceInfo: BaseInfo {}

// Subclass containing constant information
public class ConstantInfo: BaseInfo {}

// Subclass containing value information
public class ValueInfo: BaseInfo {}

// Subclass containing signal information
public class SignalInfo: BaseInfo {}

// Subclass containing virtual function information
public class VFuncInfo: BaseInfo {}

// Subclass containing property information
public class PropertyInfo: BaseInfo {}

// Subclass containing field information
public class FieldInfo: BaseInfo {}

// Subclass containing function argument information
public class ArgInfo: BaseInfo {}

// Subclass containing type information
public class TypeInfo: BaseInfo {}

// Subclass containing unresolved information
public class UnresolvedInfo: BaseInfo {}
