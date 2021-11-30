//
//  LangPickerPopup.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 03.10.2021.
//

import UIKit

final class LangPickerPopup: UIView {

    let pickerView = UIPickerView()

    let selectButton = UIButton()

    let params: LangPickerPopupParams

    let langPickerController: LangPickerController

    let onFinish: (() -> Void)?

    init(params: LangPickerPopupParams,
         initialLang: Lang,
         langPickerController: LangPickerController,
         onFinish: (() -> Void)?) {
        self.params = params
        self.langPickerController = langPickerController
        self.onFinish = onFinish
        super.init(frame: .zero)
        self.backgroundColor = params.styles.backgroundColor
        layer.cornerRadius = 16
        initViews()
        select(lang: initialLang)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    private func select(lang: Lang) {
        guard let row = langPickerController.langs.firstIndex(where: { $0.id == lang.id }) else { return }

        pickerView.selectRow(row, inComponent: 0, animated: false)
    }

    @objc
    func onSelectButtonTap() {
        onFinish?()
    }
}
