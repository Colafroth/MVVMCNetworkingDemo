//
//  MVVMCNetworkingDemoTests.swift
//  MVVMCNetworkingDemoTests
//
//  Created by AnTeng Lin on 18/3/18.
//  Copyright © 2018 Anteng Lin. All rights reserved.
//

import XCTest
@testable import MVVMCNetworkingDemo

class ArticleCollectionViewModelTest: XCTestCase {

    var viewModel: ArticleCollectionViewModel!

    var mockServiceConfiguration: ServiceConfiguration!
    var mockRequest: MockRequest!
    var mockOperation: MockOperation!
    var mockService: MockService!
    var mockResponse: MockResponse!

    var article1: Article!
    var article2: Article!
    var article3: Article!

    override func setUp() {
        super.setUp()
        viewModel = ArticleCollectionViewModel()
        mockServiceConfiguration = ServiceConfiguration(name: "Testing", baseURLString: "http://testing/")!
        mockRequest = MockRequest(endpoint: "123")
        mockService = MockService(configuration: mockServiceConfiguration)
        mockResponse = MockResponse(result: .success(statusCode: 200), httpResponse: nil, statusCode: 200, data: Data(), request: mockRequest)
        mockOperation = MockOperation(request: mockRequest)

        article1 = Article(headline: "article1", theAbstract: "theAbstract1", byLine: "byLine1", timeStamp: 100, url: "http://article1", relatedImages: [RelatedImage(id: 1, width: 1, height: 2, url: "http://image1")], displayImageURL: nil)
        article2 = Article(headline: "article2", theAbstract: "theAbstract2", byLine: "byLine2", timeStamp: 200, url: "http://article2", relatedImages: [RelatedImage(id: 1, width: 0, height: 0, url: "http://image1"), RelatedImage(id: 2, width: 5, height: 5, url: "http://image2"), RelatedImage(id: 3, width: 1000, height: 100, url: "http://image3")], displayImageURL: nil)
        article3 = Article(headline: "article3", theAbstract: "theAbstract3", byLine: "byLine3", timeStamp: 300, url: "http://article3", relatedImages: [RelatedImage(id: 1, width: 0, height: 0, url: "http://image1")], displayImageURL: nil)
    }

    override func tearDown() {
        viewModel = nil
        mockServiceConfiguration = nil
        mockRequest = nil
        mockOperation = nil
        mockService = nil
        mockResponse = nil
        super.tearDown()
    }

    //Test the image that has zero width * height get discarded
    func testZeroSizeImage() {
        mockOperation.mockArticleCollection = ArticleCollection(displayName: "ArticleTest", assets: [article3])
        viewModel.loadArticles(operation: mockOperation)

        XCTAssertNil(viewModel.articles.first?.displayImageURL)
    }

    //Test the articles sort in the order based on timeStamp
    func testTimeStampSorting() {
        mockOperation.mockArticleCollection = ArticleCollection(displayName: "ArticleTest", assets: [article1, article2, article3])
        viewModel.loadArticles(operation: mockOperation)

        XCTAssertEqual(viewModel.articles.first?.headline, article3.headline)
    }

    //Test the articles from response is empty
    func testEmptyArticles() {
        mockOperation.mockArticleCollection = ArticleCollection(displayName: "ArticleTest", assets: [])
        viewModel.loadArticles(operation: mockOperation)

        XCTAssertTrue(viewModel.articles.isEmpty)
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
