//
//  AppConfigs.swift
//  ReNotebook
//
//  Created by Maxim Ivanov on 01.12.2021.
//

import UIKit

struct AppConfigs {

    let logging: LoggingConfigs

    let langData: LangData

    let ponsApiSecret: String

    let appViewConfigs: AppViewConfigs
}

struct LoggingConfigs {
    let isLoggingEnabled: Bool
    let allowLongDebugMessages: Bool
}

struct AppViewConfigs {

    let appBackgroundColor: UIColor
}
