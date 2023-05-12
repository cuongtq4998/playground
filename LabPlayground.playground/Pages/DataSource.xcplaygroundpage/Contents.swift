//: [Previous](@previous)

import Foundation

protocol PlayerDataSource: NSObjectProtocol {
    func exportLayout(value: String)
}

protocol PlayerDelegate: NSObjectProtocol {
    func getData() -> String
}

protocol PlayerProtocol: PlayerDataSource, PlayerDelegate { }

/// UIView
class PlayerView: NSObject, PlayerProtocol {
    private let valueText: String = "Text Player View"
    
    deinit {
        print("\(#function) Player View")
    }
}

extension PlayerView: PlayerDataSource {
    func exportLayout(value: String) {
        print("View Recieved: \(value)  \n")
    }
}

extension PlayerView: PlayerDelegate {
    func getData() -> String {
        return valueText
    }
}

/// ViewModel
class PlayerViewModel {
    private weak var dataSource: PlayerDataSource?
    private weak var delegate: PlayerDelegate?
    
    private let playerProtocol: PlayerProtocol
    init(playerProtocol: PlayerProtocol) {
        self.playerProtocol = playerProtocol
        
        setDataSource(dataSource: playerProtocol)
        setDelegate(delegate: playerProtocol)
    }
    
    deinit {
        print("\(#function) View Model")
    }
    
    private func setDataSource(dataSource: PlayerDataSource){
        self.dataSource = dataSource
    }
    
    private func setDelegate(delegate: PlayerDelegate){
        self.delegate = delegate
    }
    
    func executeSomething() {
        if let playerTextValue = delegate?.getData() {
            print("View Model Recieved: \(playerTextValue) \n")
        }
        
        dataSource?.exportLayout(value: "View Model Set Text")
    }
}

/// Main
class MainPage {
    private var playerView: PlayerProtocol?
    private var viewModel: PlayerViewModel?
    
    func run(){
        print("Main page: \(#function) \n")
        
        playerView = PlayerView()
        viewModel = PlayerViewModel(playerProtocol: playerView!)
        
        viewModel?.executeSomething()
        
    }
    
    func destroy() {
        playerView = nil
        viewModel = nil
    }
    
}

/// Execute
let main = MainPage()
main.run()

DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
    main.destroy()
}

//: [Next](@next)


