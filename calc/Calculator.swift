//
//  Calculator.swift
//  calc
//
//  Created by Jacktator on 31/3/20.
//  Copyright © 2020 UTS. All rights reserved.
//

import Foundation

class Calculator {
    
    /// For multi-step calculation, it's helpful to persist existing result
    var operators = ["+", "-", "x", "/", "%"];
    
    
    
    var args: [String] = [];
    var inputSize: Int = 0;
    var result = 0;
    
    init(args: [String]) {
        self.args = args;
        self.inputSize = args.count;
    }
    
    /// Perform Addition
    ///
    /// - Author: Jacktator
    /// - Parameters:
    ///   - no1: First number
    ///   - no2: Second number
    /// - Returns: The addition result
    ///
    /// - Warning: The result may yield Int overflow.
    /// - SeeAlso: https://developer.apple.com/documentation/swift/int/2884663-addingreportingoverflow
    
    
    func validateInputLen() -> Bool {
        if (inputSize % 2 == 1 && inputSize >= 1) {
            return true;
        }
        return false;
    }
    
    func validateOpsType() -> Bool {
        for i in 0...(inputSize - 1) {
            if (i % 2 == 1 && !operators.contains(args[i])) {
                return false;
            }
            else if (i % 2 == 0 && Int(args[i]) == nil) {
                return false;
            }
        }
        return true;
    }
    
    
    func validateInputAll() -> Bool {
        let validInputNum: Bool = validateInputLen();
        let validInputOps: Bool = validateOpsType();
        
        if (validInputNum && validInputOps) {
            return true;
        }
        return false;
        
    }
    
    
    func calculate() -> String {
        // Todo: Calculate Result from the arguments. Replace dummyResult with your actual result;
        // Invalid returns exit(1)
        if (!validateInputAll()) {
            exit(1);
        }
        if (args.count == 1) { return args[0]; }
        var result: Int = 0;
        var stack: [String] = [];
        var i: Int = 0;
        while i < inputSize {
            var j: Int = i;
            if (args[i] == "x" || args[i] == "/" || args[i] == "%") {
                stack.removeLast();
                var tempResult: Int = Int(args[j - 1])!;
                while (args[j] != "+" && args[j] != "-" && j <= inputSize - 2){
                    if (args[j] == "x") {
                        tempResult *= Int(args[j + 1])!;
                    }
                    else if (args[j] == "/") {
                        if (args[j + 1] == "0") { exit(1); }
                        tempResult /= Int(args[j + 1])!;
                    }
                    else if (args[j] == "%") {
                        if (args[j + 1] == "0") { exit(1); }
                        tempResult %= Int(args[j + 1])!;
                    }
                    
                    j += 2;
                }
                stack.append(String(tempResult));
            
            }
            i = j;
            if (j < inputSize) { stack.append(args[i]); }
            i += 1;
        }
        result = Int(stack[0])!;
        
        if (stack.count == 1) { return String(result); }
        
        for k in 1...stack.count - 2 {
            if (stack[k] == "+") {
                result += Int(stack[k + 1])!;
            }
            else if (stack[k] == "-") {
                result -= Int(stack[k + 1])!;
            }
        }
        return String(result);
        
        
    }
}
