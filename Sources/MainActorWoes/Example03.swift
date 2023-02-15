import UIKit

public final class Example03: @unchecked Sendable {
    public let text = "Hello, World!"
    
    private var _userInterfaceIdiom: UIUserInterfaceIdiom?
    private let didUpdateDispatchGroup: DispatchGroup // Use this to create a lock on attempts to read _userInterfaceIdiom until `update()` is called.
    
    public var userInterfaceIdiom: UIUserInterfaceIdiom {
        self.didUpdateDispatchGroup.wait()
        return self._userInterfaceIdiom!
    }
    
    public init() {
        
        self.didUpdateDispatchGroup = DispatchGroup()
        self.didUpdateDispatchGroup.enter()
        
        Task { @MainActor in
            self.update()
        }
        
    }
    
    
    @MainActor
    private func update() {
        self._userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        self.didUpdateDispatchGroup.leave()
    }
}
