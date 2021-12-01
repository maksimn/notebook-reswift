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

    private var langRepository: LangRepository

    init(view: LangPickerView, store: Store<AppState>, langRepository: LangRepository) {
        self.view = view
        self.store = store
        self.langRepository = langRepository
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
        saveSelectedLang()
    }

    private func saveSelectedLang() {
        guard let state = state,
              let selectedLang = state.selectedLang else { return }

        if state.selectedLangType == .source {
            langRepository.sourceLang = selectedLang
        } else {
            langRepository.targetLang = selectedLang
        }
    }
}
