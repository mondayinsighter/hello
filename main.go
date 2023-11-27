package main

import (
	"fmt"
	"os"
)

func main() {
	// 获取系统所有环境变量
	envVars := os.Environ()

	// 打印每个环境变量
	for _, envVar := range envVars {
		fmt.Println(envVar)
	}

	// 退出程序
	os.Exit(0)
}
