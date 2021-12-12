//
//  NewWordModel.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

protocol NewWordModel: AnyObject {

    func loadLangData()

    func updateNewWordText(_ text: String)

    func showLangPickerWith(selectedLangType: SelectedLangType)

    func sendNewWord()
}
