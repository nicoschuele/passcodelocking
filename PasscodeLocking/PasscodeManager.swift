//
//  PasscodeManager.swift
//  PasscodeLocking
//
//  Created by Nico Schuele on 18.12.16.
//  Copyright © 2016 Nico Schuele. All rights reserved.
//

import UIKit

enum PasscodeError: Error {
    case oldPasscodeNotSupplied
    case oldPasscodeNotMatching
    case passcodeConfirmationNotMatching
}

class PasscodeManager {
    
    static var isUnlocked = false
    
    let passcodeKey = "passcode"
    var userDefaults = UserDefaults.standard
    
    var passcodeExists: Bool {
        let passcode = userDefaults.integer(forKey: passcodeKey)
        return passcode != 0
    }
    
    var passcode: Int? {
        if !passcodeExists {
            return nil
        } else {
            return userDefaults.integer(forKey: passcodeKey)
        }
    }
    
    func setPasscode(passcode code: Int, oldPasscode: Int? = nil) throws {
        if passcodeExists && oldPasscode == nil {
            throw PasscodeError.oldPasscodeNotSupplied
        } else if passcodeExists && oldPasscode != passcode {
            throw PasscodeError.oldPasscodeNotMatching
        }
        
        userDefaults.set(code, forKey: passcodeKey)
    }
    
    func unlock(passcode code: Int) -> Bool {
        if !passcodeExists {
            PasscodeManager.isUnlocked = true
            return true
        }
        PasscodeManager.isUnlocked = code == passcode
        return PasscodeManager.isUnlocked
    }
    
    func lock() {
        PasscodeManager.isUnlocked = false
    }
    
    
}
