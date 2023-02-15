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
        
        
        // If there was some way of incorporating the following, then this approach would work regardless of whether we run on the main thread or not.
        /*
        if Thread.isMainThread {
            MainActor.executeAllTasks()     // wish you were here
        }
        */
    }
    
    
    @MainActor
    private func update() {
        self._userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        self.didUpdateDispatchGroup.leave()
    }
}
