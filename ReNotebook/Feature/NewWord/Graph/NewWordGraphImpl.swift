//
//  NewWordGraphImpl.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import ReSwift
import UIKit

final class NewWordGraphImpl: NewWordGraph {

    private let view: NewWordViewController

    init(langRepository: LangRepository,
         store: Store<AppState>,
         viewParams: NewWordViewParams,
         langPickerBuilder: LangPickerBuilder) {
        var modelLazy: NewWordModel?
        view = NewWordViewController(modelBlock: { modelLazy },
                                     viewParams: viewParams,
                                     langPickerBuilder: langPickerBuilder)
        let model = NewWordModelImpl(view: view,
                                     langRepository: langRepository,
                                     store: store)
        modelLazy = model
    }

    var viewController: UIViewController {
        view
    }
}
