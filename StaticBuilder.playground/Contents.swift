import UIKit

struct Section {
    var didSelectHandler: (() -> Void)?
    init(didSelectHandler: (() -> Void)?) {
        self.didSelectHandler = didSelectHandler
    }
    
    func run() {
        print("\(#function) :: onselect handler!!!")
        didSelectHandler?()
    }
}

class MyClass {
    var section: Section?
    
    func createSections() {
        section = SectionBuilder.make(didSelectHandler: { [weak self] in self?.didSelectHandler() })
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            self.section?.run()
        }
    }
    
    func didSelectHandler() {
        print("\(#function) :: onselect handler!!!")
    }
    
    deinit {
        print("⭕️⭕️⭕️⭕️⭕️⭕️⭕️")
        print("\(#function) :: onselect handler!!!")
        print("⭕️⭕️⭕️⭕️⭕️⭕️⭕️")
    }
}

struct SectionBuilder {
    static func make(didSelectHandler: (() -> Void)?) -> Section {
        return Section(didSelectHandler: didSelectHandler)
    }
}

var myClass: MyClass? = MyClass()
myClass?.createSections()


DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
    print("⭕️⭕️⭕️⭕️⭕️⭕️⭕️")
    myClass = nil
}
