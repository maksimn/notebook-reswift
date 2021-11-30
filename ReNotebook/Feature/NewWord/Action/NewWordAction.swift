//
//  NewWordAction.swift
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
