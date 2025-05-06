import sequtils,strutils

func processLine*(line: string): tuple[answer: int, components: seq[int]]= # '*' exports the function
    let sides = line.split(": ") # Uniform function call syntax
    let answer = sides[0].parseInt()
    let components = sides[1].split(" ").map(parseInt) # chaining function calls
    return (answer,components)

func tryComponents*(answer:int,components: seq[int]): bool= # seq is dynamic array
    let temp_result = components[0]

    proc trial(temp_result:int,component_index:int): bool= # proc is a function that can have sideEffects and capture variables in scope
        let component = components[component_index]
        let sum = temp_result + component
        let product = temp_result * component

        if component_index == components.high: #Highest index of components
            if sum == answer or product == answer:
                return true
            else:
                return false

        if sum > answer:
            return false
        elif trial(sum,component_index+1):
            return true

        if product > answer:
            return false
        elif trial(product,component_index+1):
            return true

    return trial(temp_result,1)

func level1*(input: string): int=
    var sum = 0
    for line in input.splitLines():
        let (answer,components) = processLine(line)
        let success = tryComponents(answer,components)
        if success:
            sum += answer
    return sum

proc getInput*(filename: string): string=
    result = readFile("input/" & filename)
    result.stripLineEnd()