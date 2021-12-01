//
//  Action.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

struct NewWordTextChangedAction: Action {
    let text: String
}

struct ShowLangPickerAction: Action {
    let selectedLangType: SelectedLangType
    let selectedLang: Lang
}

struct HideLangPickerAction: Action { }

struct SelectLangAction: Action {
    let lang: Lang
    let langType: SelectedLangType
}

struct NewWordAction: Action {
    let word: WordItem
}

struct LoadLangDataAction: Action {
    let sourceLang: Lang
    let targetLang: Lang
}
