//
//  LangPickerViewImpl.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 09.11.2021.
//

import ReSwift
import UIKit

final class LangPickerViewImpl: UIView, LangPickerView {

    private let params: LangPickerViewParams
    private var langPickerPopup: LangPickerPopup?

    private let modelBlock: () -> LangPickerModel?
    private lazy var model: LangPickerModel? = modelBlock()

    init(params: LangPickerViewParams,
         allLangs: [Lang],
         modelBlock: @escaping () -> LangPickerModel?) {
        self.params = params
        self.modelBlock = modelBlock
        super.init(frame: .zero)
        langPickerPopup = LangPickerPopup(
            params: params,
            allLangs: allLangs,
            onSelectLang: { [weak self] lang in
                self?.model?.selectLang(lang)
            },
            onFinish: { [weak self] in
                self?.model?.hideLangPicker()
            }
        )
        addSubview(langPickerPopup ?? UIView())
        langPickerPopup?.snp.makeConstraints { make -> Void in
            make.edges.equalTo(self)
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    func set(_ state: LangPickerState) {
        langPickerPopup?.select(lang: state.selectedLang)
    }
}
