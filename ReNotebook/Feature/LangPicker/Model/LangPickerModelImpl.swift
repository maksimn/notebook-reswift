//
//  LangPickerModelImpl.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import ReSwift

final class LangPickerModelImpl: LangPickerModel, StoreSubscriber {

    private weak var view: LangPickerView?

    private let store: Store<AppState>

    private var state: LangPickerState? {
        didSet {
            guard let state = state else { return }
            view?.set(state)
        }
    }

    init(view: LangPickerView, store: Store<AppState>) {
        self.view = view
        self.store = store
        store.subscribe(self) { subcription in
            subcription.select { state in state.langPicker }
        }
    }

    // MARK: - StoreSubscriber

    func newState(state: LangPickerState) {
        self.state = state
    }

    // MARK: - LangPickerModel

    func selectLang(_ lang: Lang) {
        guard let state = state else { return }
        store.dispatch(SelectLangAction(lang: lang, langType: state.selectedLangType))
    }

    func hideLangPicker() {
        store.dispatch(HideLangPickerAction())
    }
}
