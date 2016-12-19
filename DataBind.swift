//
//  DataBind.swift
//  DataBind
//
//  Created by Alex Hartwell on 8/8/16.
//  Copyright © 2016 Alex Hartwell. All rights reserved.
//

import Foundation
import UIKit



class DataBind<T> {
    static func getBindee(_ listener: DataBindListener<T>) -> DataBindee<T> {
        let bindee = DataBindee<T>(callback: listener);
        return bindee;
    }
}

class DataBindListener<A> {
    var callback: (A) -> ()
    init (listener: @escaping (A) -> ()) {
        self.callback = listener;
    }
}

class DataBindee<T> {
    weak var listener: DataBindListener<T>?
    init(callback: DataBindListener<T>) {
        self.listener = callback;
    }
    
}

////How to use
/*
 
 
    class Model {
        var dataBindedInt: DataBindType<Int> = DataBindType<Int>(value: 0);
    }
 
    class Controller {
 
        var model = Model();
        
        override func loadView() {
            super.loadView();
            self.model.dataBindedInt.addBindee({
                [unowned self] newValue in 
                self.onDataBindedIntChange(newInt: newValue);
            });
        }
 
 
        func onDataBindedIntChange(newInt: Int) {
            print("got the new int");
        }
 
 
    }
 
 
 
 
 */



class DataBindType<T> {
    
    private var listeners: [DataBindListener<T>] = [];
    
    var value: T {
        didSet {
            if !dontRun {
                for bindee in bindees {
                    bindee.listener?.callback(self.value);
                }
            }
            self.dontRun = false;
        }
    };
    
    var bindees: [DataBindee<T>] = [];
    var dontRun: Bool = false;
    
    init(value: T) {
        self.value = value;
    }
    
    func addBindee(_ callback: @escaping (T) -> ()) {
        let listener: DataBindListener<T> = DataBindListener<T>(listener: callback);
        self.listeners.append(listener);
        let bindee = DataBind.getBindee(listener);
        self.bindees.append(bindee);
    }
    
    func addBindee(_ callback: @escaping (T) -> (), runListener: Bool) {
        self.addBindee(callback);
        if (runListener) {
            callback(self.value);
        }
    }
    
    func set(_ value: T) {
        self.value = value;
    }
    
    func set(_ value: T, dontRun: Bool) {
        self.dontRun = dontRun;
        self.value = value;
    }
    
    
    func get() -> T {
        return self.value;
    }
    
    
}
