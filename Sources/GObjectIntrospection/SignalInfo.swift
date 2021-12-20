//
//  SignalInfo.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias SignalFlags = GSignalFlags

extension SignalFlags: OptionSet {}

public extension SignalFlags {
    /// This signal invokes the object method handler in the first emission stage.
    @inlinable var runsFirst: Bool { self.contains(.runFirst) }
    /// This signal invokes the object method handler in the third emission stage.
    @inlinable var runsLast: Bool { self.contains(.runLast) }
    /// This signal invokes the object method handler in the cleanup stage.
    @inlinable var runsOnCleanup: Bool { self.contains(.runCleanup) }
    /// `true` if signals being emitted for an object while currently being emitted
    /// for this very object will not be emitted recursively,
    /// but instead cause the first emission to be restarted.
    @inlinable var noRecurse: Bool { self.contains(.noRecurse) }
    /// Signal supports `::detail` appendices.
    @inlinable var isDetailed: Bool { self.contains(.detailed) }
    /// This signal is an action signal.
    @inlinable var isAction: Bool { self.contains(.action) }
    /// This signal does not support hooks.
    @inlinable var doesNotSupportHooks: Bool { self.contains(.noHooks) }
    /// Varargs signal emission will always collect the arguments
    @inlinable var willCollect: Bool { self.contains(.mustCollect) }
    /// Return whether this signal is deprecated.
    @inlinable var isDeprecated: Bool { self.contains(.deprecated) }
    /// No signal hints
    static let none: SignalFlags = []
    /// Invoke the object method handler in the first emission stage.
    static let runFirst = G_SIGNAL_RUN_FIRST
    /// Invoke the object method handler in the third emission stage.
    static let runLast = G_SIGNAL_RUN_LAST
    /// Invoke the object method handler in the cleanup stage.
    static let runCleanup = G_SIGNAL_RUN_CLEANUP
    /// Signals being emitted for an object while currently being emitted
    /// for this very object will not be emitted recursively,
    /// but instead cause the first emission to be restarted.
    static let noRecurse = G_SIGNAL_NO_RECURSE
    /// This signal supports `::detail` appendices to the signal name
    /// upon handler connections and emissions.
    static let detailed = G_SIGNAL_DETAILED
    /// Action signals are signals that may freely be emitted on alive objects
    /// from user code via `g_signal_emit()` and friends,
    /// without the need of being embedded into extra code that performs
    /// pre or post emission adjustments on the object.
    ///
    /// - Note: Action signals also be thought of as object methods that can be called generically by third-party code.
    static let action = G_SIGNAL_ACTION
    /// No emission hooks are supported for this signal.
    static let noHooks = G_SIGNAL_NO_HOOKS
    /// Varargs signal emission will always collect the arguments,
    /// even if there are no handlers connected.
    static let mustCollect = G_SIGNAL_MUST_COLLECT
    /// This signal is deprecated and should not be used.
    static let deprecated = G_SIGNAL_DEPRECATED
}

// Subclass containing signal information
public class SignalInfo: BaseInfo {
    /// Return the flags for the signal
    @inlinable public var flags: SignalFlags { g_signal_info_get_flags(baseInfo) }
    /// Return the class closure
    @inlinable public var classClosure: VFuncInfo? { g_signal_info_get_class_closure(baseInfo).map { VFuncInfo($0) } }
    /// Return whether returning `true` in the signal handler will stop signal emission
    @inlinable public var stopsEmission: Bool { g_signal_info_true_stops_emit(baseInfo) != 0 }
}
