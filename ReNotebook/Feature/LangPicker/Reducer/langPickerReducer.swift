//
//  langPickerReducer.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

func langPickerReducer(action: Action, state: LangPickerState?) -> LangPickerState {
    let empty = LangPickerState(isHidden: true, selectedLangType: .source,
                                selectedLang: Lang(id: Lang.Id(raw: 0), name: "", shortName: ""), allLangs: [])
    var state = state ?? empty

    switch action {
    case let showLangPickerAction as ShowLangPickerAction:
        state.isHidden = false
        state.selectedLangType = showLangPickerAction.selectedLangType
        state.selectedLang = showLangPickerAction.selectedLang
    case let selectLangAction as SelectLangAction:
        state.selectedLang = selectLangAction.lang
    case _ as HideLangPickerAction:
        state.isHidden = true
    default:
        break
    }

    return state
}
