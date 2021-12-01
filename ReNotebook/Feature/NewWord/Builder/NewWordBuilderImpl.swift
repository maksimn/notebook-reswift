//
//  NewWordBuilderImpl.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import UIKit
import ReSwift

final class NewWordBuilderImpl: NewWordBuilder {

    private lazy var viewParams = NewWordViewParams(
        staticContent: NewWordViewStaticContent(
            selectButtonTitle: NSLocalizedString("Select", comment: ""),
            arrowText: NSLocalizedString("⇋", comment: ""),
            okText: NSLocalizedString("OK", comment: ""),
            textFieldPlaceholder: NSLocalizedString("Enter a new word", comment: "")
        ),
        styles: NewWordViewStyles(backgroundColor: UIColor(red: 0.97, green: 0.97, blue: 0.95, alpha: 1.0))
    )

    private let appConfigs: AppConfigs
    private let store: Store<AppState>
    private lazy var langRepository = LangRepositoryImpl(userDefaults: UserDefaults.standard, data: appConfigs.langData)
    private lazy var langPickerBuilder = LangPickerBuilderImpl(store: store, langRepository: langRepository)

    init(appConfigs: AppConfigs,
         store: Store<AppState>) {
        self.appConfigs = appConfigs
        self.store = store
    }

    func build() -> NewWordGraph {
        NewWordGraphImpl(langRepository: langRepository,
                         store: store,
                         viewParams: viewParams,
                         langPickerBuilder: langPickerBuilder)
    }
}
