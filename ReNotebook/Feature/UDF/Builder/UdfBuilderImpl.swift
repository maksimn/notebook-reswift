//
//  UdfBuilderImpl.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import ReSwift

final class UdfBuilderImpl: UdfBuilder {

    private let appConfigs: AppConfigs
    private let store: Store<AppState>

    init(appConfigs: AppConfigs) {
        self.appConfigs = appConfigs

        let emptyNewWordState = NewWordState(text: "", sourceLang: nil, targetLang: nil, isLangPickerHidden: true)

        let emptyLangPickerState = LangPickerState(selectedLangType: .source, selectedLang: nil)

        let initAppState = AppState(newWord: emptyNewWordState, langPicker: emptyLangPickerState)

        let loggingMiddleware: Middleware<Any> = { _, getState in
            return { next in
                return { action in
                    let logging = appConfigs.logging

                    if logging.isLoggingEnabled && logging.allowLongDebugMessages,
                        let state = getState() {
                        print("PREVIOUS_STATE:")
                        print(state)
                    }

                    if logging.isLoggingEnabled {
                        print("ACTION:")
                        print(action)
                        print("======================================")
                    }

                    return next(action)
                }
            }
        }

        store = Store(
            reducer: appReducer,
            state: initAppState,
            middleware: [loggingMiddleware]
        )
    }

    func createNewWordBuilder() -> NewWordBuilder {
        NewWordBuilderImpl(appConfigs: appConfigs,
                           store: store)
    }
}
