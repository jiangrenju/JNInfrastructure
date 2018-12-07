//
//  JNLinkedHashMap.swift
//  JNLinkedHashMap
//
//  Created by Renju Jiang on 2018/12/6.
//  Copyright © 2018 jiangrenju. All rights reserved.
//

import Foundation

struct JNLinkedHashMap<Key: Hashable, Value> {
    
    private var dictionary: Dictionary<Key, Value>
    
    public private(set) var keys: [Key]
    
    init() {
        dictionary = [:]
        keys = []
    }
    
    init(minimumCapacity: Int) {
        self.dictionary = Dictionary<Key, Value>(minimumCapacity: minimumCapacity)
        self.keys = []
    }
    
    init(dictionary: Dictionary<Key, Value>) {
        self.dictionary = dictionary
        self.keys = dictionary.keys.map({ $0 })
    }
    
    subscript(key: Key) -> Value? {
        set {
            if let v = newValue {
                self.updateValue(v, forKey: key)
            } else {
                self.removeValue(forKey: key)
            }
        }
        
        get {
            return dictionary[key]
        }
    }
    
    public var count: Int { get { return dictionary.count } }
    
    @discardableResult
    public mutating func updateValue(_ value: Value, forKey key: Key) -> Value? {
        let oldValue = dictionary.updateValue(value, forKey: key)
        if oldValue == nil {
            keys.append(key)
        }
        return oldValue
    }
    
    public mutating func removeValue(forKey key: Key) {
        keys = keys.filter { $0 != key }
        dictionary.removeValue(forKey: key)
    }
    
    public mutating func removeAll(keepCapacity: Int = 0) {
        self.keys = []
        self.dictionary = Dictionary<Key, Value>(minimumCapacity: keepCapacity)
    }
    
    public var values: [Value] {
        get {
            let items = self.keys.compactMap({ (k) -> Value? in
                return self.dictionary[k]
            })
            return items
        }
    }
    
}
