//
//  Weak.swift
//  OtterScaleiOS
//
//  Created by Андрей Чернышев on 19.01.2022.
//

final class Weak<T> {
    weak private var value: AnyObject?
    
    var weak: T? {
        return value as? T
    }
    
    init<T: AnyObject>(_ value: T) {
        self.value = value
    }
}
