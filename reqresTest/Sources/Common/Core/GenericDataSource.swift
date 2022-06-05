//
//  GenericDataSource.swift
//  reqresTest
//
//  Created by Eric Ertl on 05/06/2022.
//

import Foundation

class GenericDataSource<T> : NSObject {
    var data: DynamicValue<[T]> = DynamicValue([])
}
