//
//  newWordReducer.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

func newWordReducer(action: Action, state: NewWordState?) -> NewWordState {
    var state = state ?? initNewWordState

    switch action {
    case let newWordTextChangedAction as NewWordTextChangedAction:
        state.text = newWordTextChangedAction.text
    default:
        break
    }

    return state
}
