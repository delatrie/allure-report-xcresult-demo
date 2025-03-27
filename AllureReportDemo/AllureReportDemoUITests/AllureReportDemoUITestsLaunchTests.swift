//
//  AllureReportDemoUITestsLaunchTests.swift
//  AllureReportDemoUITests
//
//  Created by Maksim Stepanov on 27.03.2025.
//

import XCTest
import Foundation

final class AllureReportDemoUITestsLaunchTests: XCTestCase {

    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
    }
    
    @MainActor
    func testLaunch() throws {
        let app = XCUIApplication()
        app.launch()

        // Insert steps here to perform after app launch but before taking a screenshot,
        // such as logging into a test account or navigating somewhere in the app
        
        XCTContext.runActivity(named: "Add Allure data") { _ in
            XCTContext.runActivity(named: "allure.id: 1009") { _ in }
            XCTContext.runActivity(named: "allure.name: The application should launch correctly") { _ in }
            XCTContext.runActivity(named: "allure.description: The test checks if the app is launched and the timestamp is displayed with the list of items") { _ in }

            XCTContext.runActivity(named: "allure.precondition: The following environment variables must be set:\n\n  - `ALLURE_DEMO_UITEST_LOCALE` must be set to a correct locale identifier (e.g., `\"en_US\"`)\n  - `ALLURE_DEMO_UITEST_N` must be set to a number of items to display (e.b., `5`)") { _ in }
            XCTContext.runActivity(named: "allure.expectedResult: The opened page contains the following UI elements:\n\n  - the `globe` icon\n  - a timestamp the specified locale\n  - the specified number of items, one per line") { _ in }
            XCTContext.runActivity(named: "allure.label.owner: John Doe") { _ in }
            XCTContext.runActivity(named: "allure.label.layer: UI") { _ in }
            XCTContext.runActivity(named: "allure.link.Allure Report Home[homepage]: https://allurereport.org") { _ in }
            
            if let locale = ProcessInfo.processInfo.environment["ALLURE_DEMO_LOCALE"] {
                XCTContext.runActivity(named: "allure.parameter.Locale[excluded]: \(locale)") { _ in }
            }
            
            if let n = ProcessInfo.processInfo.environment["ALLURE_DEMO_N"] {
                XCTContext.runActivity(named: "allure.parameter.Number of items[excluded]: \(n)") { _ in }
            }
            
            if let password = ProcessInfo.processInfo.environment["ALLURE_DEMO_UITEST_PASSWORD"] {
                XCTContext.runActivity(named: "allure.parameter.Locale[excluded,masked]: \(password)") { _ in }
            }
        }
        
        XCTContext.runActivity(named: "Validate the UI") { ctx in
            let icon = app.images["icon"]
            XCTAssertTrue(icon.exists)
            
            let timestamp = app.staticTexts["timestamp"]
            XCTAssertTrue(timestamp.exists)
            let timestampText = timestamp.value as! String
            XCTAssertNotEqual(timestampText, "")
            let timestampAttachment = XCTAttachment(string: timestampText)
            timestampAttachment.name = "The timestamp"
            timestampAttachment.lifetime = .keepAlways
            ctx.add(timestampAttachment)
        }
        
        let screenshot = XCTAttachment(screenshot: app.screenshot())
        screenshot.name = "Launch Screen"
        screenshot.lifetime = .keepAlways
        add(screenshot)
        
        XCTContext.runActivity(named: "Simulate an error") { ctx in
            XCTExpectFailure("We don't show the locale in this version")
            
            let locale = app.staticTexts["locale"]
            
            XCTAssertTrue(locale.exists)
        }
    }
}
