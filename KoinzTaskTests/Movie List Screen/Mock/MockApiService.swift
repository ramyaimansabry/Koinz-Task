//
//  MockApiService.swift
//  KoinzTaskTests
//
//  Created by Ramy Sabry on 20/05/2022.
//

@testable import Koinz_Task
import RxSwift

final class MockValidApiService: DisposeObject, APIServiceContract {
    var fileName: String = ""
    
    func request<T>(
        using request: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder,
        retry: Int
    ) -> Observable<Result<T, BaseError>> where T: Decodable {
        
        let testBundle = Bundle(for: type(of: self))
        guard let path = testBundle.path(forResource: fileName, ofType: "json") else {
            fatalError("\n\nplease add \(fileName).json")
        }
        let fileURL = URL(fileURLWithPath: path)
        
        do {
            let data = try Data(contentsOf: fileURL)
            let response = try decoder.decode(T.self, from: data)
            
            return Observable<Result<T, BaseError>>.just(
                .success(response)
            )
        } catch {
            return Observable<Result<T, BaseError>>.just(
                .failure(MockData.invalidMapping)
            )
        }
    }
}

final class MockInValidApiService: DisposeObject, APIServiceContract {
    func request<T>(
        using request: URLRequest,
        responseType: T.Type,
        decoder: JSONDecoder,
        retry: Int
    ) -> Observable<Result<T, BaseError>> where T: Decodable {
        return Observable<Result<T, BaseError>>.just(
            .failure(MockData.unexpectedError)
        )
    }
}
