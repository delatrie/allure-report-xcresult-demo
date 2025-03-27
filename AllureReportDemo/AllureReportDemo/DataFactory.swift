//
//  DataFactory.swift
//  AllureReportDemo
//
//  Created by Maksim Stepanov on 27.03.2025.
//

import Foundation

public enum GetDataError: Error {
    case invalidNumber
    case invalidLocale
}

public func getData(n: Int, locale: String) throws -> Array<String> {
    if n <= 0 {
        throw GetDataError.invalidNumber
    }
    
    if locale.count != 5 || locale[locale.index(locale.startIndex, offsetBy: 2)] != "_" {
        throw GetDataError.invalidLocale
    }
    
    let date = Date()
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .medium
    formatter.locale = Locale(identifier: locale)
    
    var result = [formatter.string(from: date)]
    
    for index in 1...n {
        result.append("Item #\(index)")
    }
    
    if n > 10 {
        // Simulate a defect
        result.append("Extra item")
    }
    
    return result
}
