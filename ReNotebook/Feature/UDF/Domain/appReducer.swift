//
//  appReducer.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import ReSwift

func appReducer(action: Action, state: AppState?) -> AppState {
    AppState(
        newWord: newWordReducer(action: action, state: state?.newWord),
        langPicker: langPickerReducer(action: action, state: state?.langPicker)
    )
}
