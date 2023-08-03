//  Converted to Swift 5.8.1 by Swiftify v5.8.28463 - https://swiftify.com/
//
//  STPPaymentMethodAfterpayClearpayTest.swift
//  StripeiOS Tests
//
//  Created by Ali Riaz on 1/14/21.
//  Copyright © 2021 Stripe, Inc. All rights reserved.
//

import Stripe
import StripeCoreTestUtils

//allResponseFields
var jsonExpectation = XCTestExpectation(description: "Fetch Afterpay Clearpay JSON")
var afterpay = STPPaymentMethodAfterpayClearpay.decodedObject(fromAPIResponse: json)

class STPPaymentMethodAfterpayClearpayTest: XCTestCase {
    var afterpayJSON: [AnyHashable : Any]?

    func _retrieveAfterpayJSON(_ completion: @escaping ([AnyHashable : Any]?) -> Void) {
        if let afterpayJSON {
            completion(afterpayJSON)
        } else {
            let client = STPAPIClient(publishableKey: STPTestingDefaultPublishableKey)
            paymentIntent
            _unused
            //
            //
        }
    }
}