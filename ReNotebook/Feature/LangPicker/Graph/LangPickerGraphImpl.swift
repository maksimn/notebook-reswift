//
//  LangPickerGraphImpl.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import ReSwift
import UIKit

final class LangPickerGraphImpl: LangPickerGraph {

    private let view: LangPickerViewImpl

    init(viewParams: LangPickerViewParams,
         store: Store<AppState>) {
        var modelLazy: LangPickerModel?
        view = LangPickerViewImpl(params: viewParams, modelBlock: { modelLazy })
        let model = LangPickerModelImpl(view: view, store: store)

        modelLazy = model
    }

    var uiview: UIView {
        view
    }
}
