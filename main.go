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

	if err := L.CallByParam(lua.P{
		Fn:      L.GetGlobal("nextnode"),
		NRet:    1,
		Protect: true,
	}, lua.LString(`{"a":"test"}`)); err != nil {
		panic(err)
	}
	if str, ok := L.Get(-1).(lua.LString); ok {
		fmt.Println(str)
	}
	L.Pop(1)
}
