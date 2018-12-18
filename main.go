package main

import (
	libs "github.com/vadv/gopher-lua-libs"
	"github.com/yuin/gopher-lua"
)

func main() {
	// Bring up a GopherLua VM
	L := lua.NewState()
	defer L.Close()

	libs.Preload(L)

	if err := L.DoFile("web.lua"); err != nil {
		panic(err)
	}
}
