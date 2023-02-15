import UIKit

public final class Example02: Sendable {
    public let text = "Hello, World!"
    public let userInterfaceIdiom: UIUserInterfaceIdiom
    
    public init() {
        // This does not compile as `current` must be referenced on the MainActor
        
//        self.userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        
        self.userInterfaceIdiom = .unspecified
    }
}
