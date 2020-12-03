//
//  main.swift
//  SwiftTest
//
//  Created by 杨子江 on 11/21/20.
//  Copyright © 2020 yangzijiang. All rights reserved.
//

import Foundation

print("Hello, World!")  // 不用分号结束符

let implicitDouble = 70.0  // 创建隐式类型为Double的常数
let explicitDouble: Double = 70  // 创建显示类型为Double的常数
print(explicitDouble)

// 值永远不会隐式转换为另一种类型。如果需要将值转换为其他类型，请显式创建所需类型的实例。
let label = "The width is "
let width = 94
//let widthLabel = label + width  // 报Binary operator '+' cannot be applied to operands of type 'String' and 'Int'
let widthLabel = label + String(width)

let apples = 3
let appleSmary = "I have \(apples) apples."  // 在括号中写值，并在括号\前写反斜杠（）


