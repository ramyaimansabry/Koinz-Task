//
//  DisposeObject.swift
//  Koinz Task
//
//  Created by Ramy Sabry on 19/05/2022.
//

import RxSwift

class DisposeObject {
    var deinitCalled: (() -> Void)?
    var disposeBag: DisposeBag
    
    init() {
        self.disposeBag = DisposeBag()
    }
    
    deinit {
        deinitCalled?()
    }
}
