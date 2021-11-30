//
//  LangPickerViewImpl.swift
//  PersonalDictionary
//
//  Created by Maxim Ivanov on 09.11.2021.
//

import ReSwift
import UIKit

final class LangPickerViewImpl: UIView, StoreSubscriber {

    private var langPickerPopup: LangPickerPopup?

    private let popupParams: LangPickerPopupParams

    private var state: LangPickerState? {
        didSet {
            guard let state = state else { return }
            updateWith(state: state)
        }
    }

    init(params: LangPickerViewParams) {
        self.popupParams = LangPickerPopupParams(
            staticContent: LangPickerPopupStaticContent(selectButtonTitle: params.staticContent.selectButtonTitle),
            styles: LangPickerPopupStyles(backgroundColor: params.styles.backgroundColor)
        )
        super.init(frame: .zero)
        store.subscribe(self) { subcription in
            subcription.select { state in state.langPicker }
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: - StoreSubscriber

    func newState(state: LangPickerState) {
        self.state = state
    }

    // MARK: - Private

    private func onSelectLang(_ lang: Lang) {
        guard let state = state else { return }
        store.dispatch(SelectLangAction(lang: lang, langType: state.selectedLangType))
    }

    private func onFinish() {
        store.dispatch(HideLangPickerAction())
    }

    private func updateWith(state: LangPickerState) {
        if state.isHidden {
            langPickerPopup?.removeFromSuperview()
            langPickerPopup = nil
            return
        }

        langPickerPopup = LangPickerPopup(
            params: popupParams,
            initialLang: state.selectedLang,
            langPickerController: LangPickerController(langs: state.allLangs,
                                                       onSelectLang: { [weak self] lang in
                                                         self?.onSelectLang(lang)
                                                       }),
            onFinish: { [weak self] in self?.onFinish() }
        )
        addSubview(langPickerPopup ?? UIView())
        langPickerPopup?.snp.makeConstraints { make -> Void in
            make.edges.equalTo(self)
        }
    }
}
