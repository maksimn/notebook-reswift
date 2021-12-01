//
//  LangPickerBuilderImpl.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import ReSwift
import UIKit

final class LangPickerBuilderImpl: LangPickerBuilder {

    private lazy var viewParams = LangPickerViewParams(
        staticContent: LangPickerPopupStaticContent(
            selectButtonTitle: NSLocalizedString("Select", comment: "")
        ),
        styles: LangPickerPopupStyles(
            backgroundColor: UIColor(red: 0.97, green: 0.97, blue: 0.95, alpha: 1.0)
        )
    )

    private let store: Store<AppState>
    private let langRepository: LangRepository

    init(store: Store<AppState>,
         langRepository: LangRepository) {
        self.store = store
        self.langRepository = langRepository
    }

    func build() -> LangPickerGraph {
        LangPickerGraphImpl(viewParams: viewParams, store: store, langRepository: langRepository)
    }
}
