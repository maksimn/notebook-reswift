//
//  newWordReducer.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

private let defaultSourceLang = Lang(id: Lang.Id(raw: 1),
                                     name: NSLocalizedString("English", comment: ""),
                                     shortName: "EN")
private let defaultTargetLang = Lang(id: Lang.Id(raw: 2),
                                     name: NSLocalizedString("Russian", comment: ""),
                                     shortName: "RU")
private let initNewWordState = NewWordState(text: "",
                                            sourceLang: defaultSourceLang,
                                            targetLang: defaultTargetLang,
                                            isLangPickerHidden: true)

func newWordReducer(action: Action, state: NewWordState?) -> NewWordState {
    var state = state ?? initNewWordState

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
