package pipe

import (
	"bufio"
	"errors"
	"fmt"
	"os"
)

// ReadInput reads the stdin lines, but only if the input was piped in. This is
// handy to prevent the scanner from reading until a terminal newline is
// provided when a pipe isn't being used.
func ReadInput() ([]string, error) {
	lines := []string{}
	if InputIsFromPipe() {
		scanner := bufio.NewScanner(os.Stdin)
		for scanner.Scan() {
			line := scanner.Text()
			lines = append(lines, line)
		}
		if err := scanner.Err(); err != nil {
			return nil, fmt.Errorf("Error reading from stdin: %w", err)
		}
		return lines, nil
	}
	return nil, errors.New("no input piped to stdin")
}

func InputIsFromPipe() bool {
	fileInfo, _ := os.Stdin.Stat()
	return fileInfo.Mode()&os.ModeCharDevice == 0
}

func OutputIsPiped() bool {
	fileInfo, _ := os.Stdout.Stat()
	if (fileInfo.Mode() & os.ModeCharDevice) == os.ModeCharDevice { //Terminal
		return false
	}
	return true
}
