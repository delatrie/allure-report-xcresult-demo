//
//  AllureReportDemoTests.swift
//  AllureReportDemoTests
//
//  Created by Maksim Stepanov on 27.03.2025.
//

import Testing
import AllureReportDemo

extension Tag {
  @Tag static var negative: Self
  @Tag static var defect: Self
}

struct GetDataTests {
    
    struct NegativeTests {
        @Test("Throws error if N <= 0", .tags(.negative), arguments: [-2, -1, 0])
        func nCantBeZeroOrNegative(invalidN: Int) async throws {
            #expect(throws: AllureReportDemo.GetDataError.invalidNumber) {
                try AllureReportDemo.getData(n: invalidN, locale: "en_US")
            }
        }
        
        @Test("Throws error if locale identifier is ill-formed", arguments: ["en-US", "enUS"])
        func nCantBeZeroOrNegative(invalidLocale: String) async throws {
            #expect(throws: AllureReportDemo.GetDataError.invalidLocale) {
                try AllureReportDemo.getData(n: 1, locale: invalidLocale)
            }
        }
    }
    
    struct Defects {
        @Test("Should not add an extra item if N > 10", .tags(.defect), .bug("https://github.com/delatrie/allure-report-xcresult-demo/issues/1", id: 1, "ISSUE-1"))
        func shouldNotAddExtraItemForLargeN() async throws {
            let data = try AllureReportDemo.getData(n: 11, locale: "en_US")
            
            #expect(data.count == 12)
            #expect(data.last == "Item 11")
        }
    }

    @Test("Check en_US timestamp") func enTimeStamp() async throws {
        let data = try AllureReportDemo.getData(n: 1, locale: "en_US")
        let timestamp = data[0]
        
        let pattern = #/[A-Z][a-z]{2} \d{1,2}, \d{4} at \d{1,2}:\d{2}:\d{2}\s[AP]M/#
        
        #expect(timestamp.wholeMatch(of: pattern) != nil)
    }

    @Test("Check ru_RU timestamp") func ruTimeStamp() async throws {
        let data = try AllureReportDemo.getData(n: 1, locale: "ru_RU")
        let timestamp = data[0]
        
        let pattern = #/\d{1,2} \w+ \d{4}\sг\., \d{1,2}:\d{2}:\d{2}/#
        
        #expect(timestamp.wholeMatch(of: pattern) != nil)
    }
}
