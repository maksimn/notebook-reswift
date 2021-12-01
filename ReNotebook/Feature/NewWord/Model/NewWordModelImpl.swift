//
//  NewWordModelImpl.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import ReSwift

class NewWordModelImpl: NewWordModel, StoreSubscriber {

    private weak var view: NewWordView?

    private var langRepository: LangRepository
    private let store: Store<AppState>

    private var state: NewWordState? {
        didSet {
            guard let state = state else { return }
            view?.set(state)
        }
    }

    init(view: NewWordView, langRepository: LangRepository, store: Store<AppState>) {
        self.view = view
        self.langRepository = langRepository
        self.store = store
        store.subscribe(self) { subcription in
            subcription.select { state in state.newWord }
        }
        loadSourceLang()
        loadTargetLang()
    }

    // MARK: - StoreSubscriber

    func newState(state: NewWordState) {
        self.state = state
        updateStorageIfNeeded(state)
    }

    // MARK: - NewWordModel

    func updateNewWordText(text: String) {
        store.dispatch(NewWordTextChangedAction(text: text))
    }

    func showLangPickerWith(selectedLangType: SelectedLangType) {
        guard let state = state else { return }
        let selectedLang = selectedLangType == .source ? state.sourceLang : state.targetLang

        store.dispatch(ShowLangPickerAction(selectedLangType: selectedLangType,
                                            selectedLang: selectedLang))
    }

    func sendNewWord() {
        guard let state = state else { return }
        if state.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty {
            return
        }

        let word = WordItem(text: state.text, sourceLang: state.sourceLang, targetLang: state.targetLang)
        store.dispatch(NewWordAction(word: word))
    }

    // MARK: - Private

    private func loadSourceLang() {
        let sourceLang = langRepository.sourceLang

        store.dispatch(LoadSourceLangAction(lang: sourceLang))
    }

    private func loadTargetLang() {
        let targetLang = langRepository.targetLang

        store.dispatch(LoadTargetLangAction(lang: targetLang))
    }

    private func updateStorageIfNeeded(_ state: NewWordState) {
        if state.sourceLang != langRepository.sourceLang {
            langRepository.sourceLang = state.sourceLang
        }

        if state.targetLang != langRepository.targetLang {
            langRepository.targetLang = state.targetLang
        }
    }
}
