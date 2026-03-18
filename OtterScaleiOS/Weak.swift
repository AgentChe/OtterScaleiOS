//
//  Weak.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 19.01.2022.
//

final class Weak<T: AnyObject> {
    weak private var value: T?
    
    var weak: T? {
        return value
    }
    
    init(_ value: T) {
        self.value = value
    }
}
