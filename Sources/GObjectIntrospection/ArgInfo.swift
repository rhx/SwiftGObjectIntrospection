//
//  ArgInfo.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias Direction = GIDirection
public typealias ScopeType = GIScopeType
public typealias Transfer = GITransfer

public extension Direction {
    /// Return true if the direction is input
    @inlinable var isInput: Bool { self == .in }
    /// Return true if the direction is output
    @inlinable var isOutput: Bool { self == .out }
    /// Return true if the direction is input and output
    @inlinable var isInOut: Bool { self == .inout }

    /// Input argument
    static let `in` = GI_DIRECTION_IN
    /// Output argument
    static let out = GI_DIRECTION_OUT
    /// Input and output argument
    static let `inout` = GI_DIRECTION_INOUT
}

public extension ScopeType {
    /// Returns true if the scope is call
    @inlinable var isCall: Bool { self == .call }
    /// Returns true if the scope is notify
    @inlinable var isNotify: Bool { self == .notified }
    /// Returns true if the scope is asychronous
    /// (i.e. call or notify)
    /// - Note: This is a convenience property
    @inlinable var isAsync: Bool { self == .call || self == .notified }

    /// Scope type for invalid scope
    static let invalid = GI_SCOPE_TYPE_INVALID
    /// Scope type for call
    static let call = GI_SCOPE_TYPE_CALL
    /// Scope type for notified
    static let notified = GI_SCOPE_TYPE_NOTIFIED
}

public extension Transfer {
    /// Returns true if nothing is transferred.
    ///
    /// If `true`, ransfer nothing from the callee (function or the type
    /// instance the property belongs to) to the caller. The callee retains the
    /// ownership of the transfer and the caller doesn't need to do anything to free
    /// up the resources of this transfer.
    @inlinable var isNone: Bool { self == .none }
    /// Returns true if the transfer is container-scoped
    ///
    /// If `true`, transfer the container (list, array, hash table) from
    /// the callee to the caller. The callee retains the ownership of the individual
    /// items in the container and the caller has to free up the container resources
    /// (g_list_free()/g_hash_table_destroy() etc) of this transfer
    @inlinable var isContainer: Bool { self == .container }
    /// Returns true if the transfer is a full transfer, i.e.
    /// transfer everything, eg the container and its
    /// contents from the callee to the caller. This is the case when the callee
    /// creates a copy of all the data it returns. The caller is responsible for
    /// cleaning up the container and item resources of this transfer.
    @inlinable var isFull: Bool { self == .everything }

    /// Transfer type for no transfer
    ///
    /// Transfer nothing from the callee (function or the type
    /// instance the property belongs to) to the caller. The callee retains the
    /// ownership of the transfer and the caller doesn't need to do anything to free
    /// up the resources of this transfer.
    static let none = GI_TRANSFER_NOTHING
    /// Transfer type for containers
    ///
    /// Transfer the container (list, array, hash table) from
    /// the callee to the caller. The callee retains the ownership of the individual
    /// items in the container and the caller has to free up the container resources
    /// (g_list_free()/g_hash_table_destroy() etc) of this transfer
    static let container = GI_TRANSFER_CONTAINER
    /// Transfer type for full transfer
    ///
    /// Transfer everything, eg the container and its
    /// contents from the callee to the caller. This is the case when the callee
    /// creates a copy of all the data it returns. The caller is responsible for
    /// cleaning up the container and item resources of this transfer.
    static let everything = GI_TRANSFER_EVERYTHING
}

// Subclass containing function argument information
public class ArgInfo: BaseInfo {
    // Index of the user data argument for a closure
    @inlinable public var closureIndex: Int? {
        let rv = g_arg_info_get_closure(baseInfo)
        return rv == -1 ? nil : Int(rv)
    }

    // Index of the `GDestroyNotify` argument for a closure
    @inlinable public var destroyIndex: Int? {
        let rv = g_arg_info_get_destroy(baseInfo)
        return rv == -1 ? nil : Int(rv)
    }

    // Return whether the argument is optional
    @inlinable public var optional: Bool {
        g_arg_info_is_optional(baseInfo) != 0
    }

    // Return whether the argument is a transfer
    @inlinable public var transfer: Bool {
        g_arg_info_is_caller_allocates(baseInfo) != 0
    }

    // Direction of the argument
    @inlinable public var direction: Direction {
        g_arg_info_get_direction(baseInfo)
    }

    // Scope of the argument
    @inlinable public var scope: ScopeType {
        g_arg_info_get_scope(baseInfo)
    }

    // Ownership of the argument
    @inlinable public var ownership: Transfer {
        g_arg_info_get_ownership_transfer(baseInfo)
    }

    // Type of the argument
    @inlinable public var typeInfo: TypeInfo {
        TypeInfo(g_arg_info_get_type(baseInfo))
    }

    // Indicate whether the type of the argument is nullable
    @inlinable public var isNullable: Bool {
        g_arg_info_may_be_null(baseInfo) != 0
    }

    // Indicate whether the argument is caller-allocated
    @inlinable public var isCallerAllocated: Bool {
        g_arg_info_is_caller_allocates(baseInfo) != 0
    }

    // Indicate whether the argument is optional
    @inlinable public var isOptional: Bool {
        g_arg_info_is_optional(baseInfo) != 0
    }

    /// Indicatee whether this is a return value argument
    @inlinable public var isReturnValue: Bool {
        g_arg_info_is_return_value(baseInfo) != 0
    }

    /// Indicate whether this argument is only useful in C
    @inlinable public var isSkip: Bool {
        g_arg_info_is_skip(baseInfo) != 0
    }

    /// Obtain information about a the type of given argument info
    ///
    /// This function is a variant of `typeInfo` designed for stack allocation.
    /// The initialized type must not be referenced after info is deallocated.
    /// - Parameter type: Type information about the receiver
    @inlinable public func loadType(_ type: TypeInfo) {
        g_arg_info_load_type(baseInfo, type.baseInfo)
    }
}

