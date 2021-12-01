//
//  InitAppState.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import Foundation

private let lang1 = Lang(id: Lang.Id(raw: 1), name: NSLocalizedString("English", comment: ""), shortName: "EN")
private let lang2 = Lang(id: Lang.Id(raw: 2), name: NSLocalizedString("Russian", comment: ""), shortName: "RU")
private let lang4 = Lang(id: Lang.Id(raw: 4), name: NSLocalizedString("Italian", comment: ""), shortName: "IT")
private let lang5 = Lang(id: Lang.Id(raw: 5), name: NSLocalizedString("German", comment: ""), shortName: "DE")

private let langData = LangData(allLangs: [lang1, lang2, lang4, lang5],
                                sourceLangKey: "io.github.maksimn.pd.sourceLang",
                                targetLangKey: "io.github.maksimn.pd.targetLang",
                                defaultSourceLang: lang1,
                                defaultTargetLang: lang2)
private let langRepository = LangRepositoryImpl(userDefaults: UserDefaults.standard,
                                                data: langData)
private let initNewWordState = NewWordState(text: "",
                                            sourceLang: langRepository.sourceLang,
                                            targetLang: langRepository.targetLang,
                                            isLangPickerHidden: true)

private let initLangPickerState = LangPickerState(
    isHidden: true,
    selectedLangType: .source,
    selectedLang: Lang(id: Lang.Id(raw: 1),
                       name: NSLocalizedString("English", comment: ""),
                       shortName: "EN"),
    allLangs: [lang1, lang2, lang4, lang5]
)

let initAppState = AppState(newWord: initNewWordState, langPicker: initLangPickerState)
