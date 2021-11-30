//
//  NewWordViewController.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift
import UIKit

class NewWordViewController: UIViewController, StoreSubscriber {

    let params: NewWordViewParams

    let contentView = UIView()
    let sourceLangLabel = UILabel()
    let targetLangLabel = UILabel()
    let arrowLabel = UILabel()
    let okButton = UIButton()
    let textField = UITextField()

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
        store.subscribe(self) { subcription in
            subcription.select { state in state.newWord }
        }
    }

    func newState(state: NewWordState) {
        set(text: state.text)
        set(sourceLang: state.sourceLang)
        set(targetLang: state.targetLang)
    }

    private func set(text: String) {
        textField.text = text
    }

    private func set(sourceLang: Lang) {
        sourceLangLabel.text = sourceLang.name
    }

    private func set(targetLang: Lang) {
        targetLangLabel.text = targetLang.name
    }

    private func sendNewWordEventAndDismiss() {
        dismiss(animated: true, completion: nil)
    }
}

// User Action handlers
extension NewWordViewController: UITextFieldDelegate {

    @objc
    func onSourceLangLabelTap() {

    }

    @objc
    func onTargetLangLabelTap() {

    }

    @objc
    func onOkButtonTap() {
        sendNewWordEventAndDismiss()
    }

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        store.dispatch(NewWordTextChangedAction(text: textField.text ?? ""))
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        sendNewWordEventAndDismiss()
        return true
    }
}
