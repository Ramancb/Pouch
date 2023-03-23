//
//  IDFA.swift
//  Pouch
//
//  Created by Raman choudhary on 10/03/23.
//

import Foundation
import AdSupport
import AppTrackingTransparency

struct Device_ID{
    static func getIDFA() -> String? {
        // Check whether advertising tracking is enabled
        if #available(iOS 14, *) {
            ATTrackingManager.requestTrackingAuthorization { status in
                
            }
        } else {
            if ASIdentifierManager.shared().isAdvertisingTrackingEnabled == false {
                return nil
            }
        }
        return ASIdentifierManager.shared().advertisingIdentifier.uuidString
    }
}
