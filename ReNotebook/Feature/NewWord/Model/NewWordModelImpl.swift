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
        loadLangData()
    }

    // MARK: - StoreSubscriber

    func newState(state: NewWordState) {
        self.state = state
    }

    // MARK: - NewWordModel

    func updateNewWordText(text: String) {
        store.dispatch(NewWordTextChangedAction(text: text))
    }

    func showLangPickerWith(selectedLangType: SelectedLangType) {
        guard let state = state else { return }
        guard let selectedLang = selectedLangType == .source ? state.sourceLang : state.targetLang else { return }

        store.dispatch(ShowLangPickerAction(selectedLangType: selectedLangType,
                                            selectedLang: selectedLang))
    }

    func sendNewWord() {
        guard let state = state,
              let sourceLang = state.sourceLang,
              let targetLang = state.targetLang,
              !state.text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty else {
            return
        }

        let word = WordItem(text: state.text, sourceLang: sourceLang, targetLang: targetLang)
        store.dispatch(NewWordAction(word: word))
    }

    // MARK: - Private

    private func loadLangData() {
        store.dispatch(LoadLangDataAction(sourceLang: langRepository.sourceLang,
                                          targetLang: langRepository.targetLang))
    }
}
