//
//  Tagged.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

struct Tagged<Tag, RawValue: Equatable>: Equatable {

    let raw: RawValue

    static func == (_ lhs: Tagged, _ rhs: Tagged) -> Bool {
        lhs.raw == rhs.raw
    }
}
