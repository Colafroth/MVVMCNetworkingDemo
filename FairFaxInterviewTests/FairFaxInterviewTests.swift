//
//  FairFaxInterviewTests.swift
//  FairFaxInterviewTests
//
//  Created by AnTeng Lin on 18/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import XCTest
@testable import FairFaxInterview

class NetworkingTest: XCTestCase {

    var mockServiceConfiguration: ServiceConfiguration!
    var mockRequest: MockRequest!
    var mockOperation: MockOperation!
    var mockService: MockService!
    var mockResponse: MockResponse!

    override func setUp() {
        super.setUp()
        mockServiceConfiguration = ServiceConfiguration(name: "Testing", baseURLString: "http://testing/")!
        mockRequest = MockRequest(endpoint: "123")
        mockService = MockService(configuration: mockServiceConfiguration)
        mockResponse = MockResponse(result: .success(statusCode: 200), httpResponse: nil, statusCode: 200, data: Data(), request: mockRequest)
        mockOperation = MockOperation(request: mockRequest)
    }

    override func tearDown() {
        mockServiceConfiguration = nil
        mockRequest = nil
        mockOperation = nil
        mockService = nil
        mockResponse = nil
        super.tearDown()
    }

    func testSuccessStatusCode() {
        var statusCode: Int?
        var error: Error?

        mockService.mockResponse = mockResponse
        mockService.execute(mockRequest, onSuccess: { response in
            statusCode = response.statusCode
        }, onError: { theError in
            error = theError
        })

        XCTAssertNil(error)
        XCTAssertEqual(statusCode, 200)
        XCTAssertNotEqual(statusCode, 201)
    }

    func testSuccessURL() {
        var urlString: String?
        var error: Error?

        mockService.mockResponse = mockResponse
        mockService.execute(mockRequest, onSuccess: { response in
            urlString = try! response.request.url(in: self.mockService).absoluteString
        }, onError: { theError in
            error = theError
        })

        XCTAssertNil(error)
        XCTAssertEqual(urlString, "http://testing/123")
        XCTAssertNotEqual(urlString, "http://testing/1234")
    }

    func testError() {
        var response: ResponseProtocol?
        var error: NetworkError?

        mockService.mockError = NetworkError.fieldsNotEncodable
        mockService.execute(mockRequest, onSuccess: { theResponse in
            response = theResponse
        }, onError: { theError in
            guard let theError = theError as? NetworkError else { return }
            error = theError
        })

        if let error = error,
            case NetworkError.fieldsNotEncodable = error {
            XCTAssert(true)
        } else {
            XCTAssert(false)
        }
        XCTAssertNil(response)
    }

    struct MockResponse: ResponseProtocol {
        var result: ResponseResult

        var httpResponse: HTTPURLResponse?

        var statusCode: Int?

        var data: Data!

        var request: RequestProtocol
    }

    struct MockRequest: RequestProtocol {
        var endpoint: String

        var parameters: ParametersDictionary?

        var fields: ParametersDictionary?

        var method: RequestMethod

        var body: Data?

        var headers: HeadersDictionary?

        var cachePolicy: URLRequest.CachePolicy?

        var timeout: TimeInterval?

        init(endpoint: String,
             parameters: ParametersDictionary? = nil,
             fields: ParametersDictionary? = nil,
             method: RequestMethod = .get,
             body: Data? = nil,
             headers: HeadersDictionary? = nil,
             cachePolicy: URLRequest.CachePolicy? = nil,
             timeout: TimeInterval? = nil) {
            self.endpoint = endpoint
            self.parameters = parameters
            self.fields = fields
            self.method = method
            self.body = body
            self.headers = headers
            self.cachePolicy = cachePolicy
            self.timeout = timeout
        }

    }

    class MockOperation: JSONOperation<ArticleCollection> {

        var mockArticleCollection: ArticleCollection?
        var mockError: NetworkError?

        override func execute(in service: ServiceProtocol, onSuccess: ((ArticleCollection) -> Void)?, onError: ErrorHandler?) {
            if let mockArticleCollection = mockArticleCollection {
                onSuccess?(mockArticleCollection)
            } else if let mockError = mockError {
                onError?(mockError)
            }
        }
    }

    class MockService: ServiceProtocol {
        var mockResponse: ResponseProtocol?
        var mockError: NetworkError?

        var configuration: ServiceConfiguration

        var headers = HeadersDictionary()

        required init(configuration: ServiceConfiguration) {
            self.configuration = configuration
        }

        func execute(_ request: RequestProtocol, onSuccess: ((ResponseProtocol) -> Void)?, onError: ErrorHandler?) {
            if let mockResponse = mockResponse {
                onSuccess?(mockResponse)
            } else if let mockError = mockError {
                onError?(mockError)
            }
        }
    }
}
