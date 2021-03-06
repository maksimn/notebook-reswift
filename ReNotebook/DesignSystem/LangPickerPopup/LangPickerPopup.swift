//
//  LangPickerPopup.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 03.10.2021.
//

import SnapKit
import UIKit

final class LangPickerPopup: UIView {

    private let pickerView = UIPickerView()

    private let selectButton = UIButton()

    private let params: LangPickerPopupParams

    private let langPickerController: LangPickerController

    private let onFinish: (() -> Void)?

    init(params: LangPickerPopupParams,
         allLangs: [Lang],
         onSelectLang: ((Lang) -> Void)?,
         onFinish: (() -> Void)?) {
        self.params = params
        self.langPickerController = LangPickerController(langs: allLangs, onSelectLang: onSelectLang)
        self.onFinish = onFinish
        super.init(frame: .zero)
        self.backgroundColor = params.styles.backgroundColor
        layer.cornerRadius = 16
        initViews()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func select(lang: Lang?) {
        guard let row = langPickerController.langs.firstIndex(where: { $0.id == lang?.id }) else { return }

        pickerView.selectRow(row, inComponent: 0, animated: false)
    }

    @objc
    private func onSelectButtonTap() {
        onFinish?()
    }

    // MARK: - Layout

    private func initViews() {
        addSubview(pickerView)
        addSubview(selectButton)
        initLangPickerView()
        initSelectButton()
    }

    private func initLangPickerView() {
        pickerView.dataSource = langPickerController
        pickerView.delegate = langPickerController
        pickerView.snp.makeConstraints { (make) -> Void in
            make.edges.equalTo(self).inset(UIEdgeInsets(top: 12, left: 16, bottom: 44, right: 16))
        }
    }

    private func initSelectButton() {
        selectButton.setTitle(params.staticContent.selectButtonTitle, for: .normal)
        selectButton.setTitleColor(.white, for: .normal)
        selectButton.backgroundColor = .darkGray
        selectButton.layer.cornerRadius = 8
        selectButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        selectButton.addTarget(self, action: #selector(onSelectButtonTap), for: .touchUpInside)
        selectButton.snp.makeConstraints { (make) -> Void in
            make.bottom.equalTo(self).offset(-16)
            make.centerX.equalTo(self)
            make.height.equalTo(30)
        }
    }
}
