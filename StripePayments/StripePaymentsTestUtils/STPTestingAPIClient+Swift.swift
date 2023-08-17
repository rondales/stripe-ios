//
//  STPTestingAPIClient+Swift.swift
//  StripeiOSTests
//
//  Created by Yuki Tokuhiro on 6/25/23.
//

import Foundation
@_spi(STP) import StripePayments
@_exported import StripePaymentsObjcTestUtils

extension STPTestingAPIClient {
    public static var shared: STPTestingAPIClient {
        return .shared()
    }

    func fetchPaymentIntent(
        types: [String],
        currency: String = "eur",
        merchantCountry: String? = "us",
        paymentMethodID: String? = nil,
        confirmPaymentMethodOptions: STPConfirmPaymentMethodOptions? = nil,
        confirm: Bool = false,
        otherParams: [String: Any] = [:],
        completion: @escaping (Result<(String), Error>) -> Void
    ) {
        var params = [String: Any]()
        params["amount"] = 1050
        params["currency"] = currency
        params["payment_method_types"] = types
        params["confirm"] = confirm
        if let confirmPaymentMethodOptions = confirmPaymentMethodOptions {
            params.merge(STPFormEncoder.dictionary(forObject: confirmPaymentMethodOptions)) { _, b in b }
        }

        if let paymentMethodID = paymentMethodID {
            params["payment_method"] = paymentMethodID
        }
        params.merge(otherParams) { _, b in b }

        createPaymentIntent(
            withParams: params,
            account: merchantCountry
        ) { clientSecret, error in

            guard let clientSecret = clientSecret,
                  error == nil
            else {
                completion(.failure(error!))
                return
            }

            if let range = clientSecret.range(of: "_secret") {
                    let paymentIntentIdentifier = String(clientSecret[..<range.lowerBound])
                    print("Payment Intent Id: \(paymentIntentIdentifier)")
            }

            completion(.success(clientSecret))
        }
    }

    func fetchPaymentIntent(
        types: [String],
        currency: String = "eur",
        merchantCountry: String? = "us",
        paymentMethodID: String? = nil,
        confirm: Bool = false,
        otherParams: [String: Any] = [:],
        completion: @escaping (Result<(String), Error>) -> Void
    ) {
        var params = [String: Any]()
        params["amount"] = 1050
        params["currency"] = currency
        params["payment_method_types"] = types
        params["confirm"] = confirm
        if let paymentMethodID = paymentMethodID {
            params["payment_method"] = paymentMethodID
        }
        params.merge(otherParams) { _, b in b }

        createPaymentIntent(
            withParams: params,
            account: merchantCountry
        ) { clientSecret, error in

            guard let clientSecret = clientSecret,
                  error == nil
            else {
                completion(.failure(error!))
                return
            }

            if let range = clientSecret.range(of: "_secret") {
                    let paymentIntentIdentifier = String(clientSecret[..<range.lowerBound])
                    print("Payment Intent Id: \(paymentIntentIdentifier)")
            }

            completion(.success(clientSecret))
        }
    }

    func fetchPaymentIntent(
        types: [String],
        currency: String = "eur",
        merchantCountry: String? = "us",
        paymentMethodID: String? = nil,
        confirm: Bool = false,
        otherParams: [String: Any] = [:]
    ) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            fetchPaymentIntent(
                types: types,
                currency: currency,
                merchantCountry: merchantCountry,
                paymentMethodID: paymentMethodID,
                confirm: confirm,
                otherParams: otherParams
            ) { result in
                continuation.resume(with: result)
            }
        }
    }

    func fetchPaymentIntent(
        types: [String],
        currency: String = "eur",
        merchantCountry: String? = "us",
        paymentMethodID: String? = nil,
        confirmPaymentMethodOptions: STPConfirmPaymentMethodOptions? = nil,
        confirm: Bool = false,
        otherParams: [String: Any] = [:]
    ) async throws -> String {
        try await withCheckedThrowingContinuation { continuation in
            fetchPaymentIntent(
                types: types,
                currency: currency,
                merchantCountry: merchantCountry,
                paymentMethodID: paymentMethodID,
                confirmPaymentMethodOptions: confirmPaymentMethodOptions,
                confirm: confirm,
                otherParams: otherParams
            ) { result in
                continuation.resume(with: result)
            }
        }
    }

    func fetchSetupIntent(
        types: [String],
        paymentMethodID: String? = nil,
        confirm: Bool = false,
        otherParams: [String: Any] = [:]
    ) async throws -> String {
        var params = [String: Any]()
        params["payment_method_types"] = types
        params["confirm"] = confirm
        if let paymentMethodID = paymentMethodID {
            params["payment_method"] = paymentMethodID
        }
        params.merge(otherParams) { _, b in b }
        return try await withCheckedThrowingContinuation { continuation in
            createSetupIntent(withParams: params) { clientSecret, error in
                guard let clientSecret = clientSecret,
                      error == nil
                else {
                    continuation.resume(throwing: error!)
                    return
                }

                if let range = clientSecret.range(of: "_secret") {
                        let paymentIntentIdentifier = String(clientSecret[..<range.lowerBound])
                        print("Payment Intent Id: \(paymentIntentIdentifier)")
                }

                continuation.resume(returning: clientSecret)
            }
        }
    }
}
