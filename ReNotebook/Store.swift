//
//  Store.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 29.11.2021.
//

import ReSwift

struct AppState {

}

func appReducer(action: Action, state: AppState?) -> AppState {
    return AppState()
}

let store = Store(
    reducer: appReducer,
    state: AppState(),
    middleware: []
)
