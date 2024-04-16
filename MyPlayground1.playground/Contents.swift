import UIKit

struct State: OptionSet {
    let rawValue: Int
    static let authen = State(rawValue: 1 << 0)
    static let payment = State(rawValue: 1 << 1)
    static let moment = State(rawValue: 1 << 2)
}

// clear mean state
extension State: CustomStringConvertible {
    static public var debugDescriptions: [(Self, String)] = [
        (.authen, "authen module"),
        (.payment, "payment module"),
        (.moment, "moment module")
    ]
    
    public var description: String {
        let result: [String] = Self.debugDescriptions
            .filter { contains($0.0) }
            .map { $0.1 }
        let printable = result.joined(separator: ", ")
        
        return "\(printable.isEmpty ? "state is nil" : printable)"
    }
}


// khởi tạo
struct MainState {
    var state: State = [.authen]
}

var main = MainState()

// track state
print("""
    state: \(main.state),
    empty: \(main.state.isEmpty),
    contain authen: \(main.state.contains(.payment))\n
    """)

// test remote liên tục để check crash
main.state.remove(.authen)
main.state.remove(.authen)
main.state.remove(.authen)
main.state.remove(.authen)
main.state.remove(.authen)
main.state.remove(.authen)

// track state
print("""
    state: \(main.state),
    empty: \(main.state.isEmpty),
    contain authen: \(main.state.contains(.payment))\n
    """)
