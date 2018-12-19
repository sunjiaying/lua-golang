package main

import (
	"fmt"

	mymodules "./mymodules"
	libs "github.com/vadv/gopher-lua-libs"
	"github.com/yuin/gopher-lua"
)

func main() {
	// Bring up a GopherLua VM
	L := lua.NewState()
	defer L.Close()

	mymodules.Preload(L)
	libs.Preload(L)

	if err := L.DoFile("web.lua"); err != nil {
		panic(err)
	}

	// 这里是一个对象参数，为模拟传入对象
	objson := `{"a":"test"}`

	// 获取当前待处理节点的选项
	if err := L.CallByParam(lua.P{
		Fn:      L.GetGlobal("getoption"),
		NRet:    1,
		Protect: true,
	}, lua.LString(objson)); err != nil {
		panic(err)
	}
	if str, ok := L.Get(-1).(lua.LString); ok {
		fmt.Println(str)
	}

	L.Pop(1)

	// 当前节点动作处理
	if err := L.CallByParam(lua.P{
		Fn:      L.GetGlobal("actiondo"),
		NRet:    1,
		Protect: true,
	}, lua.LString(objson)); err != nil {
		panic(err)
	}
	if str, ok := L.Get(-1).(lua.LString); ok {
		fmt.Println(str)
	}
	L.Pop(1)
}
