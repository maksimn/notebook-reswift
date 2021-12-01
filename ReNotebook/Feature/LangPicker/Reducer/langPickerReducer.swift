//
//  langPickerReducer.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

func langPickerReducer(action: Action, state: LangPickerState?) -> LangPickerState {
    let empty = LangPickerState(selectedLangType: .source, selectedLang: nil)
    var state = state ?? empty

    switch action {
    case let showLangPickerAction as ShowLangPickerAction:
        state.selectedLangType = showLangPickerAction.selectedLangType
        state.selectedLang = showLangPickerAction.selectedLang
    case let selectLangAction as SelectLangAction:
        state.selectedLang = selectLangAction.lang
        state.selectedLangType = selectLangAction.langType
    default:
        break
    }

    return state
}
