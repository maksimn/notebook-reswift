//
//  NewWordAction.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

struct ShowNewWordEditorAction: Action { }

struct NewWordTextChangedAction: Action {
    let text: String
}
