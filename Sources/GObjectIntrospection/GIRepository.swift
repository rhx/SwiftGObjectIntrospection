import CGObjectIntrospection

/// Handle for a GIRepository
public struct Repository {
    // Flags for loading a repository
    public typealias LoadFlags = GIRepositoryLoadFlags

    /// Pointer to the underlying GIRepository
    @usableFromInline
    let repository: UnsafeMutablePointer<GIRepository>

    /// Initialise a `GIRepositoryRef` from a pointer to a `GIRepository`
    /// - Parameter ptr: Pointer to the underlying repository
    @inlinable
    public init(_ ptr: UnsafeMutablePointer<GIRepository>) {
        repository = ptr
    }

    /// The default repository
    @inlinable
    public static var `default`: Repository { Repository(g_irepository_get_default()) }

    /// Return an array of all (transitive) versioned dependencies for the given namespace.
    ///
    /// Returned strings are of the form `namespace-version.`
    /// - Note: The namespace must have already been loaded using a method such as `require()` before calling this function.
    /// - Parameter namespace: The name space to look up
    /// - Returns: An array containing the name of the dependencies for the name space
    public func getDependencies(forNamespace namespace: String) -> [String] {
        guard let result = g_irepository_get_dependencies(repository, namespace) else { return [] }
        var dependencies = [String]()
        var i = 0
        while let dependency = result[i] {
            dependencies.append(String(cString: dependency))
            i += 1
        }
        return dependencies
    }
    
    /// Force the namespace `namespace` to be loaded if it isn't already.
    ///
    /// If `namespace` is not loaded, this function will search for a ".typelib" file
    /// using the repository search path.
    /// Optionally, a version of `namespace` may be specified.
    /// If version is not specified, the latest will be used.
    /// - Parameters:
    ///   - namespace: The name space to look up
    ///   - version: The version to look up, if `nil`, the latest version will be used
    ///   - flags: The load flags to use, e.g. `.none`, or `.lazy` for lazy loading
    /// - Returns: A type library or throws an error if it cannot load the name space
    @inlinable
    public func require(namespace: String, version: String? = nil, flags: LoadFlags = .none) throws -> Typelib {
        var error: UnsafeMutablePointer<GError>?
        guard let result = g_irepository_require(repository, namespace, version, flags, &error) else {
            throw error ?? unknownError
        }
        return Typelib(result)
    }
}
