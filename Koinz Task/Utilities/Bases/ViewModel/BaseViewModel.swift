//
//  BaseViewModel.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import RxSwift
import RxRelay

class BaseViewModel: DisposeObject {
    var stateRelay = BehaviorRelay<ViewModelState<BaseError>>.init(value: .idle)
    var alertItemRelay = BehaviorRelay<AlertItem?>.init(value: nil)
}
