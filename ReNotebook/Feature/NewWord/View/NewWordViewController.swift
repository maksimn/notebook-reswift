//
//  NewWordViewController.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift
import UIKit

class NewWordViewController: UIViewController, StoreSubscriber, UITextFieldDelegate {

    let params: NewWordViewParams

    let contentView = UIView()
    let sourceLangLabel = UILabel()
    let targetLangLabel = UILabel()
    let arrowLabel = UILabel()
    let okButton = UIButton()
    let textField = UITextField()

    var langPickerView: UIView?

    private var state: NewWordState? {
        didSet {
            guard let state = state else { return }
            textField.text = state.text
            sourceLangLabel.text = state.sourceLang.name
            targetLangLabel.text = state.targetLang.name
            langPickerView?.isHidden = state.isLangPickerHidden
        }
    }

    init(params: NewWordViewParams) {
        self.params = params
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()

        langPickerView = LangPickerViewImpl(
            params: LangPickerViewParams(
                staticContent: LangPickerViewStaticContent(
                    selectButtonTitle: NSLocalizedString("Select", comment: "")
                ),
                styles: LangPickerViewStyles(
                    backgroundColor: params.styles.backgroundColor
                )
            )
        )
        view.addSubview(langPickerView ?? UIView())
        langPickerView?.snp.makeConstraints { make -> Void in
            make.edges.equalTo(contentView)
        }

        store.subscribe(self) { subcription in
            subcription.select { state in state.newWord }
        }
    }

    // MARK: - StoreSubscriber

    func newState(state: NewWordState) {
        self.state = state
    }

    // MARK: - UITextFieldDelegate

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        store.dispatch(NewWordTextChangedAction(text: textField.text ?? ""))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendNewWord()
        return true
    }

    // MARK: - User Action Handlers

    @objc
    func onSourceLangLabelTap() {
        showLangPickerView(selectedLangType: .source)
    }

    @objc
    func onTargetLangLabelTap() {
        showLangPickerView(selectedLangType: .target)
    }

    @objc
    func onOkButtonTap() {
        sendNewWord()
    }

    // MARK: - Private

    private func showLangPickerView(selectedLangType: SelectedLangType) {
        guard let state = state else { return }
        let selectedLang = selectedLangType == .source ? state.sourceLang : state.targetLang

        store.dispatch(ShowLangPickerAction(selectedLangType: selectedLangType,
                                            selectedLang: selectedLang))
    }

    private func sendNewWord() {
        guard let state = state else { return }
        let word = WordItem(text: state.text, sourceLang: state.sourceLang, targetLang: state.targetLang)
        store.dispatch(NewWordAction(word: word))
    }
}
