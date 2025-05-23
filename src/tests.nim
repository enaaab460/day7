import unittest,strutils,sequtils,strformat
import lib

suite "processInput": # templates can look like code blocks
    let input = getInput("test1.txt")
    let lines = input.splitLines()
    test "parse line 1":
        let (answer,components) = processLine(lines[0])
        check answer == 190 # functions/templates/macros can skip brackets 
        check components == @[10,19] # @[] represents sequence/dynamic array
    
    test "tryComponents":
        check tryComponents(190,@[10,19]) == true

    suite "all lines":
        var results = repeat(false,lines.len) # initiating sequence with false
        for r in [0,1,8]: results[r] = true # setting the true results as the example
        var counter = 0
        test &"line {counter}": # &"line {counter}" is a string format
            for line in lines:
                let (answer,components) = processLine(line)
                check tryComponents(answer,components) == results[counter]
                inc counter

test "level 1":
    let input = getInput("test1.txt")
    check level1(input) == 3749

proc redditLine(n:int,result:bool,line_num = 0) = # line_num defaults to 0
    test &"reddit test {n}":
        let input = getInput(&"reddit{n}.txt")
        let lines = input.splitLines()
        let (answer,components) = processLine(lines[line_num])
        check tryComponents(answer,components) == result

proc redditLevel1(n:int,result:int) =
    test &"reddit test {n}":
        let input = getInput(&"reddit{n}.txt")
        check level1(input) == result

suite "reddit tests":
    redditLine(1,false)
    redditLevel1(2,30)
    redditLine(3,false)