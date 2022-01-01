//
//  GeneralFunctions.swift
//  toDoList
//
//  Created by User on 01.01.2022.
//

public func printDebug(_ items: Any..., separator: String = " ", terminator: String = "\n") {
#if DEBUG
    print(items, separator: separator, terminator: terminator)
#endif
}
