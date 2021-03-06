//
//  ConfigBuilderImpl.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import UIKit

final class ConfigBuilderImpl: ConfigBuilder {

    private lazy var appConfigs: AppConfigs = {
        let lang1 = Lang(id: Lang.Id(raw: 1), name: NSLocalizedString("English", comment: ""), shortName: "EN")
        let lang2 = Lang(id: Lang.Id(raw: 2), name: NSLocalizedString("Russian", comment: ""), shortName: "RU")
        let lang4 = Lang(id: Lang.Id(raw: 4), name: NSLocalizedString("Italian", comment: ""), shortName: "IT")
        let lang5 = Lang(id: Lang.Id(raw: 5), name: NSLocalizedString("German", comment: ""), shortName: "DE")

        let langData = LangData(allLangs: [lang1, lang2, lang4, lang5],
                                sourceLangKey: "io.github.maksimn.pd.sourceLang",
                                targetLangKey: "io.github.maksimn.pd.targetLang",
                                defaultSourceLang: lang1,
                                defaultTargetLang: lang2)

        return AppConfigs(

            logging: LoggingConfigs(isLoggingEnabled: true, allowLongDebugMessages: false),

            langData: langData,

            ponsApiSecret: "",

            appViewConfigs: AppViewConfigs(
                appBackgroundColor: UIColor(red: 0.97, green: 0.97, blue: 0.95, alpha: 1.0)
            )
        )
    }()

    func createUdfBuilder() -> UdfBuilder {
        UdfBuilderImpl(appConfigs: appConfigs)
    }
}
