//
//  newWordReducer.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

func newWordReducer(action: Action, state: NewWordState?) -> NewWordState {
    let noLang = Lang(id: Lang.Id(raw: 0), name: "", shortName: "")
    let empty = NewWordState(text: "", sourceLang: noLang, targetLang: noLang, isLangPickerHidden: true)
    var state = state ?? empty

    switch action {
    case let newWordTextChangedAction as NewWordTextChangedAction:
        state.text = newWordTextChangedAction.text
    case _ as ShowLangPickerAction:
        state.isLangPickerHidden = false
    case _ as HideLangPickerAction:
        state.isLangPickerHidden = true
    case let selectLangAction as SelectLangAction:
        if selectLangAction.langType == .source {
            state.sourceLang = selectLangAction.lang
        } else {
            state.targetLang = selectLangAction.lang
        }
    default:
        break
    }

    return state
}
