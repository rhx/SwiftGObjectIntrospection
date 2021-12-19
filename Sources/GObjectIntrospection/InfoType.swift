//
//  InfoType.swift
//  
//
//  Created by Rene Hexel on 20/12/2021.
//
import CGObjectIntrospection

public typealias InfoType = GIInfoType

extension InfoType: CustomStringConvertible {
    /// Return the string representation of the receiver
    public var description: String { String(cString: g_info_type_to_string(self)) }
}
