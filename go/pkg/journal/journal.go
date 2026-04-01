package journal

import (
	"fmt"
	"os/exec"
	"strings"
	"time"
)

const JournalDateFormat = "2006-01-02"

func Extend(input []string) ([]string, error) {
	numDaysToAdd := 15

	if len(input) < 1 || strings.HasPrefix(input[0], "#") {
		return input, nil
	}

	output := []string{}
	lastNonCommentLine := input[0]
	output = append(output, lastNonCommentLine)
	for _, line := range input[1:] {
		// This assumes that if there is a comment it is at the end of the
		// selection, such as the old calendar. Don't write this back to the
		// file - we'll generate a new calendar.
		if strings.HasPrefix(line, "#") {
			break
		}
		// These are lines we want to write back to the file unchanged.
		output = append(output, line)
		lastNonCommentLine = line
	}

	lastDate, err := time.Parse(JournalDateFormat, trimColonEtc(lastNonCommentLine))
	if err != nil {
		return nil, err
	}

	// Add the new lines to output.
	for range numDaysToAdd {
		lastDate = lastDate.Add(24 * time.Hour)
		newLine := fmt.Sprintf("%s:", lastDate.Format(JournalDateFormat))
		output = append(output, newLine)
	}

	// Add the new calendar comment.
	cal, err := calendar(lastDate)
	if err != nil {
		return nil, err
	}
	output = append(output, comment(cal)...)

	return output, nil
}

// trimColonEtc removes :.* from the end of the line, if a colon is present
func trimColonEtc(line string) string {
	var output []rune
	for _, c := range line {
		if c == ':' {
			break
		}
		output = append(output, c)
	}
	return string(output)
}

// calendar returns the calendar for the given time's month.
func calendar(t time.Time) ([]string, error) {
	d := t.Format("2006-01")
	command := []string{"cal", "-h", "-d", d}
	stdout, err := exec.Command(command[0], command[1:]...).Output()
	if err != nil {
		return nil, err
	}

	stdoutLines := strings.Split(
		strings.TrimRight(string(stdout), " \n"),
		"\n",
	)

	ret := make([]string, len(stdoutLines))

	for i, line := range stdoutLines {
		ret[i] = strings.TrimRight(line, " \n")
	}

	return ret, nil
}

// comment prepends "# " to each input line
func comment(input []string) []string {
	output := make([]string, len(input))
	for i, ln := range input {
		output[i] = fmt.Sprintf("# %s", ln)
	}
	return output
}
