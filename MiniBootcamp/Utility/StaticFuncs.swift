//
//  StaticFuncs.swift
//  Mini bootcamp
//
//  Created by Abner Castro on 07/04/22.
//

import Foundation

func create<T: NSObject>(setup: (T) -> ()) -> T {
    let obj = T()
    setup(obj)
    return obj
}
