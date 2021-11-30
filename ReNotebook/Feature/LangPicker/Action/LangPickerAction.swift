//
//  LangPickerAction.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

struct HideLangPickerAction: Action { }

struct SelectLangAction: Action {
    let lang: Lang
    let langType: SelectedLangType
}
