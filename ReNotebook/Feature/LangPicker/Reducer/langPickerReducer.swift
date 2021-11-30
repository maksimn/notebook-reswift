//
//  langPickerReducer.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

private let lang1 = Lang(id: Lang.Id(raw: 1), name: NSLocalizedString("English", comment: ""), shortName: "EN")
private let lang2 = Lang(id: Lang.Id(raw: 2), name: NSLocalizedString("Russian", comment: ""), shortName: "RU")
private let lang4 = Lang(id: Lang.Id(raw: 4), name: NSLocalizedString("Italian", comment: ""), shortName: "IT")
private let lang5 = Lang(id: Lang.Id(raw: 5), name: NSLocalizedString("German", comment: ""), shortName: "DE")

private let initState = LangPickerState(
    isHidden: true,
    selectedLangType: .source,
    selectedLang: Lang(id: Lang.Id(raw: 1),
                       name: NSLocalizedString("English", comment: ""),
                       shortName: "EN"),
    allLangs: [lang1, lang2, lang4, lang5]
)

func langPickerReducer(action: Action, state: LangPickerState?) -> LangPickerState {
    var state = state ?? initState

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
