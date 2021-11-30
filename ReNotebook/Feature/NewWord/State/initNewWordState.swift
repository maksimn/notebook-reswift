//
//  initNewWordState.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import Foundation

private let defaultSourceLang = Lang(id: Lang.Id(raw: 1),
                                     name: NSLocalizedString("English", comment: ""),
                                     shortName: "EN")
private let defaultTargetLang = Lang(id: Lang.Id(raw: 2),
                                     name: NSLocalizedString("Russian", comment: ""),
                                     shortName: "RU")
let initNewWordState = NewWordState(text: "", sourceLang: defaultSourceLang, targetLang: defaultTargetLang)
