package mymodules

import (
	mail "./mail"
	wxwork "./wxwork"
	lua "github.com/yuin/gopher-lua"
)

func Preload(L *lua.LState) {
	wxwork.Preload(L)
	mail.Preload(L)
}
