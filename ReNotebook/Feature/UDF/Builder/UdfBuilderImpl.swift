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

    private let langRepository: LangRepository

    init(appConfigs: AppConfigs) {
        self.appConfigs = appConfigs

        let langData = appConfigs.langData
        langRepository = LangRepositoryImpl(userDefaults: UserDefaults.standard,
                                            data: langData)
        let initNewWordState = NewWordState(text: "",
                                            sourceLang: langRepository.sourceLang,
                                            targetLang: langRepository.targetLang,
                                            isLangPickerHidden: true)

        let initLangPickerState = LangPickerState(
            isHidden: true,
            selectedLangType: .source,
            selectedLang: Lang(id: Lang.Id(raw: 1),
                               name: NSLocalizedString("English", comment: ""),
                               shortName: "EN"),
            allLangs: langData.allLangs
        )

        let initAppState = AppState(newWord: initNewWordState, langPicker: initLangPickerState)

        let loggingMiddleware: Middleware<Any> = { _, _ in
            return { next in
                return { action in
                    print(action)

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
        NewWordBuilderImpl(langRepository: langRepository,
                           store: store)
    }
}
