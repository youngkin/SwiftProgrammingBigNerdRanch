import Cocoa

/*
 *  Key Points:
 *  1.  Use of assert() (only results in unrecoverable error in debug mode)
 *  2   Use of precondition() (results in an unrecoverable error in debug & release modes)
 *  3.  Qualifying a type by its module name (e.g., see 'Swift.Error' below)
 *  4.  Use of do/try/catch/throws with qualified 'catch' (e.g., Lexer.Error.invalidCharacter)
 *  5.  Use of 'nil' from an Optional unwrapping in place of 'false' in while loop
 *  6.  Use of 'try!' and 'try?'
 *      i.  'try!' will cause the exception thrown from the expression to be unrecoverable
 *      ii. 'try?' will cause the expection to be ignored
 *      iii.neither is good unless you know exactly what you're doing
 *  7.  There must always be a "catch-all" catch block ('} catch { ... }').
 *      Otherwise the compiler will complain. This allows for new exceptions
 *      to be added without breaking existing code (maybe other reasons too).
 */

enum Token {
    case number(Int)
    case plus
    case minus
}

class Lexer {
    enum Error: Swift.Error {
        case invalidCharacter(char: Character, position: Int)
    }
    
    private let input: String
    private var position: String.Index
    
    init(input: String) {
        self.input = input
        self.position = self.input.startIndex
    }
    
    private func peek() -> Character? {
        guard position < input.endIndex else {
            return nil
        }
        return input[position]
    }
    
    private func advance() {
        assert(position < input.endIndex, "Cannot advance past endIndex!")
        position = input.index(after: position)
    }
    
    private func getNumber() -> Int {
        var value = 0
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                // Another digit - add it into value
                // Note: Forced unwrapping is OK here as we know 'nextCharacter' is a digit
                // Since it matches 'case "0" ... "9":'
                let digitValue = Int(String(nextCharacter))!
                value = 10*value + digitValue
                advance()
                
            default:
                // A nondigit - go back to regular lexing
                return value
            }
        }
        
        return value
    }

    func lex() throws -> [Token] {
        var tokens = [Token]()
        
        while let nextCharacter = peek() {
            switch nextCharacter {
            case "0" ... "9":
                let value = getNumber()
                tokens.append(.number(value))
            case "+":
                tokens.append(.plus)
                advance()
            case "-":
                tokens.append(.minus)
                advance()
            case " ":
                // Just advance to ignore spaces
                advance()
            default:
                throw Lexer.Error.invalidCharacter(char: nextCharacter, position: position.encodedOffset)
            }
        }
        
        return tokens
    }
}

class Parser {
    enum Error: Swift.Error {
        case unexpectedEndOfInput
        case invalidToken(token: Token, position: Int)
    }

    private let tokens: [Token]
    private var position = 0
    
    init(tokens: [Token]) {
        self.tokens = tokens
    }
    
    private func getNextToken() -> Token? {
        guard position < tokens.count else {
            return nil
        }
        let token = tokens[position]
        position += 1
        return token
    }
    
    func getNumber() throws -> Int {
        guard let token = getNextToken() else {
            throw Parser.Error.unexpectedEndOfInput
        }
        
        switch token {
        case .number(let value):
            return value
        case .plus,
             .minus:
            throw Parser.Error.invalidToken(token: token, position: position)
        }
    }

    func parse() throws -> Int {
        // Require a number first
        var value = try getNumber()
        
        while let token = getNextToken() {
            switch token {
                
            // Getting a plus after a number is legal
            case .plus:
                // After a plus or minues, we must get another number
                let nextNumber = try getNumber()
                value += nextNumber
            case .minus:
                let nextNumber = try getNumber()
                value -= nextNumber
            // Getting a number after a number is not legal
            case .number:
                throw Parser.Error.invalidToken(token: token, position: position)
            }
        }
        
        return value
    }

}

func evaluate(expr input: String) {
    print("Evaluating: \(input)")
    let lexer = Lexer(input: input)
    do {
        let tokens = try lexer.lex()
        print("Lexer output: \(tokens)")
        
        let parser = Parser(tokens: tokens)
        let result = try parser.parse()
        print("Parser output: \(result)")
    } catch Lexer.Error.invalidCharacter(let character, let position) {
        print("Input contained an invalid character at position \(position): \(character)")
    } catch Parser.Error.unexpectedEndOfInput {
        print("Unexpected end of input during parsing")
    } catch Parser.Error.invalidToken(let token, let position) {
        print("Invalid token during parsing at index \(position): \(token)")
    } catch {
        print("An error occurred: \(error)")
    }
}

evaluate(expr: "10 + 3 + 5")

print("\n\n Try some invalid characters")
evaluate(expr: "1 + 2 + abcdefg")

print("\n\n Try an invalid expression")
evaluate(expr: "1 + 2 + ")

print("\n\n Try another invalid expression")
evaluate(expr: "1 + 2 + 3 + 5 5")

print("\n\n Try subtraction")
evaluate(expr: "10 + 5 - 3 - 1")
