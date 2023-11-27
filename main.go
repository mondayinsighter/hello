package main

import (
	"fmt"
	"os"
)

func main() {
	envVars := os.Environ()

	for _, envVar := range envVars {
		fmt.Println(envVar)
	}

	os.Exit(0)
}
