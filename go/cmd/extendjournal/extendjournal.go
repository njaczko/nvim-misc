package main

import (
	"fmt"

	"jaczko.com/golang-vim-scripts/pkg/journal"
	"jaczko.com/golang-vim-scripts/pkg/pipe"
)

// extendjournal adds empty dated entry lines and a fresh calendar to a YAML
// journal file. For example, if the command is run in with the following lines
// selected:
//
// 2026-03-12: hello world
// 2026-03-13: foo bar baz
//
// Those lines would be replaced with:
//
// 2026-03-12: hello world
// 2026-03-13: foo bar baz
// 2026-03-14:
// 2026-03-15:
// 2026-03-16:
// 2026-03-17:
// #      March 2026
// # Su Mo Tu We Th Fr Sa
// #  1  2  3  4  5  6  7
// <snip>
//
// Install this cmd with `go install`, then run this from Neovim with a command like this:
//
//	command -range ExtendJournal <line1>,<line2>!extendjournal
func main() {
	input, err := pipe.ReadInput()
	if err != nil {
		// TODO need to figure out how to write the errors to the command message and
		// only send stdout to the file. Writing to stderr also ends up in the file.
		panic(err)
	}
	output, err := journal.Extend(input)
	if err != nil {
		panic(err)
	}
	for _, ln := range output {
		fmt.Println(ln)
	}

}
