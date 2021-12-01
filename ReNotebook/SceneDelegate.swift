//
//  SceneDelegate.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 29.11.2021.
//

import UIKit

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?

    func scene(_ scene: UIScene,
               willConnectTo session: UISceneSession,
               options connectionOptions: UIScene.ConnectionOptions) {
        guard let windowScene = (scene as? UIWindowScene) else { return }

        let lang1 = Lang(id: Lang.Id(raw: 1), name: NSLocalizedString("English", comment: ""), shortName: "EN")
        let lang2 = Lang(id: Lang.Id(raw: 2), name: NSLocalizedString("Russian", comment: ""), shortName: "RU")
        let lang4 = Lang(id: Lang.Id(raw: 4), name: NSLocalizedString("Italian", comment: ""), shortName: "IT")
        let lang5 = Lang(id: Lang.Id(raw: 5), name: NSLocalizedString("German", comment: ""), shortName: "DE")

        let langData = LangData(allLangs: [lang1, lang2, lang4, lang5],
                                sourceLangKey: "io.github.maksimn.pd.sourceLang",
                                targetLangKey: "io.github.maksimn.pd.targetLang",
                                defaultSourceLang: lang1,
                                defaultTargetLang: lang2)
        let newWordBuilder = NewWordBuilderImpl(langRepository: LangRepositoryImpl(userDefaults: UserDefaults.standard,
                                                                                   data: langData),
                                                store: store)
        let newWordGraph = newWordBuilder.build()
        let newWordViewController = newWordGraph.viewController

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = newWordViewController
        window?.makeKeyAndVisible()
    }
}
