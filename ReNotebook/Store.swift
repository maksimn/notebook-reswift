//
//  Store.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 29.11.2021.
//

import ReSwift

struct AppState {
    var newWord: NewWordState
}

func appReducer(action: Action, state: AppState?) -> AppState {
    AppState(newWord: newWordReducer(action: action, state: state?.newWord))
}

let store = Store(
    reducer: appReducer,
    state: nil,
    middleware: [loggingMiddleware]
)
