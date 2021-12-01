//
//  LangPickerModel.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

protocol LangPickerModel: AnyObject {

    func selectLang(_ lang: Lang)

    func hideLangPicker()
}
