//
//  NewWordViewController+Layout.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import SnapKit
import UIKit

extension NewWordViewController {

    func initViews() {
        view.backgroundColor = .gray
        addSubviews()
        initContentView()
        initSourceLangLabel()
        initTargetLangLabel()
        initArrowLabel()
        initTextField()
        initOkButton()
        initLangPicker()
    }

    private func addSubviews() {
        [contentView, sourceLangLabel, targetLangLabel, arrowLabel, textField, okButton]
            .forEach { view.addSubview($0) }
    }

    private func initContentView() {
        contentView.layer.cornerRadius = 16
        contentView.backgroundColor = params.styles.backgroundColor
        contentView.snp.makeConstraints { (make) -> Void in
            make.centerY.equalTo(view)
            make.right.equalTo(view.safeAreaLayoutGuide.snp.right).offset(-12)
            make.left.equalTo(view.safeAreaLayoutGuide.snp.left).offset(12)
            make.height.equalTo(176)
        }
    }

    private func initSourceLangLabel() {
        sourceLangLabel.isUserInteractionEnabled = true
        sourceLangLabel.textColor = .black
        sourceLangLabel.font = UIFont.systemFont(ofSize: 17)
        sourceLangLabel.numberOfLines = 1
        sourceLangLabel.textAlignment = .right
        sourceLangLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView).offset(20)
            make.trailing.equalTo(contentView.snp.centerX).offset(-20)
            make.height.equalTo(24)
        }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(onSourceLangLabelTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        sourceLangLabel.addGestureRecognizer(tapGestureRecognizer)
    }

    private func initTargetLangLabel() {
        targetLangLabel.isUserInteractionEnabled = true
        targetLangLabel.textColor = .black
        targetLangLabel.font = UIFont.systemFont(ofSize: 17)
        targetLangLabel.numberOfLines = 1
        targetLangLabel.snp.makeConstraints { make -> Void in
            make.top.equalTo(contentView).offset(12)
            make.leading.equalTo(contentView.snp.centerX).offset(20)
            make.trailing.equalTo(contentView).offset(-20)
            make.height.equalTo(24)
        }

        let tapGestureRecognizer = UITapGestureRecognizer(target: self,
                                                          action: #selector(onTargetLangLabelTap))
        tapGestureRecognizer.numberOfTapsRequired = 1
        targetLangLabel.addGestureRecognizer(tapGestureRecognizer)
    }

    private func initArrowLabel() {
        arrowLabel.isUserInteractionEnabled = false
        arrowLabel.textColor = .black
        arrowLabel.font = UIFont.systemFont(ofSize: 17)
        arrowLabel.numberOfLines = 1
        arrowLabel.textAlignment = .center
        arrowLabel.text = params.staticContent.arrowText
        arrowLabel.snp.makeConstraints { make -> Void in
            make.centerY.equalTo(sourceLangLabel)
            make.centerX.equalTo(contentView)
        }
    }

    private func initTextField() {
        textField.placeholder = params.staticContent.textFieldPlaceholder
        textField.borderStyle = UITextField.BorderStyle.roundedRect
        textField.backgroundColor = UIColor.white
        textField.textColor = .black
        textField.snp.makeConstraints { make -> Void in
            make.edges.equalTo(contentView).inset(UIEdgeInsets(top: 62, left: 12, bottom: 74, right: 12))
        }
        textField.delegate = self
        textField.addTarget(self, action: #selector(textFieldDidChange), for: .editingChanged)
    }

    private func initOkButton() {
        okButton.setTitle(params.staticContent.okText, for: .normal)
        okButton.setTitleColor(.white, for: .normal)
        okButton.backgroundColor = .green
        okButton.layer.cornerRadius = 8
        okButton.titleLabel?.font = UIFont(name: "Arial-BoldMT", size: 20)
        okButton.contentEdgeInsets = UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        okButton.addTarget(self, action: #selector(onOkButtonTap), for: .touchUpInside)
        okButton.snp.makeConstraints { make -> Void in
            make.top.equalTo(textField.snp.bottom).offset(26)
            make.centerX.equalTo(contentView)
            make.height.equalTo(30)
        }
    }

    private func initLangPicker() {
        let langPickerGraph = langPickerBuilder.build()

        langPickerView = langPickerGraph.uiview
        view.addSubview(langPickerView ?? UIView())
        langPickerView?.snp.makeConstraints { make -> Void in
            make.edges.equalTo(contentView)
        }
        langPickerView?.isHidden = true
    }
}
