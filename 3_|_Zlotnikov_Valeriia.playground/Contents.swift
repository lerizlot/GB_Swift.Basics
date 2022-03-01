import Foundation

/*
 1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar.
 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
 6. Вывести значения свойств экземпляров в консоль.
 */


// 3
enum EngineState: String {
    case on = "On"
    case off = "Off"
}

enum WindowState: String {
    case open = "Open"
    case closed = "Closed"
}

enum LoadState {
    case load( weight: Int)
    case unload (weight: Int)
}

// 1, 2
enum TrunkCarModels {
    case Volkswagen, Porsche, Toyota
}
enum SportCarModels {
    case Nissan, Mazda, Ford
}

struct SportCar {
    var model: String
    var year: Int
    var trunkCapacity: Int = 0
    var loadState: LoadState
    
// 4
mutating func loadAction(action state: LoadState , weight: Int) {
        switch state {
        case .load:
            self.trunkCapacity += weight
        case .unload:
            self.trunkCapacity -= weight
        }
    }
    
    
    var engineState: EngineState
    
    mutating func engineAction(state: EngineState) {
        switch state {
        case .on:
            if self.engineState == .on {
                print("Engine is started already.")
            } else {
                self.engineState = .on
                print("Engine is on.")
            }
        case .off:
            if self.engineState == .off {
                print("Engine is started already.")
            } else {
                self.engineState = .off
                print("Engine is off.")
            }
        }
    }
    
    var windowState: WindowState
    
    mutating func windowAction(state: WindowState) {
        switch state {
        case .open:
            if self.windowState == .open {
                print("Window is already open.")
            } else {
                self.windowState = .open
                print("Window is open.")
            }
        case .closed:
            if self.windowState == .closed {
                print("Window is already closed.")
            } else {
                self.windowState = .closed
                print("Window is closed.")
            }
        }
    }
    func carState () {
        print("==SportCar info==")
        print("model: Mazda")
        print("year: 2008")
        print("Engine is \(self.engineState)")
        print("Trunk capacity is \(self.trunkCapacity)")
        print("Window is \(self.windowState)")
        print("Trunk is on \(self.loadState) now")
    }
}
// 1, 2
struct TrunkCar {
    var model: String
    var year: Int
    var trunkCapacity: Int
    var engineState: EngineState
    
    
    mutating func engineAction(state: EngineState) {
        switch state {
        case .on:
            if self.engineState == .on {
                print("Engine is started already.")
            } else {
                self.engineState = .on
                print("Engine is on")
            }
        case .off:
            if self.engineState == .off {
                print("Engine is started already.")
            } else {
                self.engineState = .off
                print("Engine is off")
            }
        }
    }
    
    var loadState: LoadState
    
    mutating func loadAction(action state: LoadState , weight: Int) {
        switch state {
        case .load:
            print("You are going to load to the trunk \(weight) kg.")
            let guardAction =  self.trunkCapacity + weight
            guard guardAction < trunkCapacity else {
                print("You can't load this cargo, the trunk is full. \n Operation won't be processed!")
                break
            }
            self.trunkCapacity += weight
            print("After the cargo loaded, your trunk capacity is \(guardAction)")
            
        case .unload:
            print("You are going to unload \(weight) from the trunk.")
            let guardAction = self.trunkCapacity - weight
            guard guardAction > 0 else {
                print("You are trying to unload unavaliable volume of cargo \n Operation won't be processed!")
                break
            }
            self.trunkCapacity -= weight
            print("After the unload, yout trunk capacity is \(guardAction)")
        }
    }
    var windowState: WindowState
    
    // 4
    mutating func windowAction(state: WindowState) {
        switch state {
        case .open:
            self.windowState = .open
            print("Window is open")
        case .closed:
            self.windowState = .closed
            print("Window is closed")
        }
    }
    
    
    // 6
    func carState () {
        print("==Trunk Car info==")
        print("model: Porsche")
        print("year: 2010")
        print("Engine is \(self.engineState)")
        print("Trunk capacity is \(self.trunkCapacity)")
        print("Window is \(self.windowState)")
        print("Trunk is on \(self.loadState) now")
    }
    
}

// 5
var car1 = TrunkCar (model: "Porsche", year: 2010, trunkCapacity: 120, engineState: .on, loadState: .load(weight: 98), windowState: .closed)
var car2 = SportCar (model: "Mazda", year: 2008, trunkCapacity: 80, loadState: .load(weight: 65), engineState: .off, windowState: .open)

//6
car1.carState()
car2.carState()
