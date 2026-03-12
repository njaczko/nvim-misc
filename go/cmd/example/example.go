package main

import (
	"fmt"
	"os"

	"jaczko.com/golang-vim-scripts/pkg/pipe"
)

// the Vim comman to use this function would be:
// command -range -nargs=* MyCommand <line1>,<line2>!examplecommand <args>
func main() {
	input, err := pipe.ReadInput()
	if err != nil {
		panic(err)
	}
	fmt.Println("Input was:")
	for _, ln := range input {
		fmt.Println(ln)
	}
	fmt.Println("Args were")
	for _, ln := range os.Args {
		fmt.Println(ln)
	}
}
