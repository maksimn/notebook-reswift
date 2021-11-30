//
//  loggingMiddleware.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 30.11.2021.
//

import ReSwift

let loggingMiddleware: Middleware<Any> = { _, _ in
    return { next in
        return { action in
            print(action)

            return next(action)
        }
    }
}
