
// NOTE: Implement later as needed
open class Log {
    static public func w(_ str: String) {
        NSLog("[WARN] \(str)")
    }
    
    static public func i(_ str: String) {
        NSLog("[INFO] \(str)")
    }
    
    static public func d(_ str: String) {
        NSLog("[DEBUG] \(str)")
    }
    
    static public func t(_ str: String) {
        i("***** \(str)")
    }
}
