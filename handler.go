package main

import (
	"bufio"
	"os"
	"flag"
	"fmt"
)

func main() {

	filename := flag.String("filename", "/scripts/consul_watch.log", "file path")
	flag.Parse()

	f, err := os.OpenFile(*filename, os.O_CREATE | os.O_APPEND | os.O_WRONLY, 0600)
	if err != nil {
		panic(err)
	}

	scanner := bufio.NewScanner(os.Stdin)
	scanner.Split(bufio.ScanWords)

	for scanner.Scan() {
		input := scanner.Text()
		if _, err = f.WriteString(input + "\n"); err != nil {
			panic(err)
		}
	}

	if err := scanner.Err(); err != nil {
		fmt.Println(err)
		os.Exit(1)
	}
}
