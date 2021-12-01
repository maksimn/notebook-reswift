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
        guard let langType = state?.selectedLangType else { return }
        store.dispatch(SelectLangAction(lang: lang, langType: langType))
        saveSelectedLang(lang, langType)
    }

    func hideLangPicker() {
        store.dispatch(HideLangPickerAction())
    }

    private func saveSelectedLang(_ lang: Lang, _ langType: SelectedLangType) {
        if langType == .source {
            langRepository.sourceLang = lang
        } else {
            langRepository.targetLang = lang
        }
    }
}
