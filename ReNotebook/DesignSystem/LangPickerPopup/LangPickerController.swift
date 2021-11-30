//
//  PickerController.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 30.09.2021.
//

import UIKit

final class LangPickerController: NSObject, UIPickerViewDataSource, UIPickerViewDelegate {

    let langs: [Lang]

    let onSelectLang: ((Lang) -> Void)?

    init(langs: [Lang], onSelectLang: ((Lang) -> Void)?) {
        self.langs = langs
        self.onSelectLang = onSelectLang
    }

    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        1
    }

    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        langs.count
    }

    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        langs[row].name
    }

    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        onSelectLang?(langs[row])
    }
}
