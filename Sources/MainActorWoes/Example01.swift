import UIKit

public final class Example01: Sendable {
    public let text = "Hello, World!"

    public let userInterfaceIdiom: UIUserInterfaceIdiom
    
    // While this compiles, it forces all other classes that wish to have an instance of `Example01` to also execute on the MainActor.
   
    @MainActor
    public init() {
        self.userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
    }
}
