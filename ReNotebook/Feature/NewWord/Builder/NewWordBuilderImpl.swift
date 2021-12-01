//
//  NewWordBuilderImpl.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import UIKit
import ReSwift

final class NewWordBuilderImpl: NewWordBuilder {

    private lazy var newWordViewParams: NewWordViewParams = {
        NewWordViewParams(
            staticContent: NewWordViewStaticContent(
                selectButtonTitle: NSLocalizedString("Select", comment: ""),
                arrowText: NSLocalizedString("⇋", comment: ""),
                okText: NSLocalizedString("OK", comment: ""),
                textFieldPlaceholder: NSLocalizedString("Enter a new word", comment: "")
            ),
            styles: NewWordViewStyles(backgroundColor: UIColor(red: 0.97, green: 0.97, blue: 0.95, alpha: 1.0))
        )
    }()

    private let langRepository: LangRepository
    private let store: Store<AppState>
    private lazy var langPickerBuilder = LangPickerBuilderImpl(store: store)

    init(langRepository: LangRepository,
         store: Store<AppState>) {
        self.langRepository = langRepository
        self.store = store
    }

    func build() -> NewWordGraph {
        NewWordGraphImpl(langRepository: langRepository,
                         store: store,
                         viewParams: newWordViewParams,
                         langPickerBuilder: langPickerBuilder)
    }
}
