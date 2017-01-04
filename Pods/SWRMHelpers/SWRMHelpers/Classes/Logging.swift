//
//  Log.swift
//  Elsewhere
//
//  Created by Alex Hartwell on 12/28/16.
//  Copyright © 2016 SWARM. All rights reserved.
//

import Foundation
import PaperTrailLumberjack




open class SWRMLog {
    static public var shared: SWRMLog = SWRMLog();
    
    public func setUp(host: String, port: UInt, appNamePrefix: String, environmentName: String) {
        let paperTrailLogger = RMPaperTrailLogger.sharedInstance() as RMPaperTrailLogger!
        paperTrailLogger?.host = host
        paperTrailLogger?.port = port //Your port number here
        paperTrailLogger?.programName = "\(appNamePrefix) - \(environmentName)";
        DDLog.add(paperTrailLogger!);
        
    }
    
    public func logVerbose(_ message: String) {
        #if PROD
            
        #else
            print(message);
        #endif
        DDLogVerbose(message);
    }
    
    public func log(_ message: String) {
        #if PROD
            
        #else
            print(message);
        #endif
        DDLogInfo(message);
        
    }
    
    public func logError(_ message: String) {
        #if PROD
            
        #else
            print(message);
        #endif
        DDLogError(message);
    }
    
    
}
