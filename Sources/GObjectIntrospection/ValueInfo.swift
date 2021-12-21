//
//  ValueInfo.swift
//  
//
//  Created by Rene Hexel on 21/12/2021.
//
import CGObjectIntrospection

// Subclass representing enum value information
public class ValueInfo: BaseInfo {
    public var value: Int { Int(g_value_info_get_value(baseInfo)) }
}
