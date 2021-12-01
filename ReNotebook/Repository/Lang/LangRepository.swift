//
//  LangRepository.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

protocol LangRepository {

    var allLangs: [Lang] { get }

    var sourceLang: Lang { get set }

    var targetLang: Lang { get set }
}
