import Testing
import Foundation
@testable import LicenseKitCore

@Suite("WorkspaceState V4 Decoding Tests")
struct WorkspaceStateV4Tests {
    
    @Test
    func testVersion() throws {
        private var decoder = JSONDecoder()
        
        let jsonWorkspaceState = """
        
        """
    }
}

// FIXME: 대충 AI로 검증, 추후 TestCase 작성 후 지울 것.

//import Testing
//import Foundation
//@testable import LicenseKit
//@testable import LicenseKitCore // 👈 WorkspaceState 구조체들이 속한 모듈을 import 합니다.
//
//@Suite("WorkspaceState V4 디코딩 종합 테스트")
//struct WorkspaceStateV4Tests {
//    
//    private var decoder: JSONDecoder {
//        return JSONDecoder()
//    }
//    
//    // MARK: - 1. Version 4 전체 디코딩 & State (local) & PackageReference (location)
//    @Test("Version 4 전체 구조 및 Local 상태, PackageReference(location) 디코딩 검증")
//    func testV4VersionAndLocalStateWithLocation() throws {
//        let jsonString = """
//        {
//          "version": 4,
//          "object": {
//            "dependencies": [
//              {
//                "packageRef": {
//                  "identity": "mylocallibrary",
//                  "kind": "fileSystem",
//                  "location": "/Users/hosung/Projects/MyLocalLibrary",
//                  "name": "MyLocalLibrary"
//                },
//                "subpath": "mylocallibrary",
//                "basedOn": null,
//                "state": {
//                  "name": "local"
//                }
//              }
//            ],
//            "artifacts": []
//          }
//        }
//        """
//        let data = Data(jsonString.utf8)
//        let state = try decoder.decode(WorkspaceState.self, from: data)
//        
//        // 최상위 enum이 v4인지 확인
//        guard case .v4(let v4Data) = state else {
//            Issue.record("WorkspaceState가 V4 케이스로 파싱되지 않았습니다.")
//            return
//        }
//        
//        #expect(v4Data.version == 4)
//        #expect(v4Data.object.dependencies.count == 1)
//        
//        let dependency = v4Data.object.dependencies[0]
//        #expect(dependency.packageRef.identity == "mylocallibrary")
//        #expect(dependency.packageRef.name == "MyLocalLibrary")
//        
//        // PackageReference에서 location 필드가 정상 파싱되었는지 검증
//        #expect(dependency.packageRef.location == "/Users/hosung/Projects/MyLocalLibrary")
//        
//        // State 열거형이 .fileSystem으로 정상 변환되는지 검증
//        if case .fileSystem = dependency.state {
//            // 통과
//        } else {
//            Issue.record("Dependency 상태가 .fileSystem이 아닙니다.")
//        }
//    }
//    
//    // MARK: - 2. PackageReference (path) 호환성 검증
//    @Test("PackageReference에서 location 대신 path 필드가 제공될 때의 디코딩 호환성 검증")
//    func testPackageReferencePathFallback() throws {
//        let jsonString = """
//        {
//          "version": 4,
//          "object": {
//            "dependencies": [
//              {
//                "packageRef": {
//                  "identity": "oldlibrary",
//                  "kind": "fileSystem",
//                  "path": "/Users/hosung/Projects/OldPathLibrary",
//                  "name": "OldLibrary"
//                },
//                "subpath": "oldlibrary",
//                "basedOn": null,
//                "state": {
//                  "name": "local"
//                }
//              }
//            ],
//            "artifacts": []
//          }
//        }
//        """
//        let data = Data(jsonString.utf8)
//        let state = try decoder.decode(WorkspaceState.self, from: data)
//        
//        guard case .v4(let v4Data) = state else {
//            Issue.record("V4 파싱 실패")
//            return
//        }
//        
//        // 'path'로 들어온 주소가 구조체의 'location' 프로퍼티에 잘 안착했는지 검증
//        let dependency = v4Data.object.dependencies[0]
//        #expect(dependency.packageRef.location == "/Users/hosung/Projects/OldPathLibrary")
//    }
//    
//    // MARK: - 3. State (checkout) & CheckoutState 검증
//    @Test("SourceControlCheckout 상태 및 CheckoutState 필드 디코딩 검증")
//    func testCheckoutStateDecoding() throws {
//        let jsonString = """
//        {
//          "version": 4,
//          "object": {
//            "dependencies": [
//              {
//                "packageRef": {
//                  "identity": "alamofire",
//                  "kind": "remoteSourceControl",
//                  "location": "https://github.com/Alamofire/Alamofire.git",
//                  "name": "Alamofire"
//                },
//                "subpath": "Alamofire",
//                "basedOn": null,
//                "state": {
//                  "name": "checkout",
//                  "checkoutState": {
//                    "revision": "7236944e65507877e1f964096d2466085a6cfec6",
//                    "branch": "main",
//                    "version": "5.9.1"
//                  }
//                }
//              }
//            ],
//            "artifacts": []
//          }
//        }
//        """
//        let data = Data(jsonString.utf8)
//        let state = try decoder.decode(WorkspaceState.self, from: data)
//        
//        guard case .v4(let v4Data) = state else {
//            Issue.record("V4 파싱 실패")
//            return
//        }
//        
//        let dependency = v4Data.object.dependencies[0]
//        
//        // State.sourceControlCheckout 바인딩 및 내부 CheckoutState 값 검증
//        if case .sourceControlCheckout(let checkoutState) = dependency.state {
//            #expect(checkoutState.revision == "7236944e65507877e1f964096d2466085a6cfec6")
//            #expect(checkoutState.branch == "main")
//            #expect(checkoutState.version == "5.9.1")
//        } else {
//            Issue.record("Dependency 상태가 .sourceControlCheckout이 아닙니다.")
//        }
//    }
//    
//    // MARK: - 4. Dependency basedOn (Recursive / IndirectDependency) 검증
//    @Test("Dependency 내부에 basedOn 데이터가 재귀적(Indirect)으로 존재할 때의 디코딩 검증")
//    func testRecursiveBasedOnDecoding() throws {
//        let jsonString = """
//        {
//          "version": 4,
//          "object": {
//            "dependencies": [
//              {
//                "packageRef": {
//                  "identity": "alamofire",
//                  "kind": "remoteSourceControl",
//                  "location": "https://github.com/Alamofire/Alamofire.git",
//                  "name": "Alamofire"
//                },
//                "subpath": "Alamofire",
//                "state": {
//                  "name": "edited",
//                  "path": "/Users/hosung/Projects/Edited/Alamofire"
//                },
//                "basedOn": {
//                  "packageRef": {
//                    "identity": "alamofire",
//                    "kind": "remoteSourceControl",
//                    "location": "https://github.com/Alamofire/Alamofire.git",
//                    "name": "Alamofire"
//                  },
//                  "subpath": "Alamofire",
//                  "basedOn": null,
//                  "state": {
//                    "name": "local"
//                  }
//                }
//              }
//            ],
//            "artifacts": []
//          }
//        }
//        """
//        let data = Data(jsonString.utf8)
//        let state = try decoder.decode(WorkspaceState.self, from: data)
//        
//        guard case .v4(let v4Data) = state else {
//            Issue.record("V4 파싱 실패")
//            return
//        }
//        
//        let dependency = v4Data.object.dependencies[0]
//        
//        // 최상위 상태는 edited 상태여야 함
//        if case .edited(let path) = dependency.state {
//            #expect(path == "/Users/hosung/Projects/Edited/Alamofire")
//        } else {
//            Issue.record("상위 상태가 .edited가 아닙니다.")
//        }
//        
//        // basedOn 내부 데이터가 재귀적으로 잘 매칭되었는지 검증
//        guard let indirectBasedOn = dependency.basedOn, case let .value(basedOnDependency) = indirectBasedOn else {
//            Issue.record("basedOn 백업 데이터가 파싱되지 않았습니다.")
//            return
//        }
//        
//        #expect(basedOnDependency.packageRef.identity == "alamofire")
//        if case .fileSystem = basedOnDependency.state {
//            // 통과
//        } else {
//            Issue.record("basedOn 내부의 state가 .fileSystem(local)으로 파싱되지 않았습니다.")
//        }
//    }
//    
//    // MARK: - 5. Artifact 및 Source (Local & Remote) 종합 검증
//    @Test("Artifact와 Source(local 및 remote 종류별) 디코딩 기능 검증")
//    func testArtifactAndSourceDecoding() throws {
//        let jsonString = """
//        {
//          "version": 4,
//          "object": {
//            "dependencies": [],
//            "artifacts": [
//              {
//                "packageRef": {
//                  "identity": "localbinary",
//                  "kind": "fileSystem",
//                  "location": "/path/to/binary",
//                  "name": "LocalBinary"
//                },
//                "targetName": "LocalTarget",
//                "path": "/artifacts/local.xcframework",
//                "source": {
//                  "type": "local",
//                  "checksum": "abc123local"
//                }
//              },
//              {
//                "packageRef": {
//                  "identity": "remotebinary",
//                  "kind": "registry",
//                  "location": "remotebinary",
//                  "name": "RemoteBinary"
//                },
//                "targetName": "RemoteTarget",
//                "path": "/artifacts/remote.xcframework",
//                "source": {
//                  "type": "remote",
//                  "url": "https://example.com/binary.zip",
//                  "checksum": "xyz789remote"
//                }
//              }
//            ]
//          }
//        }
//        """
//        let data = Data(jsonString.utf8)
//        let state = try decoder.decode(WorkspaceState.self, from: data)
//        
//        guard case .v4(let v4Data) = state else {
//            Issue.record("V4 파싱 실패")
//            return
//        }
//        
//        #expect(v4Data.object.artifacts.count == 2)
//        
//        // 1) 첫 번째 Local Artifact 검증
//        let localArtifact = v4Data.object.artifacts[0]
//        #expect(localArtifact.targetName == "LocalTarget")
//        #expect(localArtifact.path == "/artifacts/local.xcframework")
//        if case .local(let checksum) = localArtifact.source {
//            #expect(checksum == "abc123local")
//        } else {
//            Issue.record("첫 번째 artifact의 소스가 .local이 아닙니다.")
//        }
//        
//        // 2) 두 번째 Remote Artifact 검증
//        let remoteArtifact = v4Data.object.artifacts[1]
//        #expect(remoteArtifact.targetName == "RemoteTarget")
//        if case .remote(let url, let checksum) = remoteArtifact.source {
//            #expect(url == "https://example.com/binary.zip")
//            #expect(checksum == "xyz789remote")
//        } else {
//            Issue.record("두 번째 artifact의 소스가 .remote가 아닙니다.")
//        }
//    }
//}
