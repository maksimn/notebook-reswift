//
//  Lang.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

struct Lang: Equatable {

    typealias Id = Tagged<Lang, Int>

    let id: Id
    let name: String
    let shortName: String

    static func == (lhs: Lang, rhs: Lang) -> Bool {
        lhs.id == rhs.id
    }
}
