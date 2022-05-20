//
//  MockReachability.swift
//  KoinzTaskTests
//
//  Created by Ramy Sabry on 20/05/2022.
//

@testable import Koinz_Task

final class MockConnectedReachability: ReachabilityContract {
    func isConnectedToNetwork() -> Bool {
        return true
    }
}

final class MockNotConnectedReachability: ReachabilityContract {
    func isConnectedToNetwork() -> Bool {
        return false
    }
}
