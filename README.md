# MainActorWoes

This package demonstrates some challenges in accessing MainActor bound properties.  For example purposes, I'm using `UIUserInterfaceIdiom`, but it be any property that is `@MainActor` bound.


* Example01 - shows how the naive approach forces `@MainActor` onto all intializers, which is not something we always want or can do.

* Example02 - simply demonstrates that MainActor isolation is a compile time failure when struct concurrency checking is enabled

* Example03 - demonstrates a one approach in not requiring `@MainActor` for the initializer.  It has the unfortunate side-effect of *requiring* not being on the main thread.

* MainActorWoesTests - demonstrates how these examples might look at the call-site and in unit tests.

