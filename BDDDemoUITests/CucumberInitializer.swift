//
//  TestCucumberInitilaizer.swift
//  TestCucumberUITests
//
//  Created by Akshatha on 17/07/23.
//

import Foundation
import Cucumberish
import XCTest

class CucumberInitilaizer: NSObject {
    @objc class func setupCucumberish() {
        var application : XCUIApplication!
        
        beforeStart { () -> Void in
            application = XCUIApplication()
            XCUIApplication().launch()
            LoginSteps().LoginStepsImplementation()
            OtpSteps().OtpStepsImplementation()
        }
        
        afterFinish {
            application = XCUIApplication()
            XCUIApplication().terminate()
        }

        
        let bundle = Bundle(for: CucumberInitilaizer.self)
        Cucumberish.executeFeatures(inDirectory: "Features", from: bundle, includeTags: nil , excludeTags: [])
    }
    
    class func waitForElementToAppear(_ element: XCUIElement){
        let result = element.waitForExistence(timeout: 5)
        guard result else {
            XCTFail("Element does not appear")
            return
        }
    }
    fileprivate class func getTags() -> [String]? {
        var itemsTags: [String]? = nil
        for i in ProcessInfo.processInfo.arguments {
            if i.hasPrefix("-Tags:") {
                let newItems = i.replacingOccurrences(of: "-Tags:", with: "")
                itemsTags = newItems.components(separatedBy: ",")
            }
        }
        print("/n/nPRINTING THE TAGS FOUND:{0}\n/n",itemsTags)
        return itemsTags
    }
}

