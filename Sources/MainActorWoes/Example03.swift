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
        
        
        // Option 1:
        Task { @MainActor in
            self.update()
        }
        
        
        // Option 2:
        
        // If there was some way of synchronously "queuing" a task, then this approach would work regardless of whether we run on the main thread or not.  Functionally this might be equivalent to:
        /*
         Task { @MainActor in
             self.update()
         }

        if Thread.isMainThread {
            MainActor.executeAllTasks()     // wish you were here
        }
        */
        
        
        // Option 3:
        
        // If we can provide a hint to the compiler that we know better, this could work too:
        /*
        if Thread.isMainThread {
            MainActor.unsafeExecute {
                self.update()
            }
        } else {
            Task { @MainActor in
                self.update()
            }
        }
        */
    }
    
    
    @MainActor
    private func update() {
        self._userInterfaceIdiom = UIDevice.current.userInterfaceIdiom
        self.didUpdateDispatchGroup.leave()
    }
}
