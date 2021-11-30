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

        let viewParams = NewWordViewParams(
            staticContent: NewWordViewStaticContent(
                selectButtonTitle: NSLocalizedString("Select", comment: ""),
                arrowText: NSLocalizedString("⇋", comment: ""),
                okText: NSLocalizedString("OK", comment: ""),
                textFieldPlaceholder: NSLocalizedString("Enter a new word", comment: "")
            ),
            styles: NewWordViewStyles(backgroundColor: UIColor(red: 0.97, green: 0.97, blue: 0.95, alpha: 1.0))
        )
        let newWordViewController = NewWordViewController(params: viewParams)

        window = UIWindow(windowScene: windowScene)
        window?.rootViewController = newWordViewController
        window?.makeKeyAndVisible()

        store.dispatch(ShowNewWordEditorAction())
    }
}
