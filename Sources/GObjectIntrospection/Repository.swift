import CGObjectIntrospection

/// Handle for a GIRepository
public struct Repository {
    /// BaseInfo Collection type
    public struct Infos: RandomAccessCollection {
        @usableFromInline var repository: Repository
        @usableFromInline var namespace: String
        public let startIndex = 0
        public let endIndex: Int
        @usableFromInline init(_ repository: Repository, _ namespace: String) {
            self.repository = repository
            self.namespace = namespace
            endIndex = repository.getNumberOfInfos(forNamespace: namespace)
        }
        /// Return the value at the given index
        @inlinable public subscript(position: Int) -> BaseInfo { repository.getInfo(forNamespace: namespace, atIndex: position)! }
    }

    /// The default repository
    @inlinable
    public static var `default`: Repository { Repository(g_irepository_get_default()) }

    // Flags for loading a repository
    public typealias LoadFlags = GIRepositoryLoadFlags

    /// Pointer to the underlying GIRepository
    @usableFromInline
    let repository: UnsafeMutablePointer<GIRepository>

    /// Return the list of currently loaded namespaces.
    public var loadedNamespaces: [String] {
        guard let result = g_irepository_get_loaded_namespaces(repository) else { return [] }
        var namespaces = [String]()
        var i = 0
        while let namespace = result[i] {
            namespaces.append(String(cString: namespace))
            i += 1
        }
        return namespaces
    }

    /// Initialise a `GIRepositoryRef` from a pointer to a `GIRepository`
    /// - Parameter ptr: Pointer to the underlying repository
    @inlinable
    public init(_ ptr: UnsafeMutablePointer<GIRepository>) {
        repository = ptr
    }

    /// Searches for a particular entry in a namespace.
    ///
    /// Before calling this function for a particular namespace,
    /// you must call `require()` once to load the namespace,
    /// or otherwise ensure the namespace has already been loaded.
    ///
    /// - Parameters:
    ///   - name: The name of the entry to look up
    ///   - namespace: The namespace to search
    /// - Returns: A `BaseInfo` representing metadata about `name` , or `nil`.
    @inlinable
    public func find(name: String, inNamespace namespace: String) -> BaseInfo? {
        g_irepository_find_by_name(repository, namespace, name).map(BaseInfo.typedInfo)
    }

    /// Searches all loaded namespaces for a particular GType.
    ///
    /// Note that in order to locate the metadata,
    /// the namespace corresponding to the type must first have been loaded.
    /// There is currently no mechanism for determining the namespace
    /// that corresponds to an arbitrary GType --
    /// thus, this function will operate most reliably when you know the GType
    /// to originate from be from a loaded namespace.
    ///
    /// - Parameters:
    ///   - name: The name of the entry to look up
    ///   - gType: The type to search for
    /// - Returns: A `BaseInfo` representing metadata about `name` , or `nil`.
    @inlinable
    public func find(gType: GType) -> BaseInfo? {
        g_irepository_find_by_gtype(repository, gType).map(BaseInfo.typedInfo)
    }

    /// Searches all loaded namespaces for a particular GType.
    ///
    /// Note that in order to locate the metadata,
    /// the namespace corresponding to the type must first have been loaded.
    /// There is currently no mechanism for determining the namespace
    /// that corresponds to an arbitrary GType --
    /// thus, this function will operate most reliably when you know the GType
    /// to originate from be from a loaded namespace.
    ///
    /// - Parameters:
    ///   - name: The name of the entry to look up
    ///   - gType: The type to search for
    /// - Returns: A `BaseInfo` representing metadata about `name` , or `nil`.
    @inlinable
    public func find(errorDomain: GQuark) -> EnumInfo? {
        g_irepository_find_by_error_domain(repository, errorDomain).map { EnumInfo($0) }
    }

    /// Return an array of all (transitive) versioned dependencies for the given namespace.
    ///
    /// Returned strings are of the form `namespace-version.`
    /// - Note: The namespace must have already been loaded using a method such as `require()` before calling this method.
    /// - Note: To get only the immediate dependencies for `namespace` , use `getImmediateDependencies(forNamespace:)` instead.
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

    /// Return an array of the immediate versioned dependencies for namespace.
    ///
    /// Returned strings are of the form `namespace-version.`
    /// - Note: The namespace must have already been loaded using a method such as `require()` before calling this method.
    /// - Parameter namespace: The name space to look up
    /// - Returns: An array containing the name of the dependencies for the name space
    public func getImmediateDependencies(forNamespace namespace: String) -> [String] {
        guard let result = g_irepository_get_immediate_dependencies(repository, namespace) else { return [] }
        var dependencies = [String]()
        var i = 0
        while let dependency = result[i] {
            dependencies.append(String(cString: dependency))
            i += 1
        }
        return dependencies
    }

    /// Return the loaded version associated with the given namespace.
    ///
    /// - Note: The namespace must have already been loaded using a function such as g_irepository_require() before calling this function.
    ///
    /// - Parameters:
    ///   - namespace: The namespace to get the version for
    /// - Returns: A String containing the loaded version or `nil` if unavailable
    @inlinable
    public func getNumberOfInfos(forNamespace namespace: String) -> Int {
        Int(g_irepository_get_n_infos(repository, namespace))
    }

    /// This function returns a particular metadata entry in the given namespace.
    ///
    /// See `getNumberOfInfos(forNamespace:)` to find the maximum number of entries.
    ///
    /// - Note: The namespace must have already been loaded using a method such as `require()` before calling this method.
    ///
    /// - Parameters:
    ///   - namespace: The namespace to get the version for
    ///   - index: 0-based offset into namespace metadata
    /// - Returns: A `BaseInfo` representing metadata at `index` or nil
    @inlinable
    public func getInfo(forNamespace namespace: String, atIndex index: Int) -> BaseInfo! {
        g_irepository_get_info(repository, namespace, gint(index)).map(BaseInfo.typedInfo)
    }

    /// This function returns all metadata entries in the given namespace.
    ///
    /// - Note: The namespace must have already been loaded using a method such as `require()` before calling this method.
    ///
    /// - Parameters:
    ///   - namespace: The namespace to get the version for
    ///   - index: 0-based offset into namespace metadata
    /// - Returns: A collection of `BaseInfo` subclasses representing the information for the relevant namespace
    public func getInfos(forNamespace namespace: String) -> Infos {
        return Infos(self, namespace)
    }

    /// Return the loaded version associated with the given namespace.
    ///
    /// - Note: The namespace must have already been loaded using a function such as g_irepository_require() before calling this function.
    ///
    /// - Parameters:
    ///   - namespace: The namespace to get the version for
    /// - Returns: A String containing the loaded version or `nil` if unavailable
    @inlinable
    public func getVersion(forNamespace namespace: String) -> String! {
        g_irepository_get_version(repository, namespace).map(String.init(cString:))
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
    @discardableResult @inlinable
    public func require(namespace: String, version: String? = nil, flags: LoadFlags = .none) throws -> Typelib {
        var error: UnsafeMutablePointer<GError>?
        guard let result = g_irepository_require(repository, namespace, version, flags, &error) else {
            throw error ?? unknownError
        }
        return Typelib(result)
    }
}
