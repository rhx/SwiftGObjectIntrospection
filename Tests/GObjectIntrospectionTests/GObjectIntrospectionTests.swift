import XCTest
@testable import GObjectIntrospection

let repository = Repository.default
let glib = "GLib"

final class GObjectIntrospectionTests: XCTestCase {
    override func setUpWithError() throws {
        try repository.require(namespace: glib, version: "2.0", flags: [])
    }

    func testGLib() throws {
        let namespaces = repository.loadedNamespaces
        XCTAssertEqual(namespaces.count, 1)
        guard let namespace = namespaces.first else { return }
        XCTAssertEqual(namespace, glib)
        let infos = repository.getInfos(forNamespace: namespace)
        XCTAssertGreaterThan(infos.count, 860)
    }

    func testInfosPerformance() {
        measure {
            _ = repository.getInfos(forNamespace: glib)
        }
    }
}
