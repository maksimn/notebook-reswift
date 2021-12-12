//
//  NewWordViewController.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import UIKit

class NewWordViewController: UIViewController, NewWordView, UITextFieldDelegate {

    private let modelBlock: () -> NewWordModel?
    private lazy var model: NewWordModel? = modelBlock()

    let params: NewWordViewParams

    let contentView = UIView()
    let sourceLangLabel = UILabel()
    let targetLangLabel = UILabel()
    let arrowLabel = UILabel()
    let okButton = UIButton()
    let textField = UITextField()

    var langPickerView: UIView?
    let langPickerBuilder: LangPickerBuilder

    init(modelBlock: @escaping () -> NewWordModel?,
         viewParams: NewWordViewParams,
         langPickerBuilder: LangPickerBuilder) {
        self.modelBlock = modelBlock
        self.params = viewParams
        self.langPickerBuilder = langPickerBuilder
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        initViews()
        model?.loadLangData()
    }

    func set(_ state: NewWordState) {
        textField.text = state.text
        sourceLangLabel.text = state.sourceLang.name
        targetLangLabel.text = state.targetLang.name
        langPickerView?.isHidden = state.isLangPickerHidden
    }

    // MARK: - UITextFieldDelegate

    @objc
    func textFieldDidChange(_ textField: UITextField) {
        model?.updateNewWordText(textField.text ?? "")
    }

    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        model?.sendNewWord()
        return true
    }

    // MARK: - User Action Handlers

    @objc
    func onSourceLangLabelTap() {
        model?.showLangPickerWith(selectedLangType: .source)
    }

    @objc
    func onTargetLangLabelTap() {
        model?.showLangPickerWith(selectedLangType: .target)
    }

    @objc
    func onOkButtonTap() {
        model?.sendNewWord()
    }
}
