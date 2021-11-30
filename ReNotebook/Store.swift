//
//  Store.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 29.11.2021.
//

import ReSwift

struct AppState {
    var newWord: NewWordState
    var langPicker: LangPickerState
}

func appReducer(action: Action, state: AppState?) -> AppState {
    AppState(
        newWord: newWordReducer(action: action, state: state?.newWord),
        langPicker: langPickerReducer(action: action, state: state?.langPicker)
    )
}

let store = Store(
    reducer: appReducer,
    state: initAppState,
    middleware: [loggingMiddleware]
)
