import unittest,strutils,sequtils,strformat
import lib

suite "processInput":
    let input = getInput("test1.txt")
    let lines = input.splitLines()
    test "parse line 1":
        let (answer,components) = processLine(lines[0])
        check answer == 190
        check components == @[10,19]
    
    test "tryComponents":
        check tryComponents(190,@[10,19]) == true

    suite "all lines":
        var results = repeat(false,lines.len)
        for r in [0,1,8]: results[r] = true
        var counter = 0
        test &"line {counter}":
            for line in lines:
                let (answer,components) = processLine(line)
                check tryComponents(answer,components) == results[counter]
                inc counter

test "level 1":
    let input = getInput("test1.txt")
    check level1(input) == 3749

proc redditLine(n:int,line_num = 0,result:bool) =
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
    redditLine(1,0,false)
    redditLevel1(2,30)
    redditLine(3,0,false)