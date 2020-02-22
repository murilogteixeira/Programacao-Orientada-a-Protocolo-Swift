import Foundation

// MARK: - Protocolos como Tipos

protocol RandomNumberGenerator {
    func random() -> Double
}

class LinearCongruentialGenerator: RandomNumberGenerator {
    var lastRandom = 42.0
    let m = 139968.0
    let a = 3877.0
    let c = 29573.0
    
    func random() -> Double {
        lastRandom = ((lastRandom * a + c)
            .truncatingRemainder(dividingBy: m))
        return lastRandom / m
    }
}

class Qualquer {
    let lados: Int
    let gerador: RandomNumberGenerator
    init(lados: Int, gerador: RandomNumberGenerator) {
        self.lados = lados
        self.gerador = gerador
    }
    
    func roll() -> Int {
        return Int(gerador.random() * Double(lados)) + 1
    }
}

var d6 = Qualquer(lados: 6, gerador: LinearCongruentialGenerator())
for _ in 1...5 {
    print("Random: \(d6.roll())")
}

// MARK: - Herança de protocolos

protocol Writable {
    func write()
}

protocol Deletable {
    func destroy()
}

protocol FileHandlerProtocol: Writable, Deletable { }

// MARK: - Protocol Composition

protocol FileHandlerReadable {
    func read() -> String
}

protocol FileHandlerWritable {
    func write(_ string: String)
}

typealias FileHandlerType = FileHandlerReadable & FileHandlerWritable

struct FileHandler: FileHandlerType {
    func read() -> String {
        return ""
    }
    
    func write(_ string: String) {
        
    }
}

let handler: FileHandlerType = FileHandler()

handler.read()
handler.write("Hello")

// MARK: - Protocol Extensions

let nomes = ["Murilo", "Felipe"]
let sobrenomes = Set(["Teixeira", "Gonçalves"])
extension Collection {
    func summarize() {
        print("Existem \(count) elementos")
        
        for name in self {
            print(name)
        }
    }
}

nomes.summarize()
sobrenomes.summarize()

// MARK: - Default Implementation

protocol Animal {
    func makeNoise()
}

extension Animal {
    func makeNoise() {
        print("Bark!")
    }
}

struct Dog: Animal {}

let bob = Dog()
bob.makeNoise()
