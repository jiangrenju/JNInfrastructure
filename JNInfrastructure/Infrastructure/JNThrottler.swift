//
//  JNThrottler.swift
//  JNInfrastructure
//
//  Created by Renju Jiang on 2019/1/10.
//  Copyright © 2019 jiangrenju. All rights reserved.
//

import Foundation

class JNThrottler {
    
    private var queue: DispatchQueue = DispatchQueue.main
    private var job: DispatchWorkItem = DispatchWorkItem(block: {})
    private var previousRun: Date = Date.distantPast
    private var maxInterval: TimeInterval
    
    init(seconds: TimeInterval, queue: DispatchQueue = DispatchQueue.main) {
        self.maxInterval = seconds
        self.queue = queue
    }
    
    func throttle(block: @escaping () -> ()) {
        job.cancel()
        job = DispatchWorkItem() { [weak self] in
            guard let sself = self else { return }
            sself.previousRun = Date()
            block()
        }
        let delay = Date.second(from: previousRun) > maxInterval ? 0 : maxInterval
        queue.asyncAfter(deadline: .now() + Double(delay), execute: job)
    }
}

fileprivate extension Date {
    static func second(from referenceDate: Date) -> TimeInterval {
        return Date().timeIntervalSince(referenceDate)
    }
}
